
# frozen_string_literal: true

RSpec.describe 'bit_field/type/rohw' do
  include_context 'clean-up builder'
  include_context 'bit field common'

  before(:all) do
    RgGen.enable(:bit_field, :type, [:rw, :rohw])
  end

  let(:bit_fields) do
    create_bit_fields do
      byte_size 256

      register do
        name 'register_0'
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rohw; initial_value 0 }
        bit_field { name 'bit_field_1'; bit_assignment lsb: 1, width: 1; type :rohw; initial_value 0; reference 'register_4.bit_field_0' }
        bit_field { name 'bit_field_2'; bit_assignment lsb: 4, width: 2; type :rohw; initial_value 0 }
        bit_field { name 'bit_field_3'; bit_assignment lsb: 6, width: 2; type :rohw; initial_value 0; reference 'register_4.bit_field_0' }
        bit_field { name 'bit_field_4'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rohw; initial_value 0 }
        bit_field { name 'bit_field_5'; bit_assignment lsb: 20, width: 4, sequence_size: 2, step: 8; type :rohw; initial_value 0; reference 'register_4.bit_field_0' }
      end

      register do
        name 'register_1'
        size [4]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rohw; initial_value 0 }
        bit_field { name 'bit_field_1'; bit_assignment lsb: 1, width: 1; type :rohw; initial_value 0; reference 'register_4.bit_field_0' }
        bit_field { name 'bit_field_2'; bit_assignment lsb: 4, width: 2; type :rohw; initial_value 0 }
        bit_field { name 'bit_field_3'; bit_assignment lsb: 6, width: 2; type :rohw; initial_value 0; reference 'register_4.bit_field_0' }
        bit_field { name 'bit_field_4'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rohw; initial_value 0 }
        bit_field { name 'bit_field_5'; bit_assignment lsb: 20, width: 4, sequence_size: 2, step: 8; type :rohw; initial_value 0; reference 'register_4.bit_field_0' }
      end

      register do
        name 'register_2'
        size [2, 2]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rohw; initial_value 0 }
        bit_field { name 'bit_field_1'; bit_assignment lsb: 1, width: 1; type :rohw; initial_value 0; reference 'register_4.bit_field_0' }
        bit_field { name 'bit_field_2'; bit_assignment lsb: 4, width: 2; type :rohw; initial_value 0 }
        bit_field { name 'bit_field_3'; bit_assignment lsb: 6, width: 2; type :rohw; initial_value 0; reference 'register_4.bit_field_0' }
        bit_field { name 'bit_field_4'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rohw; initial_value 0 }
        bit_field { name 'bit_field_5'; bit_assignment lsb: 20, width: 4, sequence_size: 2, step: 8; type :rohw; initial_value 0; reference 'register_4.bit_field_0' }
      end

      register_file do
        name 'register_file_3'
        size [2, 2]
        register_file do
          name 'register_file_0'
          register do
            name 'register_0'
            size [2, 2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rohw; initial_value 0 }
            bit_field { name 'bit_field_1'; bit_assignment lsb: 1, width: 1; type :rohw; initial_value 0; reference 'register_file_5.register_file_0.register_0.bit_field_0' }
            bit_field { name 'bit_field_2'; bit_assignment lsb: 4, width: 2; type :rohw; initial_value 0 }
            bit_field { name 'bit_field_3'; bit_assignment lsb: 6, width: 2; type :rohw; initial_value 0; reference 'register_file_5.register_file_0.register_0.bit_field_0' }
            bit_field { name 'bit_field_4'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rohw; initial_value 0 }
            bit_field { name 'bit_field_5'; bit_assignment lsb: 20, width: 4, sequence_size: 2, step: 8; type :rohw; initial_value 0; reference 'register_file_5.register_file_0.register_0.bit_field_0' }
          end
        end
      end

      register do
        name 'register_4'
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
      end

      register_file do
        name 'register_file_5'
        size [2, 2]
        register_file do
          name 'register_file_0'
          register do
            name 'register_0'
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
          end
        end
      end
    end
  end

  it '入力ポート#value_in/出力ポート#value_outを持つ' do
    expect(bit_fields[0]).to have_port(
      :register_block, :value_in,
      name: 'i_register_0_bit_field_0', direction: :input, type: :logic, width: 1
    )
    expect(bit_fields[0]).to have_port(
      :register_block, :value_out,
      name: 'o_register_0_bit_field_0', direction: :output, type: :logic, width: 1
    )

    expect(bit_fields[2]).to have_port(
      :register_block, :value_in,
      name: 'i_register_0_bit_field_2', direction: :input, type: :logic, width: 2
    )
    expect(bit_fields[2]).to have_port(
      :register_block, :value_out,
      name: 'o_register_0_bit_field_2', direction: :output, type: :logic, width: 2
    )

    expect(bit_fields[4]).to have_port(
      :register_block, :value_in,
      name: 'i_register_0_bit_field_4',
      direction: :input, type: :logic, width: 4, array_size: [2]
    )
    expect(bit_fields[4]).to have_port(
      :register_block, :value_out,
      name: 'o_register_0_bit_field_4',
      direction: :output, type: :logic, width: 4, array_size: [2]
    )

    expect(bit_fields[6]).to have_port(
      :register_block, :value_in,
      name: 'i_register_1_bit_field_0',
      direction: :input, type: :logic, width: 1, array_size: [4]
    )
    expect(bit_fields[6]).to have_port(
      :register_block, :value_out,
      name: 'o_register_1_bit_field_0',
      direction: :output, type: :logic, width: 1, array_size: [4]
    )

    expect(bit_fields[8]).to have_port(
      :register_block, :value_in,
      name: 'i_register_1_bit_field_2',
      direction: :input, type: :logic, width: 2, array_size: [4]
    )
    expect(bit_fields[8]).to have_port(
      :register_block, :value_out,
      name: 'o_register_1_bit_field_2',
      direction: :output, type: :logic, width: 2, array_size: [4]
    )

    expect(bit_fields[10]).to have_port(
      :register_block, :value_in,
      name: 'i_register_1_bit_field_4',
      direction: :input, type: :logic, width: 4, array_size: [4, 2]
    )
    expect(bit_fields[10]).to have_port(
      :register_block, :value_out,
      name: 'o_register_1_bit_field_4',
      direction: :output, type: :logic, width: 4, array_size: [4, 2]
    )

    expect(bit_fields[12]).to have_port(
      :register_block, :value_in,
      name: 'i_register_2_bit_field_0',
      direction: :input, type: :logic, width: 1, array_size: [2, 2]
    )
    expect(bit_fields[12]).to have_port(
      :register_block, :value_out,
      name: 'o_register_2_bit_field_0',
      direction: :output, type: :logic, width: 1, array_size: [2, 2]
    )

    expect(bit_fields[14]).to have_port(
      :register_block, :value_in,
      name: 'i_register_2_bit_field_2',
      direction: :input, type: :logic, width: 2, array_size: [2, 2]
    )
    expect(bit_fields[14]).to have_port(
      :register_block, :value_out,
      name: 'o_register_2_bit_field_2',
      direction: :output, type: :logic, width: 2, array_size: [2, 2]
    )

    expect(bit_fields[16]).to have_port(
      :register_block, :value_in,
      name: 'i_register_2_bit_field_4',
      direction: :input, type: :logic, width: 4, array_size: [2, 2, 2]
    )
    expect(bit_fields[16]).to have_port(
      :register_block, :value_out,
      name: 'o_register_2_bit_field_4',
      direction: :output, type: :logic, width: 4, array_size: [2, 2, 2]
    )

    expect(bit_fields[18]).to have_port(
      :register_block, :value_in,
      name: 'i_register_file_3_register_file_0_register_0_bit_field_0',
      direction: :input, type: :logic, width: 1, array_size: [2, 2, 2, 2]
    )
    expect(bit_fields[18]).to have_port(
      :register_block, :value_out,
      name: 'o_register_file_3_register_file_0_register_0_bit_field_0',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2, 2]
    )

    expect(bit_fields[20]).to have_port(
      :register_block, :value_in,
      name: 'i_register_file_3_register_file_0_register_0_bit_field_2',
      direction: :input, type: :logic, width: 2, array_size: [2, 2, 2, 2]
    )
    expect(bit_fields[20]).to have_port(
      :register_block, :value_out,
      name: 'o_register_file_3_register_file_0_register_0_bit_field_2',
      direction: :output, type: :logic, width: 2, array_size: [2, 2, 2, 2]
    )

    expect(bit_fields[22]).to have_port(
      :register_block, :value_in,
      name: 'i_register_file_3_register_file_0_register_0_bit_field_4',
      direction: :input, type: :logic, width: 4, array_size: [2, 2, 2, 2, 2]
    )
    expect(bit_fields[22]).to have_port(
      :register_block, :value_out,
      name: 'o_register_file_3_register_file_0_register_0_bit_field_4',
      direction: :output, type: :logic, width: 4, array_size: [2, 2, 2, 2, 2]
    )
  end

  context '参照ビットフィールドを持たない場合' do
    it '入力ポート#validを持つ' do
      expect(bit_fields[0]).to have_port(
        :register_block, :valid,
        name: 'i_register_0_bit_field_0_valid', direction: :input, type: :logic, width: 1
      )
      expect(bit_fields[2]).to have_port(
        :register_block, :valid,
        name: 'i_register_0_bit_field_2_valid', direction: :input, type: :logic, width: 1
      )
      expect(bit_fields[4]).to have_port(
        :register_block, :valid,
        name: 'i_register_0_bit_field_4_valid',
        direction: :input, type: :logic, width: 1, array_size: [2]
      )

      expect(bit_fields[6]).to have_port(
        :register_block, :valid,
        name: 'i_register_1_bit_field_0_valid',
        direction: :input, type: :logic, width: 1, array_size: [4]
      )
      expect(bit_fields[8]).to have_port(
        :register_block, :valid,
        name: 'i_register_1_bit_field_2_valid',
        direction: :input, type: :logic, width: 1, array_size: [4]
      )
      expect(bit_fields[10]).to have_port(
        :register_block, :valid,
        name: 'i_register_1_bit_field_4_valid',
        direction: :input, type: :logic, width: 1, array_size: [4, 2]
      )

      expect(bit_fields[12]).to have_port(
        :register_block, :valid,
        name: 'i_register_2_bit_field_0_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2]
      )
      expect(bit_fields[14]).to have_port(
        :register_block, :valid,
        name: 'i_register_2_bit_field_2_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2]
      )
      expect(bit_fields[16]).to have_port(
        :register_block, :valid,
        name: 'i_register_2_bit_field_4_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2, 2]
      )

      expect(bit_fields[18]).to have_port(
        :register_block, :valid,
        name: 'i_register_file_3_register_file_0_register_0_bit_field_0_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2, 2, 2]
      )
      expect(bit_fields[20]).to have_port(
        :register_block, :valid,
        name: 'i_register_file_3_register_file_0_register_0_bit_field_2_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2, 2, 2]
      )
      expect(bit_fields[22]).to have_port(
        :register_block, :valid,
        name: 'i_register_file_3_register_file_0_register_0_bit_field_4_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2, 2, 2, 2]
      )
    end
  end

  context '参照ビットフィールドを持つ場合' do
    it '入力ポート#validを持たない' do
      expect(bit_fields[1]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_0_bit_field_1_valid', direction: :input, type: :logic, width: 1
      )
      expect(bit_fields[3]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_0_bit_field_3_valid', direction: :input, type: :logic, width: 1
      )
      expect(bit_fields[5]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_0_bit_field_5_valid',
        direction: :input, type: :logic, width: 1, array_size: [2]
      )

      expect(bit_fields[7]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_1_bit_field_1_valid',
        direction: :input, type: :logic, width: 1, array_size: [4]
      )
      expect(bit_fields[9]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_1_bit_field_3_valid',
        direction: :input, type: :logic, width: 1, array_size: [4]
      )
      expect(bit_fields[11]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_1_bit_field_5_valid',
        direction: :input, type: :logic, width: 1, array_size: [4, 2]
      )

      expect(bit_fields[13]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_2_bit_field_1_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2]
      )
      expect(bit_fields[15]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_2_bit_field_3_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2]
      )
      expect(bit_fields[17]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_2_bit_field_5_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2, 2]
      )

      expect(bit_fields[19]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_file_3_register_file_0_register_0_bit_field_1_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2, 2, 2]
      )
      expect(bit_fields[21]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_file_3_register_file_0_register_0_bit_field_3_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2, 2, 2]
      )
      expect(bit_fields[23]).to not_have_port(
        :register_block, :valid,
        name: 'i_register_file_3_register_file_0_register_0_bit_field_5_valid',
        direction: :input, type: :logic, width: 1, array_size: [2, 2, 2, 2, 2]
      )
    end
  end

  describe '#generate_code' do
    it 'rggen::rggen_bit_fieldをインスタンスするコードを出力する' do
      expect(bit_fields[0]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            1,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  i_register_0_bit_field_0_valid,
          i_hw_write_data:    i_register_0_bit_field_0,
          o_value:            o_register_0_bit_field_0
        );
      VERYL

      expect(bit_fields[1]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            1,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  register_if[25].value[0+:1],
          i_hw_write_data:    i_register_0_bit_field_1,
          o_value:            o_register_0_bit_field_1
        );
      VERYL

      expect(bit_fields[2]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            2,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  i_register_0_bit_field_2_valid,
          i_hw_write_data:    i_register_0_bit_field_2,
          o_value:            o_register_0_bit_field_2
        );
      VERYL

      expect(bit_fields[3]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            2,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  register_if[25].value[0+:1],
          i_hw_write_data:    i_register_0_bit_field_3,
          o_value:            o_register_0_bit_field_3
        );
      VERYL

      expect(bit_fields[4]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            4,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  i_register_0_bit_field_4_valid[i],
          i_hw_write_data:    i_register_0_bit_field_4[i],
          o_value:            o_register_0_bit_field_4[i]
        );
      VERYL

      expect(bit_fields[5]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            4,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  register_if[25].value[0+:1],
          i_hw_write_data:    i_register_0_bit_field_5[i],
          o_value:            o_register_0_bit_field_5[i]
        );
      VERYL

      expect(bit_fields[10]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            4,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  i_register_1_bit_field_4_valid[i][j],
          i_hw_write_data:    i_register_1_bit_field_4[i][j],
          o_value:            o_register_1_bit_field_4[i][j]
        );
      VERYL

      expect(bit_fields[11]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            4,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  register_if[25].value[0+:1],
          i_hw_write_data:    i_register_1_bit_field_5[i][j],
          o_value:            o_register_1_bit_field_5[i][j]
        );
      VERYL

      expect(bit_fields[16]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            4,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  i_register_2_bit_field_4_valid[i][j][k],
          i_hw_write_data:    i_register_2_bit_field_4[i][j][k],
          o_value:            o_register_2_bit_field_4[i][j][k]
        );
      VERYL

      expect(bit_fields[17]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            4,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  register_if[25].value[0+:1],
          i_hw_write_data:    i_register_2_bit_field_5[i][j][k],
          o_value:            o_register_2_bit_field_5[i][j][k]
        );
      VERYL

      expect(bit_fields[22]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            4,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  i_register_file_3_register_file_0_register_0_bit_field_4_valid[i][j][k][l][m],
          i_hw_write_data:    i_register_file_3_register_file_0_register_0_bit_field_4[i][j][k][l][m],
          o_value:            o_register_file_3_register_file_0_register_0_bit_field_4[i][j][k][l][m]
        );
      VERYL

      expect(bit_fields[23]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:            4,
          INITIAL_VALUE:    INITIAL_VALUE,
          SW_WRITE_ACTION:  rggen_sw_action::WRITE_NONE,
          HW_WRITE:         true
        )(
          i_clk:              i_clk,
          i_rst:              i_rst,
          bit_field_if:       bit_field_sub_if,
          i_hw_write_enable:  register_if[26+2*i+j].value[0+:1],
          i_hw_write_data:    i_register_file_3_register_file_0_register_0_bit_field_5[i][j][k][l][m],
          o_value:            o_register_file_3_register_file_0_register_0_bit_field_5[i][j][k][l][m]
        );
      VERYL
    end
  end
end
