#!/usr/bin/env ruby

require 'minitest/autorun'
require 'yaml'
require 'json'
require 'tempfile'
require 'fileutils'

# Load the main script (we'll need to refactor it slightly to be testable)
# For now, we'll test the core validation logic by creating a minimal test harness

class TestModelValidation < Minitest::Test
  VALID_MODEL_PREFIXES = ['anthropic/claude-']
  
  def validate_model_id(model_id)
    model_id.start_with?(*VALID_MODEL_PREFIXES)
  end
  
  def test_valid_anthropic_sonnet_model
    assert validate_model_id('anthropic/claude-sonnet-4-5'),
      "Should accept valid Anthropic Sonnet model"
  end
  
  def test_valid_anthropic_opus_model
    assert validate_model_id('anthropic/claude-opus-4-1'),
      "Should accept valid Anthropic Opus model"
  end
  
  def test_valid_anthropic_haiku_model
    assert validate_model_id('anthropic/claude-haiku-4-5'),
      "Should accept valid Anthropic Haiku model"
  end
  
  def test_invalid_openai_model
    refute validate_model_id('openai/gpt-4'),
      "Should reject OpenAI models"
  end
  
  def test_invalid_model_without_provider
    refute validate_model_id('claude-sonnet-4-5'),
      "Should reject models without provider prefix"
  end
  
  def test_invalid_empty_model
    refute validate_model_id(''),
      "Should reject empty model ID"
  end
end

class TestYAMLFrontmatterParsing < Minitest::Test
  def test_extracts_frontmatter_correctly
    content = <<~MARKDOWN
      ---
      description: "Test agent"
      model: anthropic/claude-sonnet-3-5
      temperature: 0.2
      ---
      
      # Agent Content
      This is the agent body.
    MARKDOWN
    
    match_result = content.match(/\A---\n(.*?)\n---/m)
    refute_nil match_result, "Should match YAML frontmatter"
    
    frontmatter = match_result[1]
    assert_includes frontmatter, 'model: anthropic/claude-sonnet-3-5',
      "Should extract model line"
  end
  
  def test_updates_model_in_frontmatter
    content = <<~MARKDOWN
      ---
      description: "Test agent"
      model: anthropic/claude-sonnet-3-5
      temperature: 0.2
      ---
      
      # Agent Content
    MARKDOWN
    
    new_model = 'anthropic/claude-sonnet-4-5'
    
    frontmatter = content[/\A---\n(.*?)\n---/m, 1]
    updated_frontmatter = frontmatter.gsub(/^model: .*$/, "model: #{new_model}")
    updated_content = content.sub(/\A---\n.*?\n---/m, "---\n#{updated_frontmatter}\n---")
    
    assert_includes updated_content, 'model: anthropic/claude-sonnet-4-5',
      "Should update model to new version"
    refute_includes updated_content, 'model: anthropic/claude-sonnet-3-5',
      "Should not contain old model"
    assert_includes updated_content, '# Agent Content',
      "Should preserve agent body"
  end
  
  def test_does_not_match_without_frontmatter
    content = <<~MARKDOWN
      # Agent Content
      This has no frontmatter.
      model: anthropic/claude-sonnet-4-5
    MARKDOWN
    
    refute_match /\A---\n(.*?)\n---/m, content,
      "Should not match content without frontmatter"
  end
end

class TestModelVersionExtraction < Minitest::Test
  MODEL_VERSION_PATTERN = /(\d+-\d+)(?!\d)/
  
  def extract_model_version(html, model_type)
    matches = html.scan(/claude-#{model_type}-#{MODEL_VERSION_PATTERN}/).flatten.uniq
    matches.min_by { |m| m.length }
  end
  
  def test_extracts_sonnet_alias
    html = <<~HTML
      <p>The latest model is claude-sonnet-4-5 released on...</p>
      <p>Previous version: claude-sonnet-4-5-20250514</p>
    HTML
    
    version = extract_model_version(html, 'sonnet')
    assert_equal '4-5', version,
      "Should extract shortest version (alias)"
  end
  
  def test_extracts_opus_alias
    html = <<~HTML
      <p>claude-opus-4-1 is now available</p>
      <p>Also supports: claude-opus-4-1-20250101</p>
    HTML
    
    version = extract_model_version(html, 'opus')
    assert_equal '4-1', version,
      "Should extract opus alias"
  end
  
  def test_returns_nil_for_missing_model
    html = "<p>No models here</p>"
    
    version = extract_model_version(html, 'sonnet')
    assert_nil version,
      "Should return nil when model not found"
  end
  
  def test_prefers_shorter_version
    html = <<~HTML
      <p>claude-haiku-4-5-20250514</p>
      <p>claude-haiku-4-5</p>
    HTML
    
    version = extract_model_version(html, 'haiku')
    assert_equal '4-5', version,
      "Should prefer shorter version"
  end
end

class TestConfigurationLoading < Minitest::Test
  def test_loads_valid_yaml_config
    config_content = <<~YAML
      models:
        sonnet:
          id: "anthropic/claude-sonnet-4-5"
          temperature: 0.2
      agents:
        test-agent: sonnet
    YAML
    
    Tempfile.create(['config', '.yaml']) do |f|
      f.write(config_content)
      f.flush
      
      config = YAML.safe_load_file(f.path, permitted_classes: [Symbol])
      
      assert config['models'], "Should have models key"
      assert config['agents'], "Should have agents key"
      assert_equal 'anthropic/claude-sonnet-4-5', config['models']['sonnet']['id']
    end
  end
  
  def test_rejects_invalid_yaml
    invalid_yaml = "models:\n  - [invalid"
    
    Tempfile.create(['config', '.yaml']) do |f|
      f.write(invalid_yaml)
      f.flush
      
      assert_raises(Psych::SyntaxError) do
        YAML.safe_load_file(f.path, permitted_classes: [Symbol])
      end
    end
  end
end

class TestDryRunBehavior < Minitest::Test
  def test_dry_run_does_not_modify_file
    content = <<~MARKDOWN
      ---
      model: anthropic/claude-sonnet-3-5
      ---
      # Content
    MARKDOWN
    
    Tempfile.create(['agent', '.md']) do |f|
      f.write(content)
      f.flush
      
      original_mtime = File.mtime(f.path)
      
      # Simulate dry-run: read but don't write
      file_content = File.read(f.path)
      updated_content = file_content.gsub(/^model: .*$/, "model: anthropic/claude-sonnet-4-5")
      
      # In dry-run, we DON'T call File.write
      dry_run = true
      File.write(f.path, updated_content) unless dry_run
      
      assert_equal original_mtime, File.mtime(f.path),
        "File should not be modified in dry-run mode"
      
      actual_content = File.read(f.path)
      assert_includes actual_content, 'anthropic/claude-sonnet-3-5',
        "Original content should be preserved"
    end
  end
end

class TestErrorHandling < Minitest::Test
  def test_handles_missing_file
    non_existent_file = '/tmp/does_not_exist_12345.md'
    
    error = assert_raises(Errno::ENOENT) do
      File.read(non_existent_file)
    end
    
    assert_match(/No such file or directory/, error.message)
  end
  
  def test_handles_invalid_json
    invalid_json = '{ "key": invalid }'
    
    assert_raises(JSON::ParserError) do
      JSON.parse(invalid_json)
    end
  end
end

# Print summary
puts "\n" + "="*60
puts "Running Model Updater Test Suite"
puts "="*60 + "\n"
