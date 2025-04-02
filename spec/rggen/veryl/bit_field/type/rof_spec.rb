# frozen_string_literal: true

RSpec.describe 'bit_field/type/rof' do
  include_context 'clean-up builder'
  include_context 'bit field common'

  before(:all) do
    RgGen.enable(:bit_field, :type, [:rof])
  end

  describe '#generate_code' do
    it 'rggen::rggen_bit_fieldをインスタンスするコードを出力する' do
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
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              1,
          SW_WRITE_ACTION:    rggen_sw_action::WRITE_NONE,
          STORAGE:            false,
          EXTERNAL_READ_DATA: true
        )(
          i_clk:        i_clk,
          i_rst:        i_rst,
          bit_field_if: bit_field_sub_if,
          i_value:      INITIAL_VALUE
        );
      VERYL

      expect(bit_fields[1]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              16,
          SW_WRITE_ACTION:    rggen_sw_action::WRITE_NONE,
          STORAGE:            false,
          EXTERNAL_READ_DATA: true
        )(
          i_clk:        i_clk,
          i_rst:        i_rst,
          bit_field_if: bit_field_sub_if,
          i_value:      INITIAL_VALUE
        );
      VERYL

      expect(bit_fields[2]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              1,
          SW_WRITE_ACTION:    rggen_sw_action::WRITE_NONE,
          STORAGE:            false,
          EXTERNAL_READ_DATA: true
        )(
          i_clk:        i_clk,
          i_rst:        i_rst,
          bit_field_if: bit_field_sub_if,
          i_value:      INITIAL_VALUE
        );
      VERYL

      expect(bit_fields[3]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              16,
          SW_WRITE_ACTION:    rggen_sw_action::WRITE_NONE,
          STORAGE:            false,
          EXTERNAL_READ_DATA: true
        )(
          i_clk:        i_clk,
          i_rst:        i_rst,
          bit_field_if: bit_field_sub_if,
          i_value:      INITIAL_VALUE
        );
      VERYL
    end
  end
end
