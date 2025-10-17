#!/usr/bin/env ruby

require 'yaml'
require 'json'
require 'fileutils'

class AgentModelUpdater
  CONFIG_FILE = '.opencode/model-config.yaml'
  AGENTS_DIR = '.opencode/agent'
  OPENCODE_CONFIG = 'opencode.json'

  def initialize
    @config = YAML.load_file(CONFIG_FILE)
    @models = @config['models']
    @agent_mappings = @config['agents']
    @updated_count = 0
    @errors = []
  end

  def run
    puts "🚀 OpenCode Agent Model Updater"
    puts "=" * 60
    puts ""

    # Display loaded config
    display_config

    # Update agents
    update_agents

    # Update opencode.json
    update_opencode_json

    # Summary
    display_summary
  end

  private

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

  def update_agents
    puts "🔄 Updating Agent Files..."
    puts ""

    @agent_mappings.each do |agent_name, model_family|
      model_id = @models[model_family]['id']
      temperature = @models[model_family]['temperature']
      
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

      if update_agent_file(agent_file, model_id, temperature)
        puts "  ✓ #{agent_name}: #{model_id}"
        @updated_count += 1
      else
        @errors << "❌ Failed to update #{agent_name}"
      end
    end
    puts ""
  end

  def update_agent_file(file_path, model_id, temperature)
    content = File.read(file_path)
    
    # Update model line in YAML frontmatter
    updated_content = content.gsub(
      /^model: .*$/,
      "model: #{model_id}"
    )
    
    # Update temperature if specified
    updated_content = updated_content.gsub(
      /^temperature: .*$/,
      "temperature: #{temperature}"
    )
    
    # Only write if changed
    if updated_content != content
      File.write(file_path, updated_content)
      true
    else
      false
    end
  end

  def update_opencode_json
    puts "🔧 Updating opencode.json..."
    puts ""

    config = JSON.parse(File.read(OPENCODE_CONFIG))
    
    # Update default model to sonnet
    default_model = @models['sonnet']['id']
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
    File.write(OPENCODE_CONFIG, JSON.pretty_generate(config) + "\n")
    puts "  ✓ opencode.json updated"
    puts ""
  end

  def display_summary
    puts "=" * 60
    puts "📊 Update Summary"
    puts ""
    puts "  ✅ Agents updated: #{@updated_count}"
    puts "  📄 Config file: opencode.json"
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

    puts "✨ Done! All agents now use the latest Claude models."
    puts ""
    puts "💡 Tip: Run this script regularly when new Claude models are released"
    puts "   to keep your agents up to date automatically."
  end
end

# Run the updater
updater = AgentModelUpdater.new
updater.run
