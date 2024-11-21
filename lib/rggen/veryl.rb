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
    'veryl/bit_field/type',
    'veryl/bit_field/type/custom',
    'veryl/bit_field/type/rc_w0c_w1c_wc_woc',
    'veryl/bit_field/type/ro_rotrg',
    'veryl/bit_field/type/rof',
    'veryl/bit_field/type/rohw',
    'veryl/bit_field/type/row0trg_row1trg',
    'veryl/bit_field/type/rowo_rowotrg',
    'veryl/bit_field/type/rs_w0s_w1s_ws_wos',
    'veryl/bit_field/type/rw_rwtrg_w1',
    'veryl/bit_field/type/rwc',
    'veryl/bit_field/type/rwe_rwl',
    'veryl/bit_field/type/rwhw',
    'veryl/bit_field/type/rws',
    'veryl/bit_field/type/w0crs_w0src_w1crs_w1src_wcrs_wsrc',
    'veryl/bit_field/type/w0t_w1t',
    'veryl/bit_field/type/w0trg_w1trg',
    'veryl/bit_field/type/wo_wo1_wotrg',
    'veryl/bit_field/type/wrc_wrs',
    'veryl/bit_field/veryl_top',
    'veryl/register/veryl_top',
    'veryl/register_file/veryl_top',
    'veryl/register_block/veryl_top'
  ]
end
