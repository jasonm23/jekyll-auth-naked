class JekyllAuthNaked
  def self.setup_config
    @config_file ||= YAML.safe_load_file(File.join(Dir.pwd, "_config.yml"))
  end

  def self.config
    config_file = JekyllAuthNaked.setup_config
    return {} if config_file.nil? || config_file["jekyll_auth_naked"].nil?
    config_file["jekyll_auth_naked"]
  end

  def self.whitelist
    whitelist = JekyllAuthNaked::config["whitelist"]
    Regexp.new(whitelist.join("|")) unless whitelist.nil?
  end

  def self.ssl?
    !!JekyllAuthNaked::config["ssl"]
  end
end
