# frozen_string_literal: true

RSpec.describe 'register_block/protocol/axi4lite' do
  include_context 'veryl common'
  include_context 'clean-up builder'

  before(:all) do
    RgGen.enable(:global, [:address_width, :enable_wide_register])
    RgGen.enable(:register_block, [:name, :byte_size, :protocol, :bus_width])
    RgGen.enable(:register_block, :protocol, [:axi4lite])
    RgGen.enable(:register, [:name, :offset_address, :size, :type])
    RgGen.enable(:register, :type, [:external])
    RgGen.enable(:register_block, [:veryl_top])
  end

  def create_register_block(&body)
    configuration = create_configuration(
      address_width: 16, bus_width: 32, protocol: :axi4lite
    )
    create_veryl(configuration, &body).register_blocks.first
  end

  it 'パラメータ#id_width/#write_firstを持つ' do
    register_block = create_register_block do
      name 'block_0'
      byte_size 256
      register { name 'register_0'; offset_address 0x00; size [1]; type :external }
    end

    expect(register_block)
      .to have_param(
        :id_width,
        name: 'ID_WIDTH', type: :u32, default: 0
      )
    expect(register_block)
      .to have_param(
        :write_first,
        name: 'WRITE_FIRST', type: :bbool, default: true
      )
  end

  it 'modport #axi4lite_ifを持つ' do
    register_block = create_register_block do
      name 'block_0'
      byte_size 256
      register { name 'register_0'; offset_address 0x00; size [1]; type :external }
    end

    expect(register_block)
      .to have_modport(
        :axi4lite_if,
        name: 'axi4lite_if', interface_type: 'rggen::rggen_axi4lite_if', modport: 'slave'
    )
  end

  describe '#generate_code' do
    it 'rggen::rggen_axi4lite_adapterをインスタンスするコードを生成する' do
      register_block = create_register_block do
        name 'block_0'
          byte_size 256
          register { name 'register_0'; offset_address 0x00; size [1]; type :external }
          register { name 'register_1'; offset_address 0x10; size [1]; type :external }
          register { name 'register_2'; offset_address 0x20; size [1]; type :external }
      end

      expect(register_block).to generate_code(:register_block, :top_down, <<~'VERYL')
        inst u_adapter: rggen::rggen_axi4lite_adapter #(
          ID_WIDTH:             ID_WIDTH,
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
          WRITE_FIRST:          WRITE_FIRST
        )(
          i_clk:        i_clk,
          i_rst:        i_rst,
          axi4lite_if:  axi4lite_if,
          register_if:  register_if
        );
      VERYL
    end
  end
end
