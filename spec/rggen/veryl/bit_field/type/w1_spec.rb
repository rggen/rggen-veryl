# frozen_string_literal: true

RSpec.describe 'bit_field/type/w1' do
  include_context 'clean-up builder'
  include_context 'bit field common'

  before(:all) do
    RgGen.enable(:bit_field, :type, [:w1])
  end

  it '出力ポート#value_outを持つ' do
    bit_fields = create_bit_fields do
      byte_size 256

      register do
        name 'register_0'
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :w1; initial_value 0 }
        bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :w1; initial_value 0 }
        bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :w1; initial_value 0 }
      end

      register do
        name 'register_1'
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 64; type :w1; initial_value 0 }
      end

      register do
        name 'register_2'
        size [4]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :w1; initial_value 0 }
        bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :w1; initial_value 0 }
        bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :w1; initial_value 0 }
      end

      register do
        name 'register_3'
        size [2, 2]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :w1; initial_value 0 }
        bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :w1; initial_value 0 }
        bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :w1; initial_value 0 }
      end

      register_file do
        name 'register_file_4'
        size [2, 2]
        register_file do
          name 'register_file_0'
          register do
            name 'register_0'
            size [2, 2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :w1; initial_value 0 }
            bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :w1; initial_value 0 }
            bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :w1; initial_value 0 }
          end
        end
      end
    end

    expect(bit_fields[0]).to have_port(
      :register_block, :value_out,
      name: 'o_register_0_bit_field_0', direction: :output, type: :logic, width: 1
    )
    expect(bit_fields[1]).to have_port(
      :register_block, :value_out,
      name: 'o_register_0_bit_field_1', direction: :output, type: :logic, width: 2
    )
    expect(bit_fields[2]).to have_port(
      :register_block, :value_out,
      name: 'o_register_0_bit_field_2',
      direction: :output, type: :logic, width: 4, array_size: [2]
    )

    expect(bit_fields[3]).to have_port(
      :register_block, :value_out,
      name: 'o_register_1_bit_field_0', direction: :output, type: :logic, width: 64
    )

    expect(bit_fields[4]).to have_port(
      :register_block, :value_out,
      name: 'o_register_2_bit_field_0',
      direction: :output, type: :logic, width: 1, array_size: [4]
    )
    expect(bit_fields[5]).to have_port(
      :register_block, :value_out,
      name: 'o_register_2_bit_field_1',
      direction: :output, type: :logic, width: 2, array_size: [4]
    )
    expect(bit_fields[6]).to have_port(
      :register_block, :value_out,
      name: 'o_register_2_bit_field_2',
      direction: :output, type: :logic, width: 4, array_size: [4, 2]
    )

    expect(bit_fields[7]).to have_port(
      :register_block, :value_out,
      name: 'o_register_3_bit_field_0',
      direction: :output, type: :logic, width: 1, array_size: [2, 2]
    )
    expect(bit_fields[8]).to have_port(
      :register_block, :value_out,
      name: 'o_register_3_bit_field_1',
      direction: :output, type: :logic, width: 2, array_size: [2, 2]
    )
    expect(bit_fields[9]).to have_port(
      :register_block, :value_out,
      name: 'o_register_3_bit_field_2',
      direction: :output, type: :logic, width: 4, array_size: [2, 2, 2]
    )

    expect(bit_fields[10]).to have_port(
      :register_block, :value_out,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_0',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2, 2]
    )
    expect(bit_fields[11]).to have_port(
      :register_block, :value_out,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_1',
      direction: :output, type: :logic, width: 2, array_size: [2, 2, 2, 2]
    )
    expect(bit_fields[12]).to have_port(
      :register_block, :value_out,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_2',
      direction: :output, type: :logic, width: 4, array_size: [2, 2, 2, 2, 2]
    )
  end

  describe '#generate_code' do
    it 'rggen::rggen_bit_fieldをインスタンスするコードを出力する' do
      bit_fields = create_bit_fields do
        byte_size 256

        register do
          name 'register_0'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :w1; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 16, width: 16; type :w1; initial_value 0xabcd }
        end

        register do
          name 'register_1'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 64; type :w1; initial_value 0 }
        end

        register do
          name 'register_2'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 4, sequence_size: 4, step: 8; type :w1; initial_value 0 }
        end

        register do
          name 'register_3'
          size [4]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 4, sequence_size: 4, step: 8; type :w1; initial_value 0 }
        end

        register do
          name 'register_4'
          size [2, 2]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 4, sequence_size: 4, step: 8; type :w1; initial_value 0 }
        end

        register_file do
          name 'register_file_5'
          size [2, 2]
          register_file do
            name 'register_file_0'
            register do
              name 'register_0'
              size [2, 2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 4, sequence_size: 4, step: 8; type :w1; initial_value 0 }
            end
          end
        end
      end

      expect(bit_fields[0]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:          1,
          INITIAL_VALUE:  INITIAL_VALUE,
          SW_WRITE_ONCE:  1,
          TRIGGER:        0
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  _,
          o_read_trigger:   _,
          o_value:          o_register_0_bit_field_0
        );
      VERYL

      expect(bit_fields[1]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:          16,
          INITIAL_VALUE:  INITIAL_VALUE,
          SW_WRITE_ONCE:  1,
          TRIGGER:        0
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  _,
          o_read_trigger:   _,
          o_value:          o_register_0_bit_field_1
        );
      VERYL

      expect(bit_fields[2]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:          64,
          INITIAL_VALUE:  INITIAL_VALUE,
          SW_WRITE_ONCE:  1,
          TRIGGER:        0
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  _,
          o_read_trigger:   _,
          o_value:          o_register_1_bit_field_0
        );
      VERYL

      expect(bit_fields[3]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:          4,
          INITIAL_VALUE:  INITIAL_VALUE,
          SW_WRITE_ONCE:  1,
          TRIGGER:        0
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  _,
          o_read_trigger:   _,
          o_value:          o_register_2_bit_field_0[i]
        );
      VERYL

      expect(bit_fields[4]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:          4,
          INITIAL_VALUE:  INITIAL_VALUE,
          SW_WRITE_ONCE:  1,
          TRIGGER:        0
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  _,
          o_read_trigger:   _,
          o_value:          o_register_3_bit_field_0[i][j]
        );
      VERYL

      expect(bit_fields[5]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:          4,
          INITIAL_VALUE:  INITIAL_VALUE,
          SW_WRITE_ONCE:  1,
          TRIGGER:        0
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  _,
          o_read_trigger:   _,
          o_value:          o_register_4_bit_field_0[i][j][k]
        );
      VERYL

      expect(bit_fields[6]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:          4,
          INITIAL_VALUE:  INITIAL_VALUE,
          SW_WRITE_ONCE:  1,
          TRIGGER:        0
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  _,
          o_read_trigger:   _,
          o_value:          o_register_file_5_register_file_0_register_0_bit_field_0[i][j][k][l][m]
        );
      VERYL
    end
  end
end
