# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod "puppet-#{name}", :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.11.1"

# Support for default hiera data in modules

github "module_data", "0.0.4", :repo => "ripienaar/puppet-module-data"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.
github "brewcask",    "0.0.6"
github "dnsmasq",     "2.0.1"
github "foreman",     "1.2.0"
github "gcc",         "3.0.2"
github "git",         "2.9.0"
github "go",          "2.1.0"
github "homebrew",    "2.0.2"
github "hub",         "1.4.1"
github "inifile",     "1.4.1", :repo => "puppetlabs/puppetlabs-inifile"
github "nodejs",      "5.0.7"
github "nginx",       "1.7.0"
github "openssl",     "1.0.0"
github "phantomjs",   "3.0.0"
github "pkgconfig",   "1.0.0"
github "repository",  "2.4.1"
github "ruby",        "8.5.4"
github "stdlib",      "4.7.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",        "1.0.0"
github "xquartz",     "1.2.1"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.
github "chrome",        "1.2.0"
github "java",          "1.8.4"
github "clojure",       "1.3.0"
github "osx",           "2.8.0"
github "zsh",           "1.0.1"
github "wget",          "1.0.1"
github "virtualbox",    "1.0.13"
github "python",        "2.0.1"
github "vim",           "1.0.5"
github "vagrant",       "3.3.4"
github "docker",        "1.0.0"
github "tmux",          "1.0.2"
github "skype",         "1.1.0"
github "ansible",       "0.0.1", :repo => "gaahrdner/puppet-ansible"
github "evernote",      "2.0.4"
github 'intellij',      "1.5.3", :repo => "mavant/puppet-intellij"
github 'rabbitmq',      "0.5.0", :repo => "crowdtap/puppet-rabbitmq"
github 'elasticsearch', "2.8.0"
github 'mongodb',       "1.5.0"
