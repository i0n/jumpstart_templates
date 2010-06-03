require 'rbconfig'
require 'rubygems'
require 'fileutils'
require 'yaml'

require 'PROJECT_NAME/base'

module PROJECT_NAME_CLASS

  ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  LIB_PATH = File.expand_path(File.dirname(__FILE__))
  CONFIG_PATH = File.expand_path(File.join(File.dirname(__FILE__), '../config'))
  IGNORE_DIRS = ['.','..']
  LAUNCH_PATH = FileUtils.pwd

  @version_yaml = YAML.load_file("#{PROJECT_NAME_CLASS::CONFIG_PATH}/version.yml")

  @version_major = @version_yaml[:version_major]
  @version_minor = @version_yaml[:version_minor]
  @version_patch = @version_yaml[:version_patch]

  class << self

    attr_accessor :version_major, :version_minor, :version_patch

    # Method for writing to config/jumpstart_version.yml
    def dump_version_yaml
      File.open( "#{PROJECT_NAME_CLASS::CONFIG_PATH}/version.yml", 'w' ) do |out|
        YAML.dump( {:version_major => @version_major, :version_minor => @version_minor, :version_patch => @version_patch}, out )
      end
    end

    # Looks up the current version of JumpStart
    def version
      "#{version_major}.#{version_minor}.#{version_patch}"
    end

    # Method for bumping version number types.
    # Resets @version_minor and @version_patch to 0 if bumping @version_major.
    # Resets @version_pacth to 0 if bumping @version_minor
    def bump(version_type)
      value = instance_variable_get("@#{version_type}")
      instance_variable_set("@#{version_type}", (value + 1))
      if version_type == "version_major"
        @version_minor, @version_patch = 0, 0
      elsif version_type == "version_minor"
        @version_patch = 0
      end
      dump_version_yaml
    end

    # Handles calls to JumpStart::Setup.bump_version_major, JumpStart::Setup.bump_version_minor and JumpStart::Setup.bump_version_patch class methods.
    def method_missing(method, *args)
      if method.to_s.match(/^bump_version_(major|minor|patch)$/)
        version_type = method.to_s.sub('bump_', '')
        self.send(:bump, "#{version_type}")
      else
        super
      end
    end

    # Handles calls to missing constants in the JumpStart module. Calls JumpStart.version if JumpStart::VERSION is recognised.
    def const_missing(name)
      if name.to_s =~ /^VERSION$/
        version
      else
        super
      end
    end

  end

end
