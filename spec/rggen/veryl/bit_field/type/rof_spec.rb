# frozen_string_literal: true

RSpec.describe 'bit_field/type/rof' do
  include_context 'clean-up builder'
  include_context 'bit field common'

  before(:all) do
    RgGen.enable(:bit_field, :type, [:rof])
  end

  describe '#generate_code' do
    it 'rggen_bit_fieldをインスタンスするコードを出力する' do
      bit_fields = create_bit_fields do
        byte_size 256

        register do
          name 'register_0'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rof; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 16, width: 16; type :rof; initial_value 0xabcd }
        end

        register_file do
          name 'register_file_1'
          size [2, 2]
          register_file do
            name 'register_file_0'
            register do
              name 'register_0'
              size [2, 2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rof; initial_value 0 }
              bit_field { name 'bit_field_1'; bit_assignment lsb: 16, width: 16; type :rof; initial_value 0xabcd }
            end
          end
        end
      end

      expect(bit_fields[0]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen_bit_field #(
          WIDTH:              1,
          STORAGE:            0,
          EXTERNAL_READ_DATA: 1
        )(
          i_clk:              '0,
          i_rst:              '0,
          bit_field_if:       bit_field_sub_if,
          o_write_trigger:    _,
          o_read_trigger:     _,
          i_sw_write_enable:  '0,
          i_hw_write_enable:  '0,
          i_hw_write_data:    '0,
          i_hw_set:           '0,
          i_hw_clear:         '0,
          i_value:            INITIAL_VALUE,
          i_mask:             '1,
          o_value:            _,
          o_value_unmasked:   _
        );
      VERYL

      expect(bit_fields[1]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen_bit_field #(
          WIDTH:              16,
          STORAGE:            0,
          EXTERNAL_READ_DATA: 1
        )(
          i_clk:              '0,
          i_rst:              '0,
          bit_field_if:       bit_field_sub_if,
          o_write_trigger:    _,
          o_read_trigger:     _,
          i_sw_write_enable:  '0,
          i_hw_write_enable:  '0,
          i_hw_write_data:    '0,
          i_hw_set:           '0,
          i_hw_clear:         '0,
          i_value:            INITIAL_VALUE,
          i_mask:             '1,
          o_value:            _,
          o_value_unmasked:   _
        );
      VERYL

      expect(bit_fields[2]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen_bit_field #(
          WIDTH:              1,
          STORAGE:            0,
          EXTERNAL_READ_DATA: 1
        )(
          i_clk:              '0,
          i_rst:              '0,
          bit_field_if:       bit_field_sub_if,
          o_write_trigger:    _,
          o_read_trigger:     _,
          i_sw_write_enable:  '0,
          i_hw_write_enable:  '0,
          i_hw_write_data:    '0,
          i_hw_set:           '0,
          i_hw_clear:         '0,
          i_value:            INITIAL_VALUE,
          i_mask:             '1,
          o_value:            _,
          o_value_unmasked:   _
        );
      VERYL

      expect(bit_fields[3]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen_bit_field #(
          WIDTH:              16,
          STORAGE:            0,
          EXTERNAL_READ_DATA: 1
        )(
          i_clk:              '0,
          i_rst:              '0,
          bit_field_if:       bit_field_sub_if,
          o_write_trigger:    _,
          o_read_trigger:     _,
          i_sw_write_enable:  '0,
          i_hw_write_enable:  '0,
          i_hw_write_data:    '0,
          i_hw_set:           '0,
          i_hw_clear:         '0,
          i_value:            INITIAL_VALUE,
          i_mask:             '1,
          o_value:            _,
          o_value_unmasked:   _
        );
      VERYL
    end
  end
end