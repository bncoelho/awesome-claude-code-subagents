#!/usr/bin/env ruby

require 'yaml'
require 'json'
require 'fileutils'
require 'net/http'
require 'uri'
require 'shellwords'

class AgentModelUpdater
  CONFIG_FILE = '.opencode/model-config.yaml'
  AGENTS_DIR = '.opencode/agent'
  OPENCODE_CONFIG = 'opencode.json'
  VALID_MODEL_PREFIXES = ['anthropic/claude-']
  ANTHROPIC_MODELS_URL = 'https://docs.anthropic.com/en/docs/about-claude/models'
  
  # Model version regex patterns
  MODEL_VERSION_PATTERN = /(\d+-\d+)(?!\d)/
  CURL_TIMEOUT_SECONDS = 10

  def initialize(dry_run: false, check_latest: false)
    @dry_run = dry_run
    @check_latest = check_latest
    
    begin
      @config = YAML.safe_load_file(CONFIG_FILE, permitted_classes: [Symbol])
      @models = @config['models']
      @agent_mappings = @config['agents']
      
      unless @models && @agent_mappings
        abort "❌ Error: Invalid configuration structure in #{CONFIG_FILE}"
      end
    rescue Errno::ENOENT
      abort "❌ Error: Configuration file not found: #{CONFIG_FILE}"
    rescue Psych::SyntaxError => e
      abort "❌ Error: Invalid YAML syntax in #{CONFIG_FILE}: #{e.message}"
    rescue => e
      abort "❌ Error loading configuration: #{e.message}"
    end
    
    @updated_count = 0
    @would_update_count = 0
    @errors = []
    @latest_models = {}
  end

  def run
    puts "🚀 OpenCode Agent Model Updater"
    if @dry_run
      puts "   [DRY RUN MODE - No changes will be made]"
    end
    puts "=" * 60
    puts ""

    # Check for latest models if requested
    if @check_latest
      check_latest_models
      puts ""
    end

    # Display loaded config
    display_config

    # Update agents
    update_agents

    # Update opencode.json
    update_opencode_json unless @dry_run

    # Summary
    display_summary
  end

  private

  def check_latest_models
    puts "🔍 Checking Anthropic documentation for latest models..."
    puts ""
    
    begin
      # Try using curl if available (handles redirects better)
      html = nil
      if system('which curl > /dev/null 2>&1')
        # Use timeout command if available, otherwise rely on curl's built-in timeout
        timeout_cmd = system('which timeout > /dev/null 2>&1') ? "timeout #{CURL_TIMEOUT_SECONDS}" : ""
        curl_cmd = "#{timeout_cmd} curl -sL --max-time #{CURL_TIMEOUT_SECONDS} #{ANTHROPIC_MODELS_URL.shellescape} 2>/dev/null".strip
        html = `#{curl_cmd}`
        if $?.success? && !html.empty?
          # curl succeeded
        else
          html = nil
        end
      end
      
      # Fallback to Net::HTTP if curl not available or failed
      unless html
        uri = URI.parse(ANTHROPIC_MODELS_URL)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.open_timeout = 5
        http.read_timeout = 10
        
        request = Net::HTTP::Get.new(uri.path)
        request['User-Agent'] = 'OpenCode-Agent-Updater/1.0'
        
        response = http.request(request)
        
        unless response.is_a?(Net::HTTPSuccess)
          puts "⚠️  Could not fetch latest models (HTTP #{response.code})"
          puts "   Continuing with configured models..."
          return
        end
        
        html = response.body
      end
      
      # Parse known model patterns from HTML
      # Looking for aliases like: claude-sonnet-4-5, claude-opus-4-1, claude-haiku-4-5
      # Prefer short versions (aliases) over date-stamped versions
      
      # Extract all matches and prefer shortest (alias format)
      sonnet_match = extract_model_version(html, 'sonnet')
      opus_match = extract_model_version(html, 'opus')
      haiku_match = extract_model_version(html, 'haiku')
      
      if sonnet_match
        @latest_models['sonnet'] = "anthropic/claude-sonnet-#{sonnet_match}"
      end
      if opus_match
        @latest_models['opus'] = "anthropic/claude-opus-#{opus_match}"
      end
      if haiku_match
        @latest_models['haiku'] = "anthropic/claude-haiku-#{haiku_match}"
      end
      
      if @latest_models.empty?
        puts "⚠️  Could not parse model information from documentation"
        puts "   Continuing with configured models..."
        return
      end
      
      # Compare with configured models
      puts "📊 Latest Models from Anthropic:"
      @latest_models.each do |family, latest_id|
        configured_id = @models[family] ? @models[family]['id'] : nil
        if configured_id == latest_id
          puts "  ✅ #{family}: #{latest_id} (up-to-date)"
        elsif configured_id
          puts "  ⚠️  #{family}: #{latest_id}"
          puts "      Current: #{configured_id}"
        else
          puts "  ℹ️  #{family}: #{latest_id} (not configured)"
        end
      end
      
    rescue SocketError, Errno::ECONNREFUSED, Net::OpenTimeout => e
      puts "⚠️  Network error checking latest models: #{e.message}"
      puts "   Continuing with configured models..."
    rescue => e
      puts "⚠️  Error checking latest models: #{e.message}"
      puts "   Continuing with configured models..."
    end
  end

  def display_config
    puts "📋 Model Configuration Loaded:"
    puts ""
    @models.each do |family, config|
      puts "  #{family.upcase}: #{config['id']}"
      puts "    └─ #{config['description']}"
    end
    puts ""
    puts "📍 Agent Mappings: #{@agent_mappings.count} agents"
    puts ""
  end

  def extract_model_version(html, model_type)
    matches = html.scan(/claude-#{model_type}-#{MODEL_VERSION_PATTERN}/).flatten.uniq
    matches.min_by { |m| m.length }
  end

  def validate_model_id(model_id, family)
    unless model_id.start_with?(*VALID_MODEL_PREFIXES)
      @errors << "❌ Invalid model ID for #{family}: #{model_id}"
      return false
    end
    true
  end

  def update_agents
    puts "🔄 Updating Agent Files..."
    puts ""

    @agent_mappings.each do |agent_name, model_family|
      unless @models[model_family]
        @errors << "❌ Unknown model family '#{model_family}' for agent '#{agent_name}'"
        next
      end
      
      model_id = @models[model_family]['id']
      temperature = @models[model_family]['temperature']
      
      next unless validate_model_id(model_id, model_family)
      
      # Handle both primary agents and subagents
      agent_files = [
        "#{AGENTS_DIR}/#{agent_name}.md",
        "#{AGENTS_DIR}/subagents/#{agent_name}.md"
      ]
      
      agent_file = agent_files.find { |f| File.exist?(f) }
      
      unless agent_file
        @errors << "❌ Agent file not found for '#{agent_name}'"
        next
      end

      result = update_agent_file(agent_file, model_id, temperature)
      case result
      when :updated
        if @dry_run
          puts "  [WOULD UPDATE] #{agent_name}: #{model_id}"
          @would_update_count += 1
        else
          puts "  ✓ #{agent_name}: #{model_id}"
          @updated_count += 1
        end
      when :unchanged
        # File already up-to-date, not an error
      when :error
        # Error already added to @errors array
      end
    end
    puts ""
  end

  def update_agent_file(file_path, model_id, temperature)
    begin
      content = File.read(file_path)
      
      # Only update within YAML frontmatter (between --- markers)
      unless content =~ /\A---\n(.*?)\n---/m
        @errors << "❌ No YAML frontmatter found in #{file_path}"
        return :error
      end
      
      frontmatter = $1
      updated_frontmatter = frontmatter.gsub(/^model: .*$/, "model: #{model_id}")
      updated_frontmatter = updated_frontmatter.gsub(/^temperature: .*$/, "temperature: #{temperature}")
      
      updated_content = content.sub(/\A---\n.*?\n---/m, "---\n#{updated_frontmatter}\n---")
      
      # Only write if changed
      if updated_content != content
        unless @dry_run
          File.write(file_path, updated_content)
        end
        return :updated
      end
      
      :unchanged
    rescue Errno::ENOENT
      @errors << "❌ File not found: #{file_path}"
      :error
    rescue Errno::EACCES
      @errors << "❌ Permission denied: #{file_path}"
      :error
    rescue => e
      @errors << "❌ Error updating #{file_path}: #{e.message}"
      :error
    end
  end

  def update_opencode_json
    puts "🔧 Updating opencode.json..."
    puts ""

    begin
      config = JSON.parse(File.read(OPENCODE_CONFIG))
    rescue Errno::ENOENT
      @errors << "❌ Configuration file not found: #{OPENCODE_CONFIG}"
      return
    rescue JSON::ParserError => e
      @errors << "❌ Invalid JSON in #{OPENCODE_CONFIG}: #{e.message}"
      return
    end
    
    # Update default model (prefer sonnet, fallback to first available)
    default_family = @models.key?('sonnet') ? 'sonnet' : @models.keys.first
    unless default_family
      @errors << "❌ No models defined in configuration"
      return
    end
    
    default_model = @models[default_family]['id']
    config['model'] = default_model

    # Update each agent's model
    @agent_mappings.each do |agent_name, model_family|
      if config['agent'] && config['agent'][agent_name]
        model_id = @models[model_family]['id']
        temperature = @models[model_family]['temperature']
        
        config['agent'][agent_name]['model'] = model_id
        config['agent'][agent_name]['temperature'] = temperature
      end
    end

    # Write updated config
    begin
      File.write(OPENCODE_CONFIG, JSON.pretty_generate(config) + "\n")
      puts "  ✓ opencode.json updated"
    rescue => e
      @errors << "❌ Failed to write #{OPENCODE_CONFIG}: #{e.message}"
    end
    puts ""
  end

  def display_summary
    puts "=" * 60
    puts "📊 Update Summary"
    puts ""
    
    if @dry_run
      puts "  [DRY RUN] Changes that would be made:"
      puts "  📝 Agents that would be updated: #{@would_update_count}"
      if @would_update_count == 0
        puts "     ✅ All agents are already up-to-date!"
      end
    else
      puts "  ✅ Agents updated: #{@updated_count}"
      puts "  📄 Config file: opencode.json"
    end
    puts ""

    if @errors.any?
      puts "⚠️  Errors encountered:"
      @errors.each { |error| puts "  #{error}" }
      puts ""
    end

    puts "📌 Model versions used:"
    @models.each do |family, config|
      puts "  • #{family}: #{config['id']}"
    end
    puts ""

    if @dry_run
      puts "✨ Dry run complete! No changes were made."
      puts ""
      puts "💡 Run without --dry-run to apply these changes"
    else
      puts "✨ Done! All agents now use the latest Claude models."
      puts ""
      puts "💡 Tip: Run this script regularly when new Claude models are released"
      puts "   to keep your agents up to date automatically."
    end
  end
end

# Parse command line arguments
dry_run = ARGV.include?('--dry-run')
check_latest = ARGV.include?('--check-latest')

if ARGV.include?('--help') || ARGV.include?('-h')
  puts "OpenCode Agent Model Updater"
  puts ""
  puts "Usage: ruby #{File.basename(__FILE__)} [options]"
  puts ""
  puts "Options:"
  puts "  --dry-run        Preview changes without modifying files"
  puts "  --check-latest   Check Anthropic docs for latest model versions"
  puts "  --help, -h       Show this help message"
  puts ""
  puts "Examples:"
  puts "  ruby #{File.basename(__FILE__)}                    # Update all agents"
  puts "  ruby #{File.basename(__FILE__)} --dry-run          # Preview changes"
  puts "  ruby #{File.basename(__FILE__)} --check-latest     # Check for newer models"
  puts ""
  exit 0
end

# Run the updater
updater = AgentModelUpdater.new(dry_run: dry_run, check_latest: check_latest)
updater.run
