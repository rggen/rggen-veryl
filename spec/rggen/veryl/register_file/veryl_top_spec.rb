# frozen_string_literal: true

RSpec.describe 'register_file/veryl_top' do
  include_context 'veryl common'
  include_context 'clean-up builder'

  before(:all) do
    RgGen.enable(:global, [:bus_width, :address_width, :enable_wide_register, :array_port_format])
    RgGen.enable(:register_block, [:name, :byte_size])
    RgGen.enable(:register_file, [:name, :offset_address, :size])
    RgGen.enable(:register, [:name, :offset_address, :size, :type])
    RgGen.enable(:register, :type, [:external, :indirect])
    RgGen.enable(:bit_field, [:name, :bit_assignment, :type, :initial_value, :reference])
    RgGen.enable(:bit_field, :type, :rw)
    RgGen.enable(:register_block, :veryl_top)
    RgGen.enable(:register_file, :veryl_top)
    RgGen.enable(:register, :veryl_top)
    RgGen.enable(:bit_field, :veryl_top)
  end

  def create_register_files(&body)
    create_veryl(&body).register_blocks[0].register_files(false)
  end

  describe '#generate_code' do
    it 'レジスタファイル階層のコードを出力する' do
      register_files = create_register_files do
        name 'block_0'
        byte_size 512

        register_file do
          name 'register_file_0'
          offset_address 0x00
          register do
            name 'register_0'
            offset_address 0x00
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
          end
          register do
            name 'register_1'
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
          end
        end

        register_file do
          name 'register_file_1'
          offset_address 0x10

          register_file do
            name 'register_file_0'
            offset_address 0x00
            register do
              name 'register_0'
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
            end
          end

          register do
            name 'register_1'
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
          end
        end

        register_file do
          name 'register_file_2'
          offset_address 0x20
          size [2, 2]

          register_file do
            name 'register_file_0'
            register do
              name 'register_0'
              size [2, 2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
            end
          end

          register do
            name 'register_1'
            size [2, 2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
          end
        end

        register_file do
          name 'register_file_3'
          offset_address 0xA0
          size [2, step: 64]

          register_file do
            name 'register_file_0'
            register do
              name 'register_0'
              size [2, step: 8]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
            end
          end

          register do
            name 'register_1'
            size [2, step: 8]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 1; type :rw; initial_value 0 }
          end
        end
      end

      expect(register_files[0]).to generate_code(:register_file, :top_down, 0, <<~'VERYL')
        :g_register_file_0 {
          :g_register_0 {
            inst bit_field_if: rggen::rggen_bit_field_if#(WIDTH: 32);
            inst u_register: rggen::rggen_default_register #(
              READABLE:       1,
              WRITABLE:       1,
              ADDRESS_WIDTH:  9,
              OFFSET_ADDRESS: 9'h000,
              BUS_WIDTH:      32,
              DATA_WIDTH:     32,
              VALUE_WIDTH:    32,
              VALID_BITS:     32'h00000001
            )(
              i_clk:        i_clk,
              i_rst:        i_rst,
              register_if:  register_if[0],
              bit_field_if: bit_field_if
            );
            :g_bit_field_0 {
              const INITIAL_VALUE: bit = 1'h0;
              inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
              always_comb {
                bit_field_sub_if.valid = bit_field_if.valid;
                bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:1];
                bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:1];
                bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
                bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
                bit_field_if.value[0+:1] = bit_field_sub_if.value;
              }
              inst u_bit_field: rggen::rggen_bit_field #(
                WIDTH:          1,
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
                o_value:            o_register_file_0_register_0_bit_field_0,
                o_value_unmasked:   _
              );
            }
          }
          :g_register_1 {
            inst bit_field_if: rggen::rggen_bit_field_if#(WIDTH: 32);
            inst u_register: rggen::rggen_default_register #(
              READABLE:       1,
              WRITABLE:       1,
              ADDRESS_WIDTH:  9,
              OFFSET_ADDRESS: 9'h004,
              BUS_WIDTH:      32,
              DATA_WIDTH:     32,
              VALUE_WIDTH:    32,
              VALID_BITS:     32'h00000001
            )(
              i_clk:        i_clk,
              i_rst:        i_rst,
              register_if:  register_if[1],
              bit_field_if: bit_field_if
            );
            :g_bit_field_0 {
              const INITIAL_VALUE: bit = 1'h0;
              inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
              always_comb {
                bit_field_sub_if.valid = bit_field_if.valid;
                bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:1];
                bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:1];
                bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
                bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
                bit_field_if.value[0+:1] = bit_field_sub_if.value;
              }
              inst u_bit_field: rggen::rggen_bit_field #(
                WIDTH:          1,
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
                o_value:            o_register_file_0_register_1_bit_field_0,
                o_value_unmasked:   _
              );
            }
          }
        }
      VERYL

      expect(register_files[1]).to generate_code(:register_file, :top_down, 0, <<~'VERYL')
        :g_register_file_1 {
          :g_register_file_0 {
            :g_register_0 {
              inst bit_field_if: rggen::rggen_bit_field_if#(WIDTH: 32);
              inst u_register: rggen::rggen_default_register #(
                READABLE:       1,
                WRITABLE:       1,
                ADDRESS_WIDTH:  9,
                OFFSET_ADDRESS: 9'h010,
                BUS_WIDTH:      32,
                DATA_WIDTH:     32,
                VALUE_WIDTH:    32,
                VALID_BITS:     32'h00000001
              )(
                i_clk:        i_clk,
                i_rst:        i_rst,
                register_if:  register_if[2],
                bit_field_if: bit_field_if
              );
              :g_bit_field_0 {
                const INITIAL_VALUE: bit = 1'h0;
                inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
                always_comb {
                  bit_field_sub_if.valid = bit_field_if.valid;
                  bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:1];
                  bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:1];
                  bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
                  bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
                  bit_field_if.value[0+:1] = bit_field_sub_if.value;
                }
                inst u_bit_field: rggen::rggen_bit_field #(
                  WIDTH:          1,
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
                  o_value:            o_register_file_1_register_file_0_register_0_bit_field_0,
                  o_value_unmasked:   _
                );
              }
            }
          }
          :g_register_1 {
            inst bit_field_if: rggen::rggen_bit_field_if#(WIDTH: 32);
            inst u_register: rggen::rggen_default_register #(
              READABLE:       1,
              WRITABLE:       1,
              ADDRESS_WIDTH:  9,
              OFFSET_ADDRESS: 9'h014,
              BUS_WIDTH:      32,
              DATA_WIDTH:     32,
              VALUE_WIDTH:    32,
              VALID_BITS:     32'h00000001
            )(
              i_clk:        i_clk,
              i_rst:        i_rst,
              register_if:  register_if[3],
              bit_field_if: bit_field_if
            );
            :g_bit_field_0 {
              const INITIAL_VALUE: bit = 1'h0;
              inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
              always_comb {
                bit_field_sub_if.valid = bit_field_if.valid;
                bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:1];
                bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:1];
                bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
                bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
                bit_field_if.value[0+:1] = bit_field_sub_if.value;
              }
              inst u_bit_field: rggen::rggen_bit_field #(
                WIDTH:          1,
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
                o_value:            o_register_file_1_register_1_bit_field_0,
                o_value_unmasked:   _
              );
            }
          }
        }
      VERYL

      expect(register_files[2]).to generate_code(:register_file, :top_down, 0, <<~'VERYL')
        :g_register_file_2 {
          for i in 0..2 :g {
            for j in 0..2 :g {
              :g_register_file_0 {
                :g_register_0 {
                  for k in 0..2 :g {
                    for l in 0..2 :g {
                      inst bit_field_if: rggen::rggen_bit_field_if#(WIDTH: 32);
                      inst u_register: rggen::rggen_default_register #(
                        READABLE:       1,
                        WRITABLE:       1,
                        ADDRESS_WIDTH:  9,
                        OFFSET_ADDRESS: 9'h020+(32*(2*i+j) as 9)+(4*(2*k+l) as 9),
                        BUS_WIDTH:      32,
                        DATA_WIDTH:     32,
                        VALUE_WIDTH:    32,
                        VALID_BITS:     32'h00000001
                      )(
                        i_clk:        i_clk,
                        i_rst:        i_rst,
                        register_if:  register_if[4+8*(2*i+j)+2*k+l],
                        bit_field_if: bit_field_if
                      );
                      :g_bit_field_0 {
                        const INITIAL_VALUE: bit = 1'h0;
                        inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
                        always_comb {
                          bit_field_sub_if.valid = bit_field_if.valid;
                          bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:1];
                          bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:1];
                          bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
                          bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
                          bit_field_if.value[0+:1] = bit_field_sub_if.value;
                        }
                        inst u_bit_field: rggen::rggen_bit_field #(
                          WIDTH:          1,
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
                          o_value:            o_register_file_2_register_file_0_register_0_bit_field_0[i][j][k][l],
                          o_value_unmasked:   _
                        );
                      }
                    }
                  }
                }
              }
              :g_register_1 {
                for k in 0..2 :g {
                  for l in 0..2 :g {
                    inst bit_field_if: rggen::rggen_bit_field_if#(WIDTH: 32);
                    inst u_register: rggen::rggen_default_register #(
                      READABLE:       1,
                      WRITABLE:       1,
                      ADDRESS_WIDTH:  9,
                      OFFSET_ADDRESS: 9'h020+(32*(2*i+j) as 9)+9'h010+(4*(2*k+l) as 9),
                      BUS_WIDTH:      32,
                      DATA_WIDTH:     32,
                      VALUE_WIDTH:    32,
                      VALID_BITS:     32'h00000001
                    )(
                      i_clk:        i_clk,
                      i_rst:        i_rst,
                      register_if:  register_if[4+8*(2*i+j)+4+2*k+l],
                      bit_field_if: bit_field_if
                    );
                    :g_bit_field_0 {
                      const INITIAL_VALUE: bit = 1'h0;
                      inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
                      always_comb {
                        bit_field_sub_if.valid = bit_field_if.valid;
                        bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:1];
                        bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:1];
                        bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
                        bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
                        bit_field_if.value[0+:1] = bit_field_sub_if.value;
                      }
                      inst u_bit_field: rggen::rggen_bit_field #(
                        WIDTH:          1,
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
                        o_value:            o_register_file_2_register_1_bit_field_0[i][j][k][l],
                        o_value_unmasked:   _
                      );
                    }
                  }
                }
              }
            }
          }
        }
      VERYL

      expect(register_files[3]).to generate_code(:register_file, :top_down, 0, <<~'VERYL')
        :g_register_file_3 {
          for i in 0..2 :g {
            :g_register_file_0 {
              :g_register_0 {
                for j in 0..2 :g {
                  inst bit_field_if: rggen::rggen_bit_field_if#(WIDTH: 32);
                  inst u_register: rggen::rggen_default_register #(
                    READABLE:       1,
                    WRITABLE:       1,
                    ADDRESS_WIDTH:  9,
                    OFFSET_ADDRESS: 9'h0a0+(64*i as 9)+(8*j as 9),
                    BUS_WIDTH:      32,
                    DATA_WIDTH:     32,
                    VALUE_WIDTH:    32,
                    VALID_BITS:     32'h00000001
                  )(
                    i_clk:        i_clk,
                    i_rst:        i_rst,
                    register_if:  register_if[36+4*i+j],
                    bit_field_if: bit_field_if
                  );
                  :g_bit_field_0 {
                    const INITIAL_VALUE: bit = 1'h0;
                    inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
                    always_comb {
                      bit_field_sub_if.valid = bit_field_if.valid;
                      bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:1];
                      bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:1];
                      bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
                      bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
                      bit_field_if.value[0+:1] = bit_field_sub_if.value;
                    }
                    inst u_bit_field: rggen::rggen_bit_field #(
                      WIDTH:          1,
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
                      o_value:            o_register_file_3_register_file_0_register_0_bit_field_0[i][j],
                      o_value_unmasked:   _
                    );
                  }
                }
              }
            }
            :g_register_1 {
              for j in 0..2 :g {
                inst bit_field_if: rggen::rggen_bit_field_if#(WIDTH: 32);
                inst u_register: rggen::rggen_default_register #(
                  READABLE:       1,
                  WRITABLE:       1,
                  ADDRESS_WIDTH:  9,
                  OFFSET_ADDRESS: 9'h0a0+(64*i as 9)+9'h010+(8*j as 9),
                  BUS_WIDTH:      32,
                  DATA_WIDTH:     32,
                  VALUE_WIDTH:    32,
                  VALID_BITS:     32'h00000001
                )(
                  i_clk:        i_clk,
                  i_rst:        i_rst,
                  register_if:  register_if[36+4*i+2+j],
                  bit_field_if: bit_field_if
                );
                :g_bit_field_0 {
                  const INITIAL_VALUE: bit = 1'h0;
                  inst bit_field_sub_if: rggen::rggen_bit_field_if#(WIDTH: 1);
                  always_comb {
                    bit_field_sub_if.valid = bit_field_if.valid;
                    bit_field_sub_if.read_mask = bit_field_if.read_mask[0+:1];
                    bit_field_sub_if.write_mask = bit_field_if.write_mask[0+:1];
                    bit_field_sub_if.write_data = bit_field_if.write_data[0+:1];
                    bit_field_if.read_data[0+:1] = bit_field_sub_if.read_data;
                    bit_field_if.value[0+:1] = bit_field_sub_if.value;
                  }
                  inst u_bit_field: rggen::rggen_bit_field #(
                    WIDTH:          1,
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
                    o_value:            o_register_file_3_register_1_bit_field_0[i][j],
                    o_value_unmasked:   _
                  );
                }
              }
            }
          }
        }
      VERYL
    end
  end
end
