# frozen_string_literal: true

RSpec.describe 'register/type/indirect' do
  include_context 'clean-up builder'
  include_context 'veryl common'

  before(:all) do
    RgGen.enable(:global, [:bus_width, :address_width, :enable_wide_register, :array_port_format])
    RgGen.enable(:register_block, :byte_size)
    RgGen.enable(:register_file, [:name, :offset_address, :size])
    RgGen.enable(:register, [:name, :offset_address, :size, :type])
    RgGen.enable(:register, :type, [:indirect])
    RgGen.enable(:bit_field, [:name, :bit_assignment, :initial_value, :reference, :type])
    RgGen.enable(:bit_field, :type, [:ro, :rw, :wo, :reserved])
    RgGen.enable(:register_block, :veryl_top)
    RgGen.enable(:register_file, :veryl_top)
    RgGen.enable(:register, :veryl_top)
    RgGen.enable(:bit_field, :veryl_top)
  end

  let(:registers) do
    veryl = create_veryl do
      byte_size 256

      register do
        name 'register_0'
        offset_address 0x00
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
        bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rw; initial_value 0 }
        bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4; type :rw; initial_value 0 }
      end

      register do
        name 'register_1'
        offset_address 0x04
        bit_field { bit_assignment lsb: 0, width: 2; type :rw; initial_value 0 }
      end

      register do
        name 'register_2'
        offset_address 0x08
        bit_field { bit_assignment lsb: 0, width: 2; type :rw; initial_value 0 }
      end

      register_file do
        name 'register_file_3'
        offset_address 0x0C
        register do
          name 'register_0'
          offset_address 0x00
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rw; initial_value 0 }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4; type :rw; initial_value 0 }
        end
      end

      register do
        name 'register_4'
        offset_address 0x10
        type [:indirect, ['register_0.bit_field_0', 1]]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
      end

      register do
        name 'register_5'
        offset_address 0x14
        size [2]
        type [:indirect, 'register_0.bit_field_1']
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
      end

      register do
        name 'register_6'
        offset_address 0x18
        size [2, 4]
        type [:indirect, 'register_0.bit_field_1', 'register_0.bit_field_2']
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
      end

      register do
        name 'register_7'
        offset_address 0x1c
        size [2, 4]
        type [:indirect, ['register_0.bit_field_0', 0], 'register_0.bit_field_1', 'register_0.bit_field_2']
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
      end

      register do
        name 'register_8'
        offset_address 0x20
        type [:indirect, ['register_0.bit_field_0', 0]]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :ro }
      end

      register do
        name 'register_9'
        offset_address 0x24
        type [:indirect, ['register_0.bit_field_0', 0]]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :wo; initial_value 0 }
      end

      register do
        name 'register_10'
        offset_address 0x28
        size [2]
        type [:indirect, 'register_1', ['register_2', 0]]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
      end

      register do
        name 'register_11'
        offset_address 0x2C
        size [2, 4]
        type [
          :indirect,
          ['register_file_3.register_0.bit_field_0', 0],
          'register_file_3.register_0.bit_field_1',
          'register_file_3.register_0.bit_field_2'
        ]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
      end

      register_file do
        name 'register_file_12'
        offset_address 0x30
        size [2, 2]
        register_file do
          name 'register_file_0'
          offset_address 0x00

          register do
            name 'register_0'
            offset_address 0x00
            size [2, 4]
            type [
              :indirect,
              ['register_0.bit_field_0', 0],
              'register_0.bit_field_1',
              'register_0.bit_field_2'
            ]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
          end

          register do
            name 'register_1'
            offset_address 0x04
            size [2, 4]
            type [
              :indirect,
              ['register_file_3.register_0.bit_field_0', 0],
              'register_file_3.register_0.bit_field_1',
              'register_file_3.register_0.bit_field_2'
            ]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
          end
        end
      end
    end
    veryl.registers
  end

  it '#indirect_matchを持つ' do
    expect(registers[4])
      .to have_var(
        :indirect_match,
        name: 'indirect_match', type: :logic, width: 1
      )

    expect(registers[5])
      .to have_var(
        :indirect_match,
        name: 'indirect_match', type: :logic, width: 1
      )

    expect(registers[6])
      .to have_var(
        :indirect_match,
        name: 'indirect_match', type: :logic, width: 2
      )

    expect(registers[7])
      .to have_var(
        :indirect_match,
        name: 'indirect_match', type: :logic, width: 3
      )
  end

  describe '#generate_code' do
    it 'rggen::rggen_indirect_registerをインスタンスするコードを出力する' do
      expect(registers[4]).to generate_code(:register, :top_down, <<~'VERYL')
        assign indirect_match = register_if[0].value[0+:1] == 1'h1;
        inst u_register: rggen::rggen_indirect_register #(
          READABLE:             1,
          WRITABLE:             1,
          ADDRESS_WIDTH:        8,
          OFFSET_ADDRESS:       8'h10,
          BUS_WIDTH:            32,
          DATA_WIDTH:           32,
          VALUE_WIDTH:          32,
          VALID_BITS:           32'h00000001,
          INDIRECT_MATCH_WIDTH: 1
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          register_if:      register_if[4],
          i_indirect_match: indirect_match,
          bit_field_if:     bit_field_if
        );
      VERYL

      expect(registers[5]).to generate_code(:register, :top_down, <<~'VERYL')
        assign indirect_match = register_if[0].value[8+:2] == (i as 2);
        inst u_register: rggen::rggen_indirect_register #(
          READABLE:             1,
          WRITABLE:             1,
          ADDRESS_WIDTH:        8,
          OFFSET_ADDRESS:       8'h14,
          BUS_WIDTH:            32,
          DATA_WIDTH:           32,
          VALUE_WIDTH:          32,
          VALID_BITS:           32'h00000001,
          INDIRECT_MATCH_WIDTH: 1
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          register_if:      register_if[5+i],
          i_indirect_match: indirect_match,
          bit_field_if:     bit_field_if
        );
      VERYL

      expect(registers[6]).to generate_code(:register, :top_down, <<~'VERYL')
        assign indirect_match[0] = register_if[0].value[8+:2] == (i as 2);
        assign indirect_match[1] = register_if[0].value[16+:4] == (j as 4);
        inst u_register: rggen::rggen_indirect_register #(
          READABLE:             1,
          WRITABLE:             1,
          ADDRESS_WIDTH:        8,
          OFFSET_ADDRESS:       8'h18,
          BUS_WIDTH:            32,
          DATA_WIDTH:           32,
          VALUE_WIDTH:          32,
          VALID_BITS:           32'h00000001,
          INDIRECT_MATCH_WIDTH: 2
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          register_if:      register_if[7+4*i+j],
          i_indirect_match: indirect_match,
          bit_field_if:     bit_field_if
        );
      VERYL

      expect(registers[7]).to generate_code(:register, :top_down, <<~'VERYL')
        assign indirect_match[0] = register_if[0].value[0+:1] == 1'h0;
        assign indirect_match[1] = register_if[0].value[8+:2] == (i as 2);
        assign indirect_match[2] = register_if[0].value[16+:4] == (j as 4);
        inst u_register: rggen::rggen_indirect_register #(
          READABLE:             1,
          WRITABLE:             1,
          ADDRESS_WIDTH:        8,
          OFFSET_ADDRESS:       8'h1c,
          BUS_WIDTH:            32,
          DATA_WIDTH:           32,
          VALUE_WIDTH:          32,
          VALID_BITS:           32'h00000001,
          INDIRECT_MATCH_WIDTH: 3
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          register_if:      register_if[15+4*i+j],
          i_indirect_match: indirect_match,
          bit_field_if:     bit_field_if
        );
      VERYL

      expect(registers[8]).to generate_code(:register, :top_down, <<~'VERYL')
        assign indirect_match = register_if[0].value[0+:1] == 1'h0;
        inst u_register: rggen::rggen_indirect_register #(
          READABLE:             1,
          WRITABLE:             0,
          ADDRESS_WIDTH:        8,
          OFFSET_ADDRESS:       8'h20,
          BUS_WIDTH:            32,
          DATA_WIDTH:           32,
          VALUE_WIDTH:          32,
          VALID_BITS:           32'h00000001,
          INDIRECT_MATCH_WIDTH: 1
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          register_if:      register_if[23],
          i_indirect_match: indirect_match,
          bit_field_if:     bit_field_if
        );
      VERYL

      expect(registers[9]).to generate_code(:register, :top_down, <<~'VERYL')
        assign indirect_match = register_if[0].value[0+:1] == 1'h0;
        inst u_register: rggen::rggen_indirect_register #(
          READABLE:             0,
          WRITABLE:             1,
          ADDRESS_WIDTH:        8,
          OFFSET_ADDRESS:       8'h24,
          BUS_WIDTH:            32,
          DATA_WIDTH:           32,
          VALUE_WIDTH:          32,
          VALID_BITS:           32'h00000001,
          INDIRECT_MATCH_WIDTH: 1
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          register_if:      register_if[24],
          i_indirect_match: indirect_match,
          bit_field_if:     bit_field_if
        );
      VERYL

      expect(registers[10]).to generate_code(:register, :top_down, <<~'VERYL')
        assign indirect_match[0] = register_if[1].value[0+:2] == (i as 2);
        assign indirect_match[1] = register_if[2].value[0+:2] == 2'h0;
        inst u_register: rggen::rggen_indirect_register #(
          READABLE:             1,
          WRITABLE:             1,
          ADDRESS_WIDTH:        8,
          OFFSET_ADDRESS:       8'h28,
          BUS_WIDTH:            32,
          DATA_WIDTH:           32,
          VALUE_WIDTH:          32,
          VALID_BITS:           32'h00000001,
          INDIRECT_MATCH_WIDTH: 2
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          register_if:      register_if[25+i],
          i_indirect_match: indirect_match,
          bit_field_if:     bit_field_if
        );
      VERYL

      expect(registers[11]).to generate_code(:register, :top_down, <<~'VERYL')
        assign indirect_match[0] = register_if[3].value[0+:1] == 1'h0;
        assign indirect_match[1] = register_if[3].value[8+:2] == (i as 2);
        assign indirect_match[2] = register_if[3].value[16+:4] == (j as 4);
        inst u_register: rggen::rggen_indirect_register #(
          READABLE:             1,
          WRITABLE:             1,
          ADDRESS_WIDTH:        8,
          OFFSET_ADDRESS:       8'h2c,
          BUS_WIDTH:            32,
          DATA_WIDTH:           32,
          VALUE_WIDTH:          32,
          VALID_BITS:           32'h00000001,
          INDIRECT_MATCH_WIDTH: 3
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          register_if:      register_if[27+4*i+j],
          i_indirect_match: indirect_match,
          bit_field_if:     bit_field_if
        );
      VERYL

      expect(registers[12]).to generate_code(:register, :top_down, <<~'VERYL')
        assign indirect_match[0] = register_if[0].value[0+:1] == 1'h0;
        assign indirect_match[1] = register_if[0].value[8+:2] == (k as 2);
        assign indirect_match[2] = register_if[0].value[16+:4] == (l as 4);
        inst u_register: rggen::rggen_indirect_register #(
          READABLE:             1,
          WRITABLE:             1,
          ADDRESS_WIDTH:        8,
          OFFSET_ADDRESS:       8'h30+(8*(2*i+j) as 8),
          BUS_WIDTH:            32,
          DATA_WIDTH:           32,
          VALUE_WIDTH:          32,
          VALID_BITS:           32'h00000001,
          INDIRECT_MATCH_WIDTH: 3
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          register_if:      register_if[35+16*(2*i+j)+4*k+l],
          i_indirect_match: indirect_match,
          bit_field_if:     bit_field_if
        );
      VERYL

      expect(registers[13]).to generate_code(:register, :top_down, <<~'VERYL')
        assign indirect_match[0] = register_if[3].value[0+:1] == 1'h0;
        assign indirect_match[1] = register_if[3].value[8+:2] == (k as 2);
        assign indirect_match[2] = register_if[3].value[16+:4] == (l as 4);
        inst u_register: rggen::rggen_indirect_register #(
          READABLE:             1,
          WRITABLE:             1,
          ADDRESS_WIDTH:        8,
          OFFSET_ADDRESS:       8'h30+(8*(2*i+j) as 8)+8'h04,
          BUS_WIDTH:            32,
          DATA_WIDTH:           32,
          VALUE_WIDTH:          32,
          VALID_BITS:           32'h00000001,
          INDIRECT_MATCH_WIDTH: 3
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          register_if:      register_if[35+16*(2*i+j)+8+4*k+l],
          i_indirect_match: indirect_match,
          bit_field_if:     bit_field_if
        );
      VERYL
    end
  end
end
