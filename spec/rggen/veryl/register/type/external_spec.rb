# frozen_string_literal: true

RSpec.describe 'register/type/external' do
  include_context 'clean-up builder'
  include_context 'veryl common'

  before(:all) do
    RgGen.enable(:global, [:address_width, :enable_wide_register])
    RgGen.enable(:register_block, [:byte_size, :bus_width])
    RgGen.enable(:register, [:name, :type, :offset_address, :size])
    RgGen.enable(:register, :type, :external)
    RgGen.enable(:bit_field, :name)
    RgGen.enable(:register_block, :veryl_top)
    RgGen.enable(:register, :veryl_top)
  end

  def create_registers(&body)
    create_veryl(&body).registers
  end

  it 'パラメータ#strobe_widthを持つ' do
    registers = create_registers do
      byte_size 256
      register { name 'register_0'; offset_address 0x00; type :external; size [1] }
    end

    expect(registers[0])
      .to have_param(
        :register_block, :strobe_width,
        name: 'REGISTER_0_STROBE_WIDTH', type: :u32, default: 4
      )
  end

  it 'modport #bus_ifを持つ' do
    registers = create_registers do
      byte_size 256
      register { name 'register_0'; offset_address 0x00; type :external; size [1] }
    end

    expect(registers[0])
      .to have_modport(
        :register_block, :bus_if,
        name: 'register_0_bus_if', interface_type: 'rggen::rggen_bus_if', modport: 'master'
      )
  end

  describe '#generate_code' do
    it 'rggen_exernal_registerをインスタンスするコードを出力する' do
      registers = create_registers do
        byte_size 256
        register { name 'register_0'; offset_address 0x00; type :external; size [1] }
        register { name 'register_1'; offset_address 0x80; type :external; size [32] }
      end

      expect(registers[0]).to generate_code(:register, :top_down, <<~'VERYL')
        inst u_register: rggen::rggen_external_register #(
          ADDRESS_WIDTH:  8,
          BUS_WIDTH:      32,
          VALUE_WIDTH:    32,
          STROBE_WIDTH:   REGISTER_0_STROBE_WIDTH,
          START_ADDRESS:  8'h00,
          BYTE_SIZE:      4
        )(
          i_clk:        i_clk,
          i_rst:        i_rst,
          register_if:  register_if[0],
          bus_if:       register_0_bus_if
        );
      VERYL

      expect(registers[1]).to generate_code(:register, :top_down, <<~'VERYL')
        inst u_register: rggen::rggen_external_register #(
          ADDRESS_WIDTH:  8,
          BUS_WIDTH:      32,
          VALUE_WIDTH:    32,
          STROBE_WIDTH:   REGISTER_1_STROBE_WIDTH,
          START_ADDRESS:  8'h80,
          BYTE_SIZE:      128
        )(
          i_clk:        i_clk,
          i_rst:        i_rst,
          register_if:  register_if[1],
          bus_if:       register_1_bus_if
        );
      VERYL
    end
  end
end
