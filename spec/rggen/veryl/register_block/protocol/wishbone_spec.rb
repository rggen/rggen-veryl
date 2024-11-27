# frozen_string_literal: true

RSpec.describe 'regisrer_block/protocol/wishbone' do
  include_context 'veryl common'
  include_context 'clean-up builder'

  before(:all) do
    RgGen.enable(:global, [:bus_width, :address_width, :enable_wide_register])
    RgGen.enable(:register_block, :protocol)
    RgGen.enable(:register_block, :protocol, [:wishbone])
    RgGen.enable(:register_block, [:name, :byte_size])
    RgGen.enable(:register, [:name, :offset_address, :size, :type])
    RgGen.enable(:register, :type, :external)
    RgGen.enable(:register_block, :veryl_top)
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

  def create_register_block(&body)
    configuration = create_configuration(
      address_width: 16,
      bus_width: 32,
      protocol: :wishbone
    )
    create_veryl(configuration, &body).register_blocks.first
  end

  it 'パラメータ#use_stallを持つ' do
    expect(register_block)
      .to have_param(
        :use_stall,
        name: 'USE_STALL', type: :bit, default: 1
      )
  end

  it 'modport #wishbone_ifを持つ' do
    expect(register_block)
      .to have_modport(
        :wishbone_if,
        name: 'wishbone_if', interface_type: 'rggen::rggen_wishbone_if', modport: 'slave'
      )
  end

  describe '#generate_code' do
    it 'rggen::rggen_wishbone_adapterをインスタンスするコードを生成する' do
      expect(register_block).to generate_code(:register_block, :top_down, <<~'VERYL')
        inst u_adapter: rggen::rggen_wishbone_adapter #(
          ADDRESS_WIDTH:        ADDRESS_WIDTH,
          LOCAL_ADDRESS_WIDTH:  8,
          BUS_WIDTH:            32,
          REGISTERS:            3,
          PRE_DECODE:           PRE_DECODE,
          BASE_ADDRESS:         BASE_ADDRESS,
          BYTE_SIZE:            256,
          ERROR_STATUS:         ERROR_STATUS,
          DEFAULT_READ_DATA:    DEFAULT_READ_DATA,
          INSERT_SLICER:        INSERT_SLICER,
          USE_STALL:            USE_STALL
        )(
          i_clk:        i_clk,
          i_rst:        i_rst,
          wishbone_if:  wishbone_if,
          register_if:  register_if
        );
      VERYL
    end
  end
end
