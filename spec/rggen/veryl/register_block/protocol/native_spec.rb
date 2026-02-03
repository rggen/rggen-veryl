#! frozen_string_literal: true

RSpec.describe 'register_block/protocol/native' do
  include_context 'veryl common'
  include_context 'clean-up builder'

  before(:all) do
    RgGen.enable(:global, [:address_width, :enable_wide_register])
    RgGen.enable(:register_block, [:name, :protocol, :byte_size, :bus_width])
    RgGen.enable(:register_block, :protocol, [:native])
    RgGen.enable(:register, [:name, :offset_address, :size, :type])
    RgGen.enable(:register, :type, [:external])
    RgGen.enable(:register_block, [:veryl_top])
  end

  let(:address_width) do
    16
  end

  let(:bus_width) do
    32
  end

  let(:register_block) do
    create_register_block do
      name 'block_0'
      byte_size 256
      register { name 'register_0'; offset_address 0x00; size [1]; type :external }
      register { name 'register_1'; offset_address 0x10; size [1]; type :external }
      register { name 'register_2'; offset_address 0x20; size [1]; type :external }
    end
  end

  def create_register_block(&)
    configuration =
      create_configuration(
        address_width:, bus_width:, protocol: :native
      )
    create_veryl(configuration, &).register_blocks.first
  end

  it 'パラメータ#strobe_width/#use_read_strobeを持つ' do
    expect(register_block)
      .to have_param(
        :strobe_width,
        name: 'STROBE_WIDTH', type: :u32, default: bus_width / 8
      )
    expect(register_block)
      .to have_param(
        :use_read_strobe,
        name: 'USE_READ_STROBE', type: :bbool, default: false
      )
  end

  it 'modport #csrbus_ifを持つ' do
    expect(register_block)
      .to have_modport(
        :csrbus_if,
        name: 'csrbus_if', interface_type: 'rggen::rggen_bus_if', modport: 'slave'
      )
  end

  describe '#generate_code' do
    it 'rggen_native_adapterをインスタンスするコードを生成する' do
      expect(register_block).to generate_code(:register_block, :top_down, <<~'VERYL')
        inst u_adapter: rggen::rggen_native_adapter #(
          ADDRESS_WIDTH:        ADDRESS_WIDTH,
          LOCAL_ADDRESS_WIDTH:  8,
          BUS_WIDTH:            32,
          STROBE_WIDTH:         STROBE_WIDTH,
          REGISTERS:            3,
          PRE_DECODE:           PRE_DECODE,
          BASE_ADDRESS:         BASE_ADDRESS,
          BYTE_SIZE:            256,
          USE_READ_STROBE:      USE_READ_STROBE,
          ERROR_STATUS:         ERROR_STATUS,
          DEFAULT_READ_DATA:    DEFAULT_READ_DATA,
          INSERT_SLICER:        INSERT_SLICER
        )(
          i_clk:        i_clk,
          i_rst:        i_rst,
          csrbus_if:    csrbus_if,
          register_if:  register_if
        );
      VERYL
    end
  end
end
