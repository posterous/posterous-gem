module Postly
  extend self

  attr_reader :config

  def config=(cfg)
    @config = YAML.load_file(cfg) if cfg.is_a?(File)
    @config = cfg if cfg.is_a?(Hash)
  end
end
