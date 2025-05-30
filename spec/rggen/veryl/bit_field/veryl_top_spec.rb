# frozen_string_literal: true

RSpec.describe 'bit_field/veryl_top' do
  include_context 'veryl common'
  include_context 'clean-up builder'

  before(:all) do
    RgGen.enable_all
  end

  def create_bit_fields(&body)
    configuration = create_configuration(enable_wide_register: true)
    create_veryl(configuration, &body).bit_fields
  end

  describe '#initial_value' do
    context '単一の初期値が指定されている場合' do
      it '固定値initial_valueを持つ' do
        bit_fields = create_bit_fields do
          name 'block_0'
          byte_size 256

          register do
            name 'register_0'
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
            bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value 1 }
            bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value 2 }
          end

          register do
            name 'register_1'
            size [2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
            bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value 1 }
            bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value 2 }
          end

          register_file do
            name 'register_file_2'
            register do
              name 'register_0'
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
              bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value 1 }
              bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value 2 }
            end
          end

          register_file do
            name 'register_file_3'
            size [2]
            register do
              name 'register_0'
              size [2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
              bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value 1 }
              bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value 2 }
            end
          end
        end

        expect(bit_fields[0]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 1, default: "1'h0"
        )
        expect(bit_fields[1]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 8, default: "8'h01"
        )
        expect(bit_fields[2]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 8, default: "8'h02"
        )

        expect(bit_fields[3]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 1, default: "1'h0"
        )
        expect(bit_fields[4]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 8, default: "8'h01"
        )
        expect(bit_fields[5]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 8, default: "8'h02"
        )

        expect(bit_fields[6]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 1, default: "1'h0"
        )
        expect(bit_fields[7]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 8, default: "8'h01"
        )
        expect(bit_fields[8]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 8, default: "8'h02"
        )

        expect(bit_fields[9]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 1, default: "1'h0"
        )
        expect(bit_fields[10]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 8, default: "8'h01"
        )
        expect(bit_fields[11]).to have_const(
          :initial_value,
          name: 'INITIAL_VALUE', type: :bit, width: 8, default: "8'h02"
        )
      end
    end

    context 'パラメータ化された初期値が指定された場合' do
      it 'パラメータinitial_valueを持つ' do
        bit_fields = create_bit_fields do
          name 'block_0'
          byte_size 256

          register do
            name 'register_0'
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value default: 0 }
            bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value default: 1 }
            bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value default: 2 }
          end

          register do
            name 'register_1'
            size [2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value default: 0 }
            bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value default: 1 }
            bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value default: 2 }
          end

          register_file do
            name 'register_file_2'
            register do
              name 'register_0'
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value default: 0 }
              bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value default: 1 }
              bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value default: 2 }
            end
          end

          register_file do
            name 'register_file_3'
            size [2]
            register do
              name 'register_0'
              size [2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value default: 0 }
              bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value default: 1 }
              bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value default: 2 }
            end
          end
        end

        expect(bit_fields[0]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_0_BIT_FIELD_0_INITIAL_VALUE", type: :bit, width: 1, default: "1'h0"
        )
        expect(bit_fields[1]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_0_BIT_FIELD_1_INITIAL_VALUE", type: :bit, width: 8, default: "8'h01"
        )
        expect(bit_fields[2]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_0_BIT_FIELD_2_INITIAL_VALUE", type: :bit, width: 8,
          array_size: [2], default: "{8'h02 repeat 2}"
        )
        expect(bit_fields[3]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_1_BIT_FIELD_0_INITIAL_VALUE", type: :bit,
          width: 1, array_size: [2], default: "{1'h0 repeat 2}"
        )
        expect(bit_fields[4]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_1_BIT_FIELD_1_INITIAL_VALUE", type: :bit,
          width: 8, array_size:[2], default: "{8'h01 repeat 2}"
        )
        expect(bit_fields[5]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_1_BIT_FIELD_2_INITIAL_VALUE", type: :bit,
          width: 8, array_size: [2, 2], default: "{8'h02 repeat 4}"
        )
        expect(bit_fields[6]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_FILE_2_REGISTER_0_BIT_FIELD_0_INITIAL_VALUE", type: :bit, width: 1, default: "1'h0"
        )
        expect(bit_fields[7]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_FILE_2_REGISTER_0_BIT_FIELD_1_INITIAL_VALUE", type: :bit, width: 8, default: "8'h01"
        )
        expect(bit_fields[8]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_FILE_2_REGISTER_0_BIT_FIELD_2_INITIAL_VALUE", type: :bit, width: 8,
          array_size: [2], default: "{8'h02 repeat 2}"
        )
        expect(bit_fields[9]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_FILE_3_REGISTER_0_BIT_FIELD_0_INITIAL_VALUE", type: :bit,
          width: 1, array_size: [2, 2], default: "{1'h0 repeat 4}"
        )
        expect(bit_fields[10]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_FILE_3_REGISTER_0_BIT_FIELD_1_INITIAL_VALUE", type: :bit,
          width: 8, array_size: [2, 2], default: "{8'h01 repeat 4}"
        )
        expect(bit_fields[11]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_FILE_3_REGISTER_0_BIT_FIELD_2_INITIAL_VALUE", type: :bit,
          width: 8, array_size: [2, 2, 2], default: "{8'h02 repeat 8}"
        )
      end
    end

    context '配列化された初期値が指定された場合' do
      it '固定値initial_valueを持つ' do
        bit_fields = create_bit_fields do
          name 'block_0'
          byte_size 256

          register do
            name 'register_0'
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 8, sequence_size: 1; type :rw; initial_value [0] }
            bit_field { name 'bit_field_1'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value [1, 2] }
          end

          register do
            name 'register_1'
            size [2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 8, sequence_size: 1; type :rw; initial_value [[0], [1]] }
            bit_field { name 'bit_field_1'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value [[1, 2], [3, 4]] }
          end

          register_file do
            name 'register_file_2'
            register do
              name 'register_0'
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 8, sequence_size: 1; type :rw; initial_value [0] }
              bit_field { name 'bit_field_1'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value [1, 2] }
            end
          end

          register_file do
            name 'register_file_3'
            size [2]
            register do
              name 'register_0'
              size [2]
              bit_field {
                name 'bit_field_0'; bit_assignment lsb: 0, width: 8, sequence_size: 1
                type :rw; initial_value [[[0], [1]], [[2], [3]]]
              }
              bit_field {
                name 'bit_field_1'; bit_assignment lsb: 16, width: 8, sequence_size: 2
                type :rw; initial_value [[[1, 2], [3, 4]], [[5, 6], [7, 8]]]
              }
            end
          end
        end

        expect(bit_fields[0]).to have_const(
          :initial_value,
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [1], default: "{8'h00}"
        )
        expect(bit_fields[1]).to have_const(
          :initial_value,
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [2], default: "{8'h02, 8'h01}"
        )
        expect(bit_fields[2]).to have_const(
          :initial_value,
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [2, 1], default: "{8'h01, 8'h00}"
        )
        expect(bit_fields[3]).to have_const(
          :initial_value,
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [2, 2], default: "{8'h04, 8'h03, 8'h02, 8'h01}"
        )
        expect(bit_fields[4]).to have_const(
          :initial_value,
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [1], default: "{8'h00}"
        )
        expect(bit_fields[5]).to have_const(
          :initial_value,
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [2], default: "{8'h02, 8'h01}"
        )
        expect(bit_fields[6]).to have_const(
          :initial_value,
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [2, 2, 1], default: "{8'h03, 8'h02, 8'h01, 8'h00}"
        )
        expect(bit_fields[7]).to have_const(
          :initial_value,
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [2, 2, 2], default: "{8'h08, 8'h07, 8'h06, 8'h05, 8'h04, 8'h03, 8'h02, 8'h01}"
        )
      end
    end
  end

  describe '#bit_field_sub_if' do
    it 'rggen::rggen_bit_field_ifのインスタンスを持つ' do
      bit_fields = create_bit_fields do
        name 'block_0'
        byte_size 256

        register do
          name 'register_0'
          offset_address 0x00
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value 0 }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value 0 }
          bit_field { name 'bit_field_3'; bit_assignment lsb: 32, width: 64; type :rw; initial_value 0 }
        end
      end

      expect(bit_fields[0]).to have_interface(
        :bit_field_sub_if,
        name: 'bit_field_sub_if', interface_type: 'rggen::rggen_bit_field_if', param_values: { WIDTH: 1 }
      )
      expect(bit_fields[1]).to have_interface(
        :bit_field_sub_if,
        name: 'bit_field_sub_if', interface_type: 'rggen::rggen_bit_field_if', param_values: { WIDTH: 8 }
      )
      expect(bit_fields[2]).to have_interface(
        :bit_field_sub_if,
        name: 'bit_field_sub_if', interface_type: 'rggen::rggen_bit_field_if', param_values: { WIDTH: 8 }
      )
      expect(bit_fields[3]).to have_interface(
        :bit_field_sub_if,
        name: 'bit_field_sub_if', interface_type: 'rggen::rggen_bit_field_if', param_values: { WIDTH: 64 }
      )
    end
  end

  describe '#generate_code' do
    it 'ビットフィールド階層のコードを出力する' do
      bit_fields = create_bit_fields do
        name 'block_0'
        byte_size 256

        register do
          name 'register_0'
          offset_address 0x00
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value 0 }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, sequence_size: 2; type :rw; initial_value 0 }
          bit_field { name 'bit_field_3'; bit_assignment lsb: 20, width: 2, sequence_size: 2; type :rw; initial_value default: 0 }
          bit_field { name 'bit_field_4'; bit_assignment lsb: 24, width: 2, sequence_size: 2, step: 4; type :rw; initial_value [0, 1] }
        end

        register do
          name 'register_1'
          offset_address 0x10
          size [4]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value 0 }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, sequence_size: 2; type :rw; initial_value 0 }
          bit_field { name 'bit_field_3'; bit_assignment lsb: 20, width: 2, sequence_size: 2; type :rw; initial_value default: 0 }
          bit_field {
            name 'bit_field_4'; bit_assignment lsb: 24, width: 2, sequence_size: 2, step: 4
            type :rw; initial_value [[0, 1], [2, 3], [3, 2], [1, 0]]
          }
        end

        register do
          name 'register_2'
          offset_address 0x20
          size [2, 2]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 8; type :rw; initial_value 0 }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, sequence_size: 2; type :rw; initial_value 0 }
          bit_field { name 'bit_field_3'; bit_assignment lsb: 20, width: 2, sequence_size: 2; type :rw; initial_value default: 0 }
          bit_field {
            name 'bit_field_4'; bit_assignment lsb: 24, width: 2, sequence_size: 2, step: 4
            type :rw; initial_value [[[0, 1], [2, 3]], [[3, 2], [1, 0]]]
          }
        end

        register do
          name 'register_3'
          offset_address 0x30
          bit_field { bit_assignment lsb: 0, width: 32; type :rw; initial_value 0 }
        end
      end

      expect(bit_fields[0]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_0 {
          const INITIAL_VALUE: bit = 1'h0;
          inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
          always_comb {
            bit_field_sub_if.read_valid = bit_field_if.read_valid;
            bit_field_sub_if.write_valid = bit_field_if.write_valid;
            bit_field_sub_if.mask = bit_field_if.mask[0+:1];
            bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
            bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
            bit_field_if.value[0+:1] = bit_field_sub_if.value;
          }
          inst u_bit_field: rggen::rggen_bit_field #(
            WIDTH:          1,
            INITIAL_VALUE:  INITIAL_VALUE,
            SW_WRITE_ONCE:  false,
            TRIGGER:        false
          )(
            i_clk:            i_clk,
            i_rst:            i_rst,
            bit_field_if:     bit_field_sub_if,
            o_write_trigger:  _,
            o_read_trigger:   _,
            o_value:          o_register_0_bit_field_0
          );
        }
      VERYL

      expect(bit_fields[1]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_1 {
          const INITIAL_VALUE: bit<8> = 8'h00;
          inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 8);
          always_comb {
            bit_field_sub_if.read_valid = bit_field_if.read_valid;
            bit_field_sub_if.write_valid = bit_field_if.write_valid;
            bit_field_sub_if.mask = bit_field_if.mask[8+:8];
            bit_field_sub_if.write_data = bit_field_if.write_data[8+:8];
            bit_field_if.read_data[8+:8] = bit_field_sub_if.read_data;
            bit_field_if.value[8+:8] = bit_field_sub_if.value;
          }
          inst u_bit_field: rggen::rggen_bit_field #(
            WIDTH:          8,
            INITIAL_VALUE:  INITIAL_VALUE,
            SW_WRITE_ONCE:  false,
            TRIGGER:        false
          )(
            i_clk:            i_clk,
            i_rst:            i_rst,
            bit_field_if:     bit_field_sub_if,
            o_write_trigger:  _,
            o_read_trigger:   _,
            o_value:          o_register_0_bit_field_1
          );
        }
      VERYL

      expect(bit_fields[2]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_2 {
          for i in 0..2 :g {
            const INITIAL_VALUE: bit = 1'h0;
            inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
            always_comb {
              bit_field_sub_if.read_valid = bit_field_if.read_valid;
              bit_field_sub_if.write_valid = bit_field_if.write_valid;
              bit_field_sub_if.mask = bit_field_if.mask[16+1*i+:1];
              bit_field_sub_if.write_data = bit_field_if.write_data[16+1*i+:1];
              bit_field_if.read_data[16+1*i+:1] = bit_field_sub_if.read_data;
              bit_field_if.value[16+1*i+:1] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen::rggen_bit_field #(
              WIDTH:          1,
              INITIAL_VALUE:  INITIAL_VALUE,
              SW_WRITE_ONCE:  false,
              TRIGGER:        false
            )(
              i_clk:            i_clk,
              i_rst:            i_rst,
              bit_field_if:     bit_field_sub_if,
              o_write_trigger:  _,
              o_read_trigger:   _,
              o_value:          o_register_0_bit_field_2[i]
            );
          }
        }
      VERYL

      expect(bit_fields[3]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_3 {
          for i in 0..2 :g {
            inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 2);
            always_comb {
              bit_field_sub_if.read_valid = bit_field_if.read_valid;
              bit_field_sub_if.write_valid = bit_field_if.write_valid;
              bit_field_sub_if.mask = bit_field_if.mask[20+2*i+:2];
              bit_field_sub_if.write_data = bit_field_if.write_data[20+2*i+:2];
              bit_field_if.read_data[20+2*i+:2] = bit_field_sub_if.read_data;
              bit_field_if.value[20+2*i+:2] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen::rggen_bit_field #(
              WIDTH:          2,
              INITIAL_VALUE:  REGISTER_0_BIT_FIELD_3_INITIAL_VALUE[i],
              SW_WRITE_ONCE:  false,
              TRIGGER:        false
            )(
              i_clk:            i_clk,
              i_rst:            i_rst,
              bit_field_if:     bit_field_sub_if,
              o_write_trigger:  _,
              o_read_trigger:   _,
              o_value:          o_register_0_bit_field_3[i]
            );
          }
        }
      VERYL

      expect(bit_fields[4]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_4 {
          for i in 0..2 :g {
            const INITIAL_VALUE: bit<2, 2> = {2'h1, 2'h0};
            inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 2);
            always_comb {
              bit_field_sub_if.read_valid = bit_field_if.read_valid;
              bit_field_sub_if.write_valid = bit_field_if.write_valid;
              bit_field_sub_if.mask = bit_field_if.mask[24+4*i+:2];
              bit_field_sub_if.write_data = bit_field_if.write_data[24+4*i+:2];
              bit_field_if.read_data[24+4*i+:2] = bit_field_sub_if.read_data;
              bit_field_if.value[24+4*i+:2] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen::rggen_bit_field #(
              WIDTH:          2,
              INITIAL_VALUE:  INITIAL_VALUE[i],
              SW_WRITE_ONCE:  false,
              TRIGGER:        false
            )(
              i_clk:            i_clk,
              i_rst:            i_rst,
              bit_field_if:     bit_field_sub_if,
              o_write_trigger:  _,
              o_read_trigger:   _,
              o_value:          o_register_0_bit_field_4[i]
            );
          }
        }
      VERYL

      expect(bit_fields[5]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_0 {
          const INITIAL_VALUE: bit = 1'h0;
          inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
          always_comb {
            bit_field_sub_if.read_valid = bit_field_if.read_valid;
            bit_field_sub_if.write_valid = bit_field_if.write_valid;
            bit_field_sub_if.mask = bit_field_if.mask[0+:1];
            bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
            bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
            bit_field_if.value[0+:1] = bit_field_sub_if.value;
          }
          inst u_bit_field: rggen::rggen_bit_field #(
            WIDTH:          1,
            INITIAL_VALUE:  INITIAL_VALUE,
            SW_WRITE_ONCE:  false,
            TRIGGER:        false
          )(
            i_clk:            i_clk,
            i_rst:            i_rst,
            bit_field_if:     bit_field_sub_if,
            o_write_trigger:  _,
            o_read_trigger:   _,
            o_value:          o_register_1_bit_field_0[i]
          );
        }
      VERYL

      expect(bit_fields[6]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_1 {
          const INITIAL_VALUE: bit<8> = 8'h00;
          inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 8);
          always_comb {
            bit_field_sub_if.read_valid = bit_field_if.read_valid;
            bit_field_sub_if.write_valid = bit_field_if.write_valid;
            bit_field_sub_if.mask = bit_field_if.mask[8+:8];
            bit_field_sub_if.write_data = bit_field_if.write_data[8+:8];
            bit_field_if.read_data[8+:8] = bit_field_sub_if.read_data;
            bit_field_if.value[8+:8] = bit_field_sub_if.value;
          }
          inst u_bit_field: rggen::rggen_bit_field #(
            WIDTH:          8,
            INITIAL_VALUE:  INITIAL_VALUE,
            SW_WRITE_ONCE:  false,
            TRIGGER:        false
          )(
            i_clk:            i_clk,
            i_rst:            i_rst,
            bit_field_if:     bit_field_sub_if,
            o_write_trigger:  _,
            o_read_trigger:   _,
            o_value:          o_register_1_bit_field_1[i]
          );
        }
      VERYL

      expect(bit_fields[7]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_2 {
          for j in 0..2 :g {
            const INITIAL_VALUE: bit = 1'h0;
            inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
            always_comb {
              bit_field_sub_if.read_valid = bit_field_if.read_valid;
              bit_field_sub_if.write_valid = bit_field_if.write_valid;
              bit_field_sub_if.mask = bit_field_if.mask[16+1*j+:1];
              bit_field_sub_if.write_data = bit_field_if.write_data[16+1*j+:1];
              bit_field_if.read_data[16+1*j+:1] = bit_field_sub_if.read_data;
              bit_field_if.value[16+1*j+:1] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen::rggen_bit_field #(
              WIDTH:          1,
              INITIAL_VALUE:  INITIAL_VALUE,
              SW_WRITE_ONCE:  false,
              TRIGGER:        false
            )(
              i_clk:            i_clk,
              i_rst:            i_rst,
              bit_field_if:     bit_field_sub_if,
              o_write_trigger:  _,
              o_read_trigger:   _,
              o_value:          o_register_1_bit_field_2[i][j]
            );
          }
        }
      VERYL

      expect(bit_fields[8]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_3 {
          for j in 0..2 :g {
            inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 2);
            always_comb {
              bit_field_sub_if.read_valid = bit_field_if.read_valid;
              bit_field_sub_if.write_valid = bit_field_if.write_valid;
              bit_field_sub_if.mask = bit_field_if.mask[20+2*j+:2];
              bit_field_sub_if.write_data = bit_field_if.write_data[20+2*j+:2];
              bit_field_if.read_data[20+2*j+:2] = bit_field_sub_if.read_data;
              bit_field_if.value[20+2*j+:2] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen::rggen_bit_field #(
              WIDTH:          2,
              INITIAL_VALUE:  REGISTER_1_BIT_FIELD_3_INITIAL_VALUE[i][j],
              SW_WRITE_ONCE:  false,
              TRIGGER:        false
            )(
              i_clk:            i_clk,
              i_rst:            i_rst,
              bit_field_if:     bit_field_sub_if,
              o_write_trigger:  _,
              o_read_trigger:   _,
              o_value:          o_register_1_bit_field_3[i][j]
            );
          }
        }
      VERYL

      expect(bit_fields[9]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_4 {
          for j in 0..2 :g {
            const INITIAL_VALUE: bit<4, 2, 2> = {2'h0, 2'h1, 2'h2, 2'h3, 2'h3, 2'h2, 2'h1, 2'h0};
            inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 2);
            always_comb {
              bit_field_sub_if.read_valid = bit_field_if.read_valid;
              bit_field_sub_if.write_valid = bit_field_if.write_valid;
              bit_field_sub_if.mask = bit_field_if.mask[24+4*j+:2];
              bit_field_sub_if.write_data = bit_field_if.write_data[24+4*j+:2];
              bit_field_if.read_data[24+4*j+:2] = bit_field_sub_if.read_data;
              bit_field_if.value[24+4*j+:2] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen::rggen_bit_field #(
              WIDTH:          2,
              INITIAL_VALUE:  INITIAL_VALUE[i][j],
              SW_WRITE_ONCE:  false,
              TRIGGER:        false
            )(
              i_clk:            i_clk,
              i_rst:            i_rst,
              bit_field_if:     bit_field_sub_if,
              o_write_trigger:  _,
              o_read_trigger:   _,
              o_value:          o_register_1_bit_field_4[i][j]
            );
          }
        }
      VERYL

      expect(bit_fields[10]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_0 {
          const INITIAL_VALUE: bit = 1'h0;
          inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
          always_comb {
            bit_field_sub_if.read_valid = bit_field_if.read_valid;
            bit_field_sub_if.write_valid = bit_field_if.write_valid;
            bit_field_sub_if.mask = bit_field_if.mask[0+:1];
            bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
            bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
            bit_field_if.value[0+:1] = bit_field_sub_if.value;
          }
          inst u_bit_field: rggen::rggen_bit_field #(
            WIDTH:          1,
            INITIAL_VALUE:  INITIAL_VALUE,
            SW_WRITE_ONCE:  false,
            TRIGGER:        false
          )(
            i_clk:            i_clk,
            i_rst:            i_rst,
            bit_field_if:     bit_field_sub_if,
            o_write_trigger:  _,
            o_read_trigger:   _,
            o_value:          o_register_2_bit_field_0[i][j]
          );
        }
      VERYL

      expect(bit_fields[11]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_1 {
          const INITIAL_VALUE: bit<8> = 8'h00;
          inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 8);
          always_comb {
            bit_field_sub_if.read_valid = bit_field_if.read_valid;
            bit_field_sub_if.write_valid = bit_field_if.write_valid;
            bit_field_sub_if.mask = bit_field_if.mask[8+:8];
            bit_field_sub_if.write_data = bit_field_if.write_data[8+:8];
            bit_field_if.read_data[8+:8] = bit_field_sub_if.read_data;
            bit_field_if.value[8+:8] = bit_field_sub_if.value;
          }
          inst u_bit_field: rggen::rggen_bit_field #(
            WIDTH:          8,
            INITIAL_VALUE:  INITIAL_VALUE,
            SW_WRITE_ONCE:  false,
            TRIGGER:        false
          )(
            i_clk:            i_clk,
            i_rst:            i_rst,
            bit_field_if:     bit_field_sub_if,
            o_write_trigger:  _,
            o_read_trigger:   _,
            o_value:          o_register_2_bit_field_1[i][j]
          );
        }
      VERYL

      expect(bit_fields[12]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_2 {
          for k in 0..2 :g {
            const INITIAL_VALUE: bit = 1'h0;
            inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
            always_comb {
              bit_field_sub_if.read_valid = bit_field_if.read_valid;
              bit_field_sub_if.write_valid = bit_field_if.write_valid;
              bit_field_sub_if.mask = bit_field_if.mask[16+1*k+:1];
              bit_field_sub_if.write_data = bit_field_if.write_data[16+1*k+:1];
              bit_field_if.read_data[16+1*k+:1] = bit_field_sub_if.read_data;
              bit_field_if.value[16+1*k+:1] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen::rggen_bit_field #(
              WIDTH:          1,
              INITIAL_VALUE:  INITIAL_VALUE,
              SW_WRITE_ONCE:  false,
              TRIGGER:        false
            )(
              i_clk:            i_clk,
              i_rst:            i_rst,
              bit_field_if:     bit_field_sub_if,
              o_write_trigger:  _,
              o_read_trigger:   _,
              o_value:          o_register_2_bit_field_2[i][j][k]
            );
          }
        }
      VERYL

      expect(bit_fields[13]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_3 {
          for k in 0..2 :g {
            inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 2);
            always_comb {
              bit_field_sub_if.read_valid = bit_field_if.read_valid;
              bit_field_sub_if.write_valid = bit_field_if.write_valid;
              bit_field_sub_if.mask = bit_field_if.mask[20+2*k+:2];
              bit_field_sub_if.write_data = bit_field_if.write_data[20+2*k+:2];
              bit_field_if.read_data[20+2*k+:2] = bit_field_sub_if.read_data;
              bit_field_if.value[20+2*k+:2] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen::rggen_bit_field #(
              WIDTH:          2,
              INITIAL_VALUE:  REGISTER_2_BIT_FIELD_3_INITIAL_VALUE[i][j][k],
              SW_WRITE_ONCE:  false,
              TRIGGER:        false
            )(
              i_clk:            i_clk,
              i_rst:            i_rst,
              bit_field_if:     bit_field_sub_if,
              o_write_trigger:  _,
              o_read_trigger:   _,
              o_value:          o_register_2_bit_field_3[i][j][k]
            );
          }
        }
      VERYL

      expect(bit_fields[14]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_bit_field_4 {
          for k in 0..2 :g {
            const INITIAL_VALUE: bit<2, 2, 2, 2> = {2'h0, 2'h1, 2'h2, 2'h3, 2'h3, 2'h2, 2'h1, 2'h0};
            inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 2);
            always_comb {
              bit_field_sub_if.read_valid = bit_field_if.read_valid;
              bit_field_sub_if.write_valid = bit_field_if.write_valid;
              bit_field_sub_if.mask = bit_field_if.mask[24+4*k+:2];
              bit_field_sub_if.write_data = bit_field_if.write_data[24+4*k+:2];
              bit_field_if.read_data[24+4*k+:2] = bit_field_sub_if.read_data;
              bit_field_if.value[24+4*k+:2] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen::rggen_bit_field #(
              WIDTH:          2,
              INITIAL_VALUE:  INITIAL_VALUE[i][j][k],
              SW_WRITE_ONCE:  false,
              TRIGGER:        false
            )(
              i_clk:            i_clk,
              i_rst:            i_rst,
              bit_field_if:     bit_field_sub_if,
              o_write_trigger:  _,
              o_read_trigger:   _,
              o_value:          o_register_2_bit_field_4[i][j][k]
            );
          }
        }
      VERYL

      expect(bit_fields[15]).to generate_code(:register, :top_down, <<~'VERYL')
        :g_register_3 {
          const INITIAL_VALUE: bit<32> = 32'h00000000;
          inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 32);
          always_comb {
            bit_field_sub_if.read_valid = bit_field_if.read_valid;
            bit_field_sub_if.write_valid = bit_field_if.write_valid;
            bit_field_sub_if.mask = bit_field_if.mask[0+:32];
            bit_field_sub_if.write_data = bit_field_if.write_data[0+:32];
            bit_field_if.read_data[0+:32] = bit_field_sub_if.read_data;
            bit_field_if.value[0+:32] = bit_field_sub_if.value;
          }
          inst u_bit_field: rggen::rggen_bit_field #(
            WIDTH:          32,
            INITIAL_VALUE:  INITIAL_VALUE,
            SW_WRITE_ONCE:  false,
            TRIGGER:        false
          )(
            i_clk:            i_clk,
            i_rst:            i_rst,
            bit_field_if:     bit_field_sub_if,
            o_write_trigger:  _,
            o_read_trigger:   _,
            o_value:          o_register_3
          );
        }
      VERYL
    end
  end
end
