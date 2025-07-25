# frozen_string_literal: true

require File.expand_path('lib/rggen/veryl/version', __dir__)

Gem::Specification.new do |spec|
  spec.name = 'rggen-veryl'
  spec.version = RgGen::Veryl::VERSION
  spec.authors = ['Taichi Ishitani']
  spec.email = ['rggen@googlegroups.com']

  spec.summary = "rggen-veryl-#{RgGen::Veryl::VERSION}"
  spec.description = 'Veryl writer plugin for RgGen'
  spec.homepage = 'https://github.com/rggen/rggen-veryl'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1'

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/rggen/rggen/issues',
    'mailing_list_uri' => 'https://groups.google.com/d/forum/rggen',
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => 'https://github.com/rggen/rggen-veryl',
    'wiki_uri' => 'https://github.com/rggen/rggen/wiki'
  }

  spec.files =
    `git ls-files lib LICENSE CODE_OF_CONDUCT.md README.md`.split($RS)
  spec.require_paths = ['lib']

  spec.add_dependency 'rggen-systemverilog', '>= 0.35.1'
end
