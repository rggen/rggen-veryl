# frozen_string_literal: true

require_relative 'veryl/version'
require_relative 'veryl/utility/data_object'
require_relative 'veryl/utility/modport'
require_relative 'veryl/utility/interface_instance'
require_relative 'veryl/utility/local_scope'
require_relative 'veryl/utility/module_definition'
require_relative 'veryl/utility'
require_relative 'veryl/component'
require_relative 'veryl/feature'
require_relative 'veryl/factories'

RgGen.setup_plugin :'rggen-veryl' do |plugin|
  plugin.version RgGen::Veryl::VERSION

  plugin.register_component :veryl do
    component RgGen::Veryl::Component,
              RgGen::Veryl::ComponentFactory
    feature RgGen::Veryl::Feature,
            RgGen::Veryl::FeatureFactory
  end

  plugin.files [
    'veryl/register_block/veryl_top'
  ]
end
