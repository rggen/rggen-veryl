# frozen_string_literal: true

RSpec.describe 'register_block/protocol' do
  include_context 'veryl common'
  include_context 'clean-up builder'

  before(:all) do
    RgGen.define_list_item_feature(:register_block, :protocol, :foo) do
      sv_rtl {}
    end
    RgGen.define_list_item_feature(:register_block, :protocol, :foo) do
      veryl {}
    end

    RgGen.enable(:global, [:bus_width, :address_width])
    RgGen.enable(:register_block, [:protocol, :byte_size])
    RgGen.enable(:register_block, :protocol, :foo)
  end

  let(:bus_width) do
    32
  end

  let(:address_width) do
    32
  end

  let(:local_address_width) do
    8
  end

  let(:veryl) do
    configuration = create_configuration(protocol: :foo, bus_width: bus_width, address_width: address_width)
    create_veryl(configuration) { byte_size 256 }.register_blocks.first
  end

  it 'パラメータADDRESS_WIDTH/PRE_DECODE/BASE_ADDRESS/ERROR_STATUS/DEFAULT_READ_DATA/INSERT_SLICERを持つ' do
    expect(veryl)
      .to have_param(
        :address_width,
        name: 'ADDRESS_WIDTH', type: :u32, default: local_address_width
      )
    expect(veryl)
      .to have_param(
        :pre_decode,
        name: 'PRE_DECODE', type: :bit, default: 0
      )
    expect(veryl)
      .to have_param(
        :base_address,
        name: 'BASE_ADDRESS', type: :bit, width: 'ADDRESS_WIDTH', default: "'0"
      )
    expect(veryl)
      .to have_param(
        :error_status,
        name: 'ERROR_STATUS', type: :bit, default: 0
      )
    expect(veryl)
      .to have_param(
        :default_read_data,
        name: 'DEFAULT_READ_DATA', type: :bit, width: bus_width, default: "'0"
      )
    expect(veryl)
      .to have_param(
        :insert_slicer,
        name: 'INSERT_SLICER', type: :bit, default: 0
      )
  end
end
