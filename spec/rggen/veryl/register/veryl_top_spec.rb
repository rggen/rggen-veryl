# frozen_string_literal: true

RSpec.describe 'register/veryl_top' do
  include_context 'veryl common'
  include_context 'clean-up builder'

  before(:all) do
    RgGen.enable_all
  end

  def create_registers(&body)
    create_veryl(&body).registers
  end

  describe 'bit_field_if' do
    context 'レジスタがビットフィールドを持つ場合' do
      it 'rggen_bit_field_ifのインスタンスを持つ' do
        registers = create_registers do
          name 'block_0'
          byte_size 256

          register do
            name 'register_0'
            offset_address 0x00
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
          end

          register do
            name 'register_1'
            offset_address 0x10
            bit_field { name 'bit_field_0'; bit_assignment lsb: 32; type :rw; initial_value 0 }
          end

          register do
            name 'register_2'
            offset_address 0x20
            size [2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
          end

          register do
            name 'register_3'
            offset_address 0x30
            size [2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 32; type :rw; initial_value 0 }
          end

          register do
            name 'register_4'
            offset_address 0x40
            size [2, 2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
          end

          register do
            name 'register_5'
            offset_address 0x50
            size [2, 2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 32; type :rw; initial_value 0 }
          end
        end

        expect(registers[0])
          .to have_interface(
            :bit_field_if,
            name: 'bit_field_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 32 }
          )
        expect(registers[1])
          .to have_interface(
            :bit_field_if,
            name: 'bit_field_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 64 }
          )
        expect(registers[2])
          .to have_interface(
            :bit_field_if,
            name: 'bit_field_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 32 }
          )
        expect(registers[3])
          .to have_interface(
            :bit_field_if,
            name: 'bit_field_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 64 }
          )
        expect(registers[4])
          .to have_interface(
            :bit_field_if,
            name: 'bit_field_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 32 }
          )
        expect(registers[5])
          .to have_interface(
            :bit_field_if,
            name: 'bit_field_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 64 }
          )
      end
    end

    context 'レジスタがビットフィールドを持たない場合' do
      it 'rggen_bit_field_ifのインスタンスを持たない' do
        registers = create_registers do
          name 'block_0'
          byte_size 256
          register do
            name 'register_0'
            offset_address 0x00
            size [64]
            type :external
          end
        end

        expect(registers[0])
          .to not_have_interface(
            :bit_field_if,
            name: 'bit_field_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 32 }
          )
      end
    end
  end

  describe '#generate_code' do
    it 'レジスタ階層のコードを出力する' do
      registers = create_registers do
        name 'block_0'
        byte_size 256

        register do
          name 'register_0'
          offset_address 0x00
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 2; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rw; initial_value 0 }
        end

        register do
          name 'register_1'
          offset_address 0x10
          type :external
          size [4]
        end

        register do
          name 'register_2'
          offset_address 0x20
          size [4]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 2; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rw; initial_value 0 }
        end

        register do
          name 'register_3'
          offset_address 0x30
          size [2, step: 8]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 2; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rw; initial_value 0 }
        end

        register do
          name 'register_4'
          offset_address 0x40
          type [:indirect, 'register_0.bit_field_0', 'register_0.bit_field_1']
          size [2, 2]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 2; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rw; initial_value 0 }
        end

        register do
          name 'register_5'
          offset_address 0x50
          bit_field { bit_assignment lsb: 0, width: 2; type :rw; initial_value 0 }
        end

        register_file do
          name 'register_file_6'
          offset_address 0x60
          size [2, 2]
          register_file do
            name 'register_file_0'
            offset_address 0x00
            register do
              name 'register_0'
              offset_address 0x00
              size [2, 2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 2; type :rw; initial_value 0 }
            end
          end
        end

        register_file do
          name 'register_file_7'
          offset_address 0xA0
          size [2, step: 32]
          register_file do
            name 'register_file_0'
            offset_address 0x00
            register do
              name 'register_0'
              offset_address 0x00
              size [2, step: 8]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 2; type :rw; initial_value 0 }
            end
          end
        end
      end

      expect(registers[0]).to generate_code(:register_file, :top_down, <<~'VERYL')
        :g_register_0 {
          inst bit_field_if: rggen_bit_field_if#(WIDTH: 32);
          inst u_register: rggen_default_register #(
            READABLE:       1,
            WRITABLE:       1,
            ADDRESS_WIDTH:  8,
            OFFSET_ADDRESS: 8'h00,
            BUS_WIDTH:      32,
            DATA_WIDTH:     32,
            VALUE_WIDTH:    32,
            VALID_BITS:     32'h00000303
          )(
            i_clk:        i_clk,
            i_rst:        i_rst,
            register_if:  register_if[0],
            bit_field_if: bit_field_if
          );
          :g_bit_field_0 {
            const INITIAL_VALUE: bit<2> = 2'h0;
            inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
            always_comb {
              bit_field_sub_if.valid = bit_field_if.valid;
              bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:2];
              bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:2];
              bit_field_sub_if.write_data = bit_field_if.write_data[0+:2];
              bit_field_if.read_data[0+:2] = bit_field_sub_if.read_data;
              bit_field_if.value[0+:2] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen_bit_field #(
              WIDTH:          2,
              INITIAL_VALUE:  INITIAL_VALUE,
              SW_WRITE_ONCE:  0,
              TRIGGER:        0
            )(
              i_clk:              i_clk,
              i_rst:              i_rst,
              bit_field_if:       bit_field_sub_if,
              o_write_trigger:    _,
              o_read_trigger:     _,
              i_sw_write_enable:  '1,
              i_hw_write_enable:  '0,
              i_hw_write_data:    '0,
              i_hw_set:           '0,
              i_hw_clear:         '0,
              i_value:            '0,
              i_mask:             '1,
              o_value:            o_register_0_bit_field_0,
              o_value_unmasked:   _
            );
          }
          :g_bit_field_1 {
            const INITIAL_VALUE: bit<2> = 2'h0;
            inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
            always_comb {
              bit_field_sub_if.valid = bit_field_if.valid;
              bit_field_sub_if.read_mask = bit_field_if.read_mask[8+:2];
              bit_field_sub_if.write_mask = bit_field_if.write_mask[8+:2];
              bit_field_sub_if.write_data = bit_field_if.write_data[8+:2];
              bit_field_if.read_data[8+:2] = bit_field_sub_if.read_data;
              bit_field_if.value[8+:2] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen_bit_field #(
              WIDTH:          2,
              INITIAL_VALUE:  INITIAL_VALUE,
              SW_WRITE_ONCE:  0,
              TRIGGER:        0
            )(
              i_clk:              i_clk,
              i_rst:              i_rst,
              bit_field_if:       bit_field_sub_if,
              o_write_trigger:    _,
              o_read_trigger:     _,
              i_sw_write_enable:  '1,
              i_hw_write_enable:  '0,
              i_hw_write_data:    '0,
              i_hw_set:           '0,
              i_hw_clear:         '0,
              i_value:            '0,
              i_mask:             '1,
              o_value:            o_register_0_bit_field_1,
              o_value_unmasked:   _
            );
          }
        }
      VERYL

      expect(registers[1]).to generate_code(:register_file, :top_down, <<~'VERYL')
        :g_register_1 {
          inst u_register: rggen_external_register #(
            ADDRESS_WIDTH:  8,
            BUS_WIDTH:      32,
            VALUE_WIDTH:    32,
            STROBE_WIDTH:   REGISTER_1_STROBE_WIDTH,
            START_ADDRESS:  8'h10,
            BYTE_SIZE:      16
          )(
            i_clk:        i_clk,
            i_rst:        i_rst,
            register_if:  register_if[1],
            bus_if:       register_1_bus_if
          );
        }
      VERYL

      expect(registers[2]).to generate_code(:register_file, :top_down, <<~'VERYL')
        :g_register_2 {
          for i in 0..4 :g {
            inst bit_field_if: rggen_bit_field_if#(WIDTH: 32);
            inst u_register: rggen_default_register #(
              READABLE:       1,
              WRITABLE:       1,
              ADDRESS_WIDTH:  8,
              OFFSET_ADDRESS: 8'h20+(4*i as 8),
              BUS_WIDTH:      32,
              DATA_WIDTH:     32,
              VALUE_WIDTH:    32,
              VALID_BITS:     32'h00000303
            )(
              i_clk:        i_clk,
              i_rst:        i_rst,
              register_if:  register_if[2+i],
              bit_field_if: bit_field_if
            );
            :g_bit_field_0 {
              const INITIAL_VALUE: bit<2> = 2'h0;
              inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
              always_comb {
                bit_field_sub_if.valid = bit_field_if.valid;
                bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:2];
                bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:2];
                bit_field_sub_if.write_data = bit_field_if.write_data[0+:2];
                bit_field_if.read_data[0+:2] = bit_field_sub_if.read_data;
                bit_field_if.value[0+:2] = bit_field_sub_if.value;
              }
              inst u_bit_field: rggen_bit_field #(
                WIDTH:          2,
                INITIAL_VALUE:  INITIAL_VALUE,
                SW_WRITE_ONCE:  0,
                TRIGGER:        0
              )(
                i_clk:              i_clk,
                i_rst:              i_rst,
                bit_field_if:       bit_field_sub_if,
                o_write_trigger:    _,
                o_read_trigger:     _,
                i_sw_write_enable:  '1,
                i_hw_write_enable:  '0,
                i_hw_write_data:    '0,
                i_hw_set:           '0,
                i_hw_clear:         '0,
                i_value:            '0,
                i_mask:             '1,
                o_value:            o_register_2_bit_field_0[i],
                o_value_unmasked:   _
              );
            }
            :g_bit_field_1 {
              const INITIAL_VALUE: bit<2> = 2'h0;
              inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
              always_comb {
                bit_field_sub_if.valid = bit_field_if.valid;
                bit_field_sub_if.read_mask = bit_field_if.read_mask[8+:2];
                bit_field_sub_if.write_mask = bit_field_if.write_mask[8+:2];
                bit_field_sub_if.write_data = bit_field_if.write_data[8+:2];
                bit_field_if.read_data[8+:2] = bit_field_sub_if.read_data;
                bit_field_if.value[8+:2] = bit_field_sub_if.value;
              }
              inst u_bit_field: rggen_bit_field #(
                WIDTH:          2,
                INITIAL_VALUE:  INITIAL_VALUE,
                SW_WRITE_ONCE:  0,
                TRIGGER:        0
              )(
                i_clk:              i_clk,
                i_rst:              i_rst,
                bit_field_if:       bit_field_sub_if,
                o_write_trigger:    _,
                o_read_trigger:     _,
                i_sw_write_enable:  '1,
                i_hw_write_enable:  '0,
                i_hw_write_data:    '0,
                i_hw_set:           '0,
                i_hw_clear:         '0,
                i_value:            '0,
                i_mask:             '1,
                o_value:            o_register_2_bit_field_1[i],
                o_value_unmasked:   _
              );
            }
          }
        }
      VERYL

      expect(registers[3]).to generate_code(:register_file, :top_down, <<~'VERYL')
        :g_register_3 {
          for i in 0..2 :g {
            inst bit_field_if: rggen_bit_field_if#(WIDTH: 32);
            inst u_register: rggen_default_register #(
              READABLE:       1,
              WRITABLE:       1,
              ADDRESS_WIDTH:  8,
              OFFSET_ADDRESS: 8'h30+(8*i as 8),
              BUS_WIDTH:      32,
              DATA_WIDTH:     32,
              VALUE_WIDTH:    32,
              VALID_BITS:     32'h00000303
            )(
              i_clk:        i_clk,
              i_rst:        i_rst,
              register_if:  register_if[6+i],
              bit_field_if: bit_field_if
            );
            :g_bit_field_0 {
              const INITIAL_VALUE: bit<2> = 2'h0;
              inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
              always_comb {
                bit_field_sub_if.valid = bit_field_if.valid;
                bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:2];
                bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:2];
                bit_field_sub_if.write_data = bit_field_if.write_data[0+:2];
                bit_field_if.read_data[0+:2] = bit_field_sub_if.read_data;
                bit_field_if.value[0+:2] = bit_field_sub_if.value;
              }
              inst u_bit_field: rggen_bit_field #(
                WIDTH:          2,
                INITIAL_VALUE:  INITIAL_VALUE,
                SW_WRITE_ONCE:  0,
                TRIGGER:        0
              )(
                i_clk:              i_clk,
                i_rst:              i_rst,
                bit_field_if:       bit_field_sub_if,
                o_write_trigger:    _,
                o_read_trigger:     _,
                i_sw_write_enable:  '1,
                i_hw_write_enable:  '0,
                i_hw_write_data:    '0,
                i_hw_set:           '0,
                i_hw_clear:         '0,
                i_value:            '0,
                i_mask:             '1,
                o_value:            o_register_3_bit_field_0[i],
                o_value_unmasked:   _
              );
            }
            :g_bit_field_1 {
              const INITIAL_VALUE: bit<2> = 2'h0;
              inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
              always_comb {
                bit_field_sub_if.valid = bit_field_if.valid;
                bit_field_sub_if.read_mask = bit_field_if.read_mask[8+:2];
                bit_field_sub_if.write_mask = bit_field_if.write_mask[8+:2];
                bit_field_sub_if.write_data = bit_field_if.write_data[8+:2];
                bit_field_if.read_data[8+:2] = bit_field_sub_if.read_data;
                bit_field_if.value[8+:2] = bit_field_sub_if.value;
              }
              inst u_bit_field: rggen_bit_field #(
                WIDTH:          2,
                INITIAL_VALUE:  INITIAL_VALUE,
                SW_WRITE_ONCE:  0,
                TRIGGER:        0
              )(
                i_clk:              i_clk,
                i_rst:              i_rst,
                bit_field_if:       bit_field_sub_if,
                o_write_trigger:    _,
                o_read_trigger:     _,
                i_sw_write_enable:  '1,
                i_hw_write_enable:  '0,
                i_hw_write_data:    '0,
                i_hw_set:           '0,
                i_hw_clear:         '0,
                i_value:            '0,
                i_mask:             '1,
                o_value:            o_register_3_bit_field_1[i],
                o_value_unmasked:   _
              );
            }
          }
        }
      VERYL

      expect(registers[4]).to generate_code(:register_file, :top_down, <<~'VERYL')
        :g_register_4 {
          for i in 0..2 :g {
            for j in 0..2 :g {
              var indirect_match: logic<2>;
              inst bit_field_if: rggen_bit_field_if#(WIDTH: 32);
              assign indirect_match[0] = register_if[0].value[0+:2] == (i as 2);
              assign indirect_match[1] = register_if[0].value[8+:2] == (j as 2);
              inst u_register: rggen_indirect_register #(
                READABLE:             1,
                WRITABLE:             1,
                ADDRESS_WIDTH:        8,
                OFFSET_ADDRESS:       8'h40,
                BUS_WIDTH:            32,
                DATA_WIDTH:           32,
                VALUE_WIDTH:          32,
                VALID_BITS:           32'h00000303,
                INDIRECT_MATCH_WIDTH: 2
              )(
                i_clk:            i_clk,
                i_rst:            i_rst,
                register_if:      register_if[8+2*i+j],
                i_indirect_match: indirect_match,
                bit_field_if:     bit_field_if
              );
              :g_bit_field_0 {
                const INITIAL_VALUE: bit<2> = 2'h0;
                inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
                always_comb {
                  bit_field_sub_if.valid = bit_field_if.valid;
                  bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:2];
                  bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:2];
                  bit_field_sub_if.write_data = bit_field_if.write_data[0+:2];
                  bit_field_if.read_data[0+:2] = bit_field_sub_if.read_data;
                  bit_field_if.value[0+:2] = bit_field_sub_if.value;
                }
                inst u_bit_field: rggen_bit_field #(
                  WIDTH:          2,
                  INITIAL_VALUE:  INITIAL_VALUE,
                  SW_WRITE_ONCE:  0,
                  TRIGGER:        0
                )(
                  i_clk:              i_clk,
                  i_rst:              i_rst,
                  bit_field_if:       bit_field_sub_if,
                  o_write_trigger:    _,
                  o_read_trigger:     _,
                  i_sw_write_enable:  '1,
                  i_hw_write_enable:  '0,
                  i_hw_write_data:    '0,
                  i_hw_set:           '0,
                  i_hw_clear:         '0,
                  i_value:            '0,
                  i_mask:             '1,
                  o_value:            o_register_4_bit_field_0[i][j],
                  o_value_unmasked:   _
                );
              }
              :g_bit_field_1 {
                const INITIAL_VALUE: bit<2> = 2'h0;
                inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
                always_comb {
                  bit_field_sub_if.valid = bit_field_if.valid;
                  bit_field_sub_if.read_mask = bit_field_if.read_mask[8+:2];
                  bit_field_sub_if.write_mask = bit_field_if.write_mask[8+:2];
                  bit_field_sub_if.write_data = bit_field_if.write_data[8+:2];
                  bit_field_if.read_data[8+:2] = bit_field_sub_if.read_data;
                  bit_field_if.value[8+:2] = bit_field_sub_if.value;
                }
                inst u_bit_field: rggen_bit_field #(
                  WIDTH:          2,
                  INITIAL_VALUE:  INITIAL_VALUE,
                  SW_WRITE_ONCE:  0,
                  TRIGGER:        0
                )(
                  i_clk:              i_clk,
                  i_rst:              i_rst,
                  bit_field_if:       bit_field_sub_if,
                  o_write_trigger:    _,
                  o_read_trigger:     _,
                  i_sw_write_enable:  '1,
                  i_hw_write_enable:  '0,
                  i_hw_write_data:    '0,
                  i_hw_set:           '0,
                  i_hw_clear:         '0,
                  i_value:            '0,
                  i_mask:             '1,
                  o_value:            o_register_4_bit_field_1[i][j],
                  o_value_unmasked:   _
                );
              }
            }
          }
        }
      VERYL

      expect(registers[5]).to generate_code(:register_file, :top_down, <<~'VERYL')
        :g_register_5 {
          inst bit_field_if: rggen_bit_field_if#(WIDTH: 32);
          inst u_register: rggen_default_register #(
            READABLE:       1,
            WRITABLE:       1,
            ADDRESS_WIDTH:  8,
            OFFSET_ADDRESS: 8'h50,
            BUS_WIDTH:      32,
            DATA_WIDTH:     32,
            VALUE_WIDTH:    32,
            VALID_BITS:     32'h00000003
          )(
            i_clk:        i_clk,
            i_rst:        i_rst,
            register_if:  register_if[12],
            bit_field_if: bit_field_if
          );
          :g_register_5 {
            const INITIAL_VALUE: bit<2> = 2'h0;
            inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
            always_comb {
              bit_field_sub_if.valid = bit_field_if.valid;
              bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:2];
              bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:2];
              bit_field_sub_if.write_data = bit_field_if.write_data[0+:2];
              bit_field_if.read_data[0+:2] = bit_field_sub_if.read_data;
              bit_field_if.value[0+:2] = bit_field_sub_if.value;
            }
            inst u_bit_field: rggen_bit_field #(
              WIDTH:          2,
              INITIAL_VALUE:  INITIAL_VALUE,
              SW_WRITE_ONCE:  0,
              TRIGGER:        0
            )(
              i_clk:              i_clk,
              i_rst:              i_rst,
              bit_field_if:       bit_field_sub_if,
              o_write_trigger:    _,
              o_read_trigger:     _,
              i_sw_write_enable:  '1,
              i_hw_write_enable:  '0,
              i_hw_write_data:    '0,
              i_hw_set:           '0,
              i_hw_clear:         '0,
              i_value:            '0,
              i_mask:             '1,
              o_value:            o_register_5,
              o_value_unmasked:   _
            );
          }
        }
      VERYL

      expect(registers[6]).to generate_code(:register_file, :top_down, <<~'VERYL')
        :g_register_0 {
          for k in 0..2 :g {
            for l in 0..2 :g {
              inst bit_field_if: rggen_bit_field_if#(WIDTH: 32);
              inst u_register: rggen_default_register #(
                READABLE:       1,
                WRITABLE:       1,
                ADDRESS_WIDTH:  8,
                OFFSET_ADDRESS: 8'h60+(16*(2*i+j) as 8)+(4*(2*k+l) as 8),
                BUS_WIDTH:      32,
                DATA_WIDTH:     32,
                VALUE_WIDTH:    32,
                VALID_BITS:     32'h00000003
              )(
                i_clk:        i_clk,
                i_rst:        i_rst,
                register_if:  register_if[13+4*(2*i+j)+2*k+l],
                bit_field_if: bit_field_if
              );
              :g_bit_field_0 {
                const INITIAL_VALUE: bit<2> = 2'h0;
                inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
                always_comb {
                  bit_field_sub_if.valid = bit_field_if.valid;
                  bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:2];
                  bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:2];
                  bit_field_sub_if.write_data = bit_field_if.write_data[0+:2];
                  bit_field_if.read_data[0+:2] = bit_field_sub_if.read_data;
                  bit_field_if.value[0+:2] = bit_field_sub_if.value;
                }
                inst u_bit_field: rggen_bit_field #(
                  WIDTH:          2,
                  INITIAL_VALUE:  INITIAL_VALUE,
                  SW_WRITE_ONCE:  0,
                  TRIGGER:        0
                )(
                  i_clk:              i_clk,
                  i_rst:              i_rst,
                  bit_field_if:       bit_field_sub_if,
                  o_write_trigger:    _,
                  o_read_trigger:     _,
                  i_sw_write_enable:  '1,
                  i_hw_write_enable:  '0,
                  i_hw_write_data:    '0,
                  i_hw_set:           '0,
                  i_hw_clear:         '0,
                  i_value:            '0,
                  i_mask:             '1,
                  o_value:            o_register_file_6_register_file_0_register_0_bit_field_0[i][j][k][l],
                  o_value_unmasked:   _
                );
              }
            }
          }
        }
      VERYL

      expect(registers[7]).to generate_code(:register_file, :top_down, <<~'VERYL')
        :g_register_0 {
          for j in 0..2 :g {
            inst bit_field_if: rggen_bit_field_if#(WIDTH: 32);
            inst u_register: rggen_default_register #(
              READABLE:       1,
              WRITABLE:       1,
              ADDRESS_WIDTH:  8,
              OFFSET_ADDRESS: 8'ha0+(32*i as 8)+(8*j as 8),
              BUS_WIDTH:      32,
              DATA_WIDTH:     32,
              VALUE_WIDTH:    32,
              VALID_BITS:     32'h00000003
            )(
              i_clk:        i_clk,
              i_rst:        i_rst,
              register_if:  register_if[29+2*i+j],
              bit_field_if: bit_field_if
            );
            :g_bit_field_0 {
              const INITIAL_VALUE: bit<2> = 2'h0;
              inst bit_field_sub_if: rggen_bit_field_if#(WIDTH: 2);
              always_comb {
                bit_field_sub_if.valid = bit_field_if.valid;
                bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:2];
                bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:2];
                bit_field_sub_if.write_data = bit_field_if.write_data[0+:2];
                bit_field_if.read_data[0+:2] = bit_field_sub_if.read_data;
                bit_field_if.value[0+:2] = bit_field_sub_if.value;
              }
              inst u_bit_field: rggen_bit_field #(
                WIDTH:          2,
                INITIAL_VALUE:  INITIAL_VALUE,
                SW_WRITE_ONCE:  0,
                TRIGGER:        0
              )(
                i_clk:              i_clk,
                i_rst:              i_rst,
                bit_field_if:       bit_field_sub_if,
                o_write_trigger:    _,
                o_read_trigger:     _,
                i_sw_write_enable:  '1,
                i_hw_write_enable:  '0,
                i_hw_write_data:    '0,
                i_hw_set:           '0,
                i_hw_clear:         '0,
                i_value:            '0,
                i_mask:             '1,
                o_value:            o_register_file_7_register_file_0_register_0_bit_field_0[i][j],
                o_value_unmasked:   _
              );
            }
          }
        }
      VERYL
    end
  end
end
