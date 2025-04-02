# frozen_string_literal: true

RSpec.describe 'bit_field/type/rowotrg' do
  include_context 'clean-up builder'
  include_context 'bit field common'

  before(:all) do
    RgGen.enable(:bit_field, :type, [:rowotrg, :rw])
  end

  it '出力ポート#value_out/#write_trigger/#read_triggerを持つ' do
    bit_fields = create_bit_fields do
      byte_size 256

      register do
        name 'register_0'
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0 }
        bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0 }
        bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0 }
      end

      register do
        name 'register_1'
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 64; type :rowotrg; initial_value 0 }
      end

      register do
        name 'register_2'
        size [4]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0 }
        bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0 }
        bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0 }
      end

      register do
        name 'register_3'
        size [2, 2]
        bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0 }
        bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0 }
        bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0 }
      end

      register_file do
        name 'register_file_4'
        size [2, 2]
        register_file do
          name 'register_file_0'
          register do
            name 'register_0'
            size [2, 2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0 }
            bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0 }
            bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0 }
          end
        end
      end
    end

    expect(bit_fields[0]).to have_port(
      :register_block, :value_out,
      name: 'o_register_0_bit_field_0', direction: :output, type: :logic, width: 1
    )
    expect(bit_fields[0]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_0_bit_field_0_write_trigger', direction: :output, type: :logic, width: 1
    )
    expect(bit_fields[0]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_0_bit_field_0_read_trigger', direction: :output, type: :logic, width: 1
    )

    expect(bit_fields[1]).to have_port(
      :register_block, :value_out,
      name: 'o_register_0_bit_field_1', direction: :output, type: :logic, width: 2
    )
    expect(bit_fields[1]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_0_bit_field_1_write_trigger', direction: :output, type: :logic, width: 1
    )
    expect(bit_fields[1]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_0_bit_field_1_read_trigger', direction: :output, type: :logic, width: 1
    )

    expect(bit_fields[2]).to have_port(
      :register_block, :value_out,
      name: 'o_register_0_bit_field_2',
      direction: :output, type: :logic, width: 4, array_size: [2]
    )
    expect(bit_fields[2]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_0_bit_field_2_write_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2]
    )
    expect(bit_fields[2]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_0_bit_field_2_read_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2]
    )

    expect(bit_fields[3]).to have_port(
      :register_block, :value_out,
      name: 'o_register_1_bit_field_0', direction: :output, type: :logic, width: 64
    )
    expect(bit_fields[3]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_1_bit_field_0_write_trigger', direction: :output, type: :logic, width: 1
    )
    expect(bit_fields[3]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_1_bit_field_0_read_trigger', direction: :output, type: :logic, width: 1
    )

    expect(bit_fields[4]).to have_port(
      :register_block, :value_out,
      name: 'o_register_2_bit_field_0',
      direction: :output, type: :logic, width: 1, array_size: [4]
    )
    expect(bit_fields[4]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_2_bit_field_0_write_trigger',
      direction: :output, type: :logic, width: 1, array_size: [4]
    )
    expect(bit_fields[4]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_2_bit_field_0_read_trigger',
      direction: :output, type: :logic, width: 1, array_size: [4]
    )

    expect(bit_fields[5]).to have_port(
      :register_block, :value_out,
      name: 'o_register_2_bit_field_1',
      direction: :output, type: :logic, width: 2, array_size: [4]
    )
    expect(bit_fields[5]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_2_bit_field_1_write_trigger',
      direction: :output, type: :logic, width: 1, array_size: [4]
    )
    expect(bit_fields[5]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_2_bit_field_1_read_trigger',
      direction: :output, type: :logic, width: 1, array_size: [4]
    )

    expect(bit_fields[6]).to have_port(
      :register_block, :value_out,
      name: 'o_register_2_bit_field_2',
      direction: :output, type: :logic, width: 4, array_size: [4, 2]
    )
    expect(bit_fields[6]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_2_bit_field_2_write_trigger',
      direction: :output, type: :logic, width: 1, array_size: [4, 2]
    )
    expect(bit_fields[6]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_2_bit_field_2_read_trigger',
      direction: :output, type: :logic, width: 1, array_size: [4, 2]
    )

    expect(bit_fields[7]).to have_port(
      :register_block, :value_out,
      name: 'o_register_3_bit_field_0',
      direction: :output, type: :logic, width: 1, array_size: [2, 2]
    )
    expect(bit_fields[7]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_3_bit_field_0_write_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2]
    )
    expect(bit_fields[7]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_3_bit_field_0_read_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2]
    )

    expect(bit_fields[8]).to have_port(
      :register_block, :value_out,
      name: 'o_register_3_bit_field_1',
      direction: :output, type: :logic, width: 2, array_size: [2, 2]
    )
    expect(bit_fields[8]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_3_bit_field_1_write_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2]
    )
    expect(bit_fields[8]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_3_bit_field_1_read_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2]
    )

    expect(bit_fields[9]).to have_port(
      :register_block, :value_out,
      name: 'o_register_3_bit_field_2',
      direction: :output, type: :logic, width: 4, array_size: [2, 2, 2]
    )
    expect(bit_fields[9]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_3_bit_field_2_write_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2]
    )
    expect(bit_fields[9]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_3_bit_field_2_read_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2]
    )

    expect(bit_fields[10]).to have_port(
      :register_block, :value_out,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_0',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2, 2]
    )
    expect(bit_fields[10]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_0_write_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2, 2]
    )
    expect(bit_fields[10]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_0_read_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2, 2]
    )

    expect(bit_fields[11]).to have_port(
      :register_block, :value_out,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_1',
      direction: :output, type: :logic, width: 2, array_size: [2, 2, 2, 2]
    )
    expect(bit_fields[11]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_1_write_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2, 2]
    )
    expect(bit_fields[11]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_1_read_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2, 2]
    )

    expect(bit_fields[12]).to have_port(
      :register_block, :value_out,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_2',
      direction: :output, type: :logic, width: 4, array_size: [2, 2, 2, 2, 2]
    )
    expect(bit_fields[12]).to have_port(
      :register_block, :write_trigger,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_2_write_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2, 2, 2]
    )
    expect(bit_fields[12]).to have_port(
      :register_block, :read_trigger,
      name: 'o_register_file_4_register_file_0_register_0_bit_field_2_read_trigger',
      direction: :output, type: :logic, width: 1, array_size: [2, 2, 2, 2, 2]
    )
  end

  context '参照ビットフィールドを持たない場合' do
    it '入力ポート#value_inを持つ' do
      bit_fields = create_bit_fields do
        byte_size 256

        register do
          name 'register_0'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0 }
        end

        register do
          name 'register_1'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 64; type :rowotrg; initial_value 0 }
        end

        register do
          name 'register_2'
          size [4]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0 }
        end

        register do
          name 'register_3'
          size [2, 2]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0 }
        end

        register_file do
          name 'register_file_4'
          size [2, 2]
          register_file do
            name 'register_file_0'
            register do
              name 'register_0'
              size [2, 2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0 }
              bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0 }
              bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0 }
            end
          end
        end
      end

      expect(bit_fields[0]).to have_port(
        :register_block, :value_in,
        name: 'i_register_0_bit_field_0', direction: :input, type: :logic, width: 1
      )
      expect(bit_fields[1]).to have_port(
        :register_block, :value_in,
        name: 'i_register_0_bit_field_1', direction: :input, type: :logic, width: 2
      )
      expect(bit_fields[2]).to have_port(
        :register_block, :value_in,
        name: 'i_register_0_bit_field_2',
        direction: :input, type: :logic, width: 4, array_size: [2]
      )

      expect(bit_fields[3]).to have_port(
        :register_block, :value_in,
        name: 'i_register_1_bit_field_0', direction: :input, type: :logic, width: 64
      )

      expect(bit_fields[4]).to have_port(
        :register_block, :value_in,
        name: 'i_register_2_bit_field_0',
        direction: :input, type: :logic, width: 1, array_size: [4]
      )
      expect(bit_fields[5]).to have_port(
        :register_block, :value_in,
        name: 'i_register_2_bit_field_1',
        direction: :input, type: :logic, width: 2, array_size: [4]
      )
      expect(bit_fields[6]).to have_port(
        :register_block, :value_in,
        name: 'i_register_2_bit_field_2',
        direction: :input, type: :logic, width: 4, array_size: [4, 2]
      )

      expect(bit_fields[7]).to have_port(
        :register_block, :value_in,
        name: 'i_register_3_bit_field_0',
        direction: :input, type: :logic, width: 1, array_size: [2, 2]
      )
      expect(bit_fields[8]).to have_port(
        :register_block, :value_in,
        name: 'i_register_3_bit_field_1',
        direction: :input, type: :logic, width: 2, array_size: [2, 2]
      )
      expect(bit_fields[9]).to have_port(
        :register_block, :value_in,
        name: 'i_register_3_bit_field_2',
        direction: :input, type: :logic, width: 4, array_size: [2, 2, 2]
      )

      expect(bit_fields[10]).to have_port(
        :register_block, :value_in,
        name: 'i_register_file_4_register_file_0_register_0_bit_field_0',
        direction: :input, type: :logic, width: 1, array_size: [2, 2, 2, 2]
      )
      expect(bit_fields[11]).to have_port(
        :register_block, :value_in,
        name: 'i_register_file_4_register_file_0_register_0_bit_field_1',
        direction: :input, type: :logic, width: 2, array_size: [2, 2, 2, 2]
      )
      expect(bit_fields[12]).to have_port(
        :register_block, :value_in,
        name: 'i_register_file_4_register_file_0_register_0_bit_field_2',
        direction: :input, type: :logic, width: 4, array_size: [2, 2, 2, 2, 2]
      )
    end
  end

  context '参照ビットフィールドを持つ場合' do
    it '入力ポート#value_inを持たない' do
      bit_fields = create_bit_fields do
        byte_size 256

        register do
          name 'register_0'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0; reference 'register_5.bit_field_0' }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0; reference 'register_5.bit_field_1' }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0; reference 'register_5.bit_field_2' }
        end

        register do
          name 'register_1'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 64; type :rowotrg; initial_value 0; reference 'register_5.bit_field_3' }
        end

        register do
          name 'register_2'
          size [4]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0; reference 'register_5.bit_field_0' }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0; reference 'register_5.bit_field_1' }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0; reference 'register_5.bit_field_2' }
        end

        register do
          name 'register_3'
          size [2, 2]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0; reference 'register_5.bit_field_0' }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0; reference 'register_5.bit_field_1' }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0; reference 'register_5.bit_field_2' }
        end

        register_file do
          name 'register_file_4'
          size [2, 2]
          register_file do
            name 'register_file_0'
            register do
              name 'register_0'
              size [2, 2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0; reference 'register_5.bit_field_0' }
              bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rowotrg; initial_value 0; reference 'register_5.bit_field_1' }
              bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4, sequence_size: 2, step: 8; type :rowotrg; initial_value 0; reference 'register_5.bit_field_2' }
            end
          end
        end

        register do
          name 'register_5'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 2; type :rw; initial_value 0 }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 16, width: 4; type :rw; initial_value 0 }
          bit_field { name 'bit_field_3'; bit_assignment lsb: 32, width: 64; type :rw; initial_value 0 }
        end
      end

      expect(bit_fields[0]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_0_bit_field_0', direction: :input, type: :logic, width: 1
      )
      expect(bit_fields[1]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_0_bit_field_1', direction: :input, type: :logic, width: 2
      )
      expect(bit_fields[2]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_0_bit_field_2',
        direction: :input, type: :logic, width: 4, array_size: [2]
      )

      expect(bit_fields[3]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_1_bit_field_0', direction: :input, type: :logic, width: 64
      )

      expect(bit_fields[4]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_2_bit_field_0',
        direction: :input, type: :logic, width: 1, array_size: [4]
      )
      expect(bit_fields[5]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_2_bit_field_1',
        direction: :input, type: :logic, width: 2, array_size: [4]
      )
      expect(bit_fields[6]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_2_bit_field_2',
        direction: :input, type: :logic, width: 4, array_size: [4, 2]
      )

      expect(bit_fields[7]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_3_bit_field_0',
        direction: :input, type: :logic, width: 1, array_size: [2, 2]
      )
      expect(bit_fields[8]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_3_bit_field_1',
        direction: :input, type: :logic, width: 2, array_size: [2, 2]
      )
      expect(bit_fields[9]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_3_bit_field_2',
        direction: :input, type: :logic, width: 4, array_size: [2, 2, 2]
      )

      expect(bit_fields[8]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_4_register_file_0_register_0_bit_field_0',
        direction: :input, type: :logic, width: 1, array_size: [2, 2, 2, 2]
      )
      expect(bit_fields[9]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_4_register_file_0_register_0_bit_field_1',
        direction: :input, type: :logic, width: 2, array_size: [2, 2, 2, 2]
      )
      expect(bit_fields[10]).to not_have_port(
        :register_block, :value_in,
        name: 'i_register_4_register_file_0_register_0_bit_field_2',
        direction: :input, type: :logic, width: 4, array_size: [2, 2, 2, 2, 2]
      )
    end
  end

  describe '#generate_code' do
    it 'rggen::rggen_bit_fieldをインスタンスするコードを生成する' do
      bit_fields = create_bit_fields do
        byte_size 256

        register do
          name 'register_0'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 1; type :rowotrg; initial_value 0; reference 'register_1.bit_field_0' }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 8, width: 8; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_3'; bit_assignment lsb: 16, width: 8; type :rowotrg; initial_value 0; reference 'register_1.bit_field_1' }
        end

        register do
          name 'register_1'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 1; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 16, width: 8; type :rw; initial_value 0 }
        end

        register do
          name 'register_2'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 64; type :rowotrg; initial_value 0 }
        end

        register do
          name 'register_3'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 4, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0; reference 'register_4.bit_field_0' }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 8, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0; reference 'register_4.bit_field_1' }
        end

        register do
          name 'register_4'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 4, width: 4; type :rw; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 8, width: 4, sequence_size: 2; type :rw; initial_value 0 }
        end

        register do
          name 'register_5'
          size [4]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 4, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0; reference 'register_6.bit_field_0' }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 8, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0; reference 'register_7.bit_field_0' }
        end

        register do
          name 'register_6'
          size [4]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 4, width: 4, sequence_size: 2; type :rw; initial_value 0 }
        end

        register do
          name 'register_7'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 4, width: 4; type :rw; initial_value 0 }
        end

        register do
          name 'register_8'
          size [2, 2]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0 }
          bit_field { name 'bit_field_1'; bit_assignment lsb: 4, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0; reference 'register_9.bit_field_0' }
          bit_field { name 'bit_field_2'; bit_assignment lsb: 8, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0; reference 'register_10.bit_field_0' }
        end

        register do
          name 'register_9'
          size [2, 2]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 4, width: 4, sequence_size: 2; type :rw; initial_value 0 }
        end

        register do
          name 'register_10'
          bit_field { name 'bit_field_0'; bit_assignment lsb: 4, width: 4; type :rw; initial_value 0 }
        end

        register_file do
          name 'register_file_11'
          size [2, 2]
          register_file do
            name 'register_file_0'
            register do
              name 'register_0'
              size [2, 2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0 }
              bit_field { name 'bit_field_1'; bit_assignment lsb: 4, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0; reference 'register_file_12.register_file_0.register_0.bit_field_0' }
              bit_field { name 'bit_field_2'; bit_assignment lsb: 8, width: 4, sequence_size: 2, step: 16; type :rowotrg; initial_value 0; reference 'register_file_12.register_file_0.register_1.bit_field_0' }
            end
          end
        end

        register_file do
          name 'register_file_12'
          size [2, 2]
          register_file do
            name 'register_file_0'

            register do
              name 'register_0'
              size [2, 2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 4, width: 4, sequence_size: 2; type :rw; initial_value 0 }
            end

            register do
              name 'register_1'
              bit_field { name 'bit_field_0'; bit_assignment lsb: 4, width: 4; type :rw; initial_value 0 }
            end
          end
        end
      end

      expect(bit_fields[0]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              1,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_0_bit_field_0_write_trigger,
          o_read_trigger:   o_register_0_bit_field_0_read_trigger,
          i_value:          i_register_0_bit_field_0,
          o_value:          o_register_0_bit_field_0
        );
      VERYL

      expect(bit_fields[1]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              1,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_0_bit_field_1_write_trigger,
          o_read_trigger:   o_register_0_bit_field_1_read_trigger,
          i_value:          register_if[1].value[1+:1],
          o_value:          o_register_0_bit_field_1
        );
      VERYL

      expect(bit_fields[2]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              8,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_0_bit_field_2_write_trigger,
          o_read_trigger:   o_register_0_bit_field_2_read_trigger,
          i_value:          i_register_0_bit_field_2,
          o_value:          o_register_0_bit_field_2
        );
      VERYL

      expect(bit_fields[3]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              8,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_0_bit_field_3_write_trigger,
          o_read_trigger:   o_register_0_bit_field_3_read_trigger,
          i_value:          register_if[1].value[16+:8],
          o_value:          o_register_0_bit_field_3
        );
      VERYL

      expect(bit_fields[6]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              64,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_2_bit_field_0_write_trigger,
          o_read_trigger:   o_register_2_bit_field_0_read_trigger,
          i_value:          i_register_2_bit_field_0,
          o_value:          o_register_2_bit_field_0
        );
      VERYL

      expect(bit_fields[7]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_3_bit_field_0_write_trigger[i],
          o_read_trigger:   o_register_3_bit_field_0_read_trigger[i],
          i_value:          i_register_3_bit_field_0[i],
          o_value:          o_register_3_bit_field_0[i]
        );
      VERYL

      expect(bit_fields[8]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_3_bit_field_1_write_trigger[i],
          o_read_trigger:   o_register_3_bit_field_1_read_trigger[i],
          i_value:          register_if[4].value[4+:4],
          o_value:          o_register_3_bit_field_1[i]
        );
      VERYL

      expect(bit_fields[9]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_3_bit_field_2_write_trigger[i],
          o_read_trigger:   o_register_3_bit_field_2_read_trigger[i],
          i_value:          register_if[4].value[8+4*i+:4],
          o_value:          o_register_3_bit_field_2[i]
        );
      VERYL

      expect(bit_fields[12]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_5_bit_field_0_write_trigger[i][j],
          o_read_trigger:   o_register_5_bit_field_0_read_trigger[i][j],
          i_value:          i_register_5_bit_field_0[i][j],
          o_value:          o_register_5_bit_field_0[i][j]
        );
      VERYL

      expect(bit_fields[13]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_5_bit_field_1_write_trigger[i][j],
          o_read_trigger:   o_register_5_bit_field_1_read_trigger[i][j],
          i_value:          register_if[9+i].value[4+4*j+:4],
          o_value:          o_register_5_bit_field_1[i][j]
        );
      VERYL

      expect(bit_fields[14]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_5_bit_field_2_write_trigger[i][j],
          o_read_trigger:   o_register_5_bit_field_2_read_trigger[i][j],
          i_value:          register_if[13].value[4+:4],
          o_value:          o_register_5_bit_field_2[i][j]
        );
      VERYL

      expect(bit_fields[17]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_8_bit_field_0_write_trigger[i][j][k],
          o_read_trigger:   o_register_8_bit_field_0_read_trigger[i][j][k],
          i_value:          i_register_8_bit_field_0[i][j][k],
          o_value:          o_register_8_bit_field_0[i][j][k]
        );
      VERYL

      expect(bit_fields[18]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_8_bit_field_1_write_trigger[i][j][k],
          o_read_trigger:   o_register_8_bit_field_1_read_trigger[i][j][k],
          i_value:          register_if[18+2*i+j].value[4+4*k+:4],
          o_value:          o_register_8_bit_field_1[i][j][k]
        );
      VERYL

      expect(bit_fields[19]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_8_bit_field_2_write_trigger[i][j][k],
          o_read_trigger:   o_register_8_bit_field_2_read_trigger[i][j][k],
          i_value:          register_if[22].value[4+:4],
          o_value:          o_register_8_bit_field_2[i][j][k]
        );
      VERYL

      expect(bit_fields[22]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_file_11_register_file_0_register_0_bit_field_0_write_trigger[i][j][k][l][m],
          o_read_trigger:   o_register_file_11_register_file_0_register_0_bit_field_0_read_trigger[i][j][k][l][m],
          i_value:          i_register_file_11_register_file_0_register_0_bit_field_0[i][j][k][l][m],
          o_value:          o_register_file_11_register_file_0_register_0_bit_field_0[i][j][k][l][m]
        );
      VERYL

      expect(bit_fields[23]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_file_11_register_file_0_register_0_bit_field_1_write_trigger[i][j][k][l][m],
          o_read_trigger:   o_register_file_11_register_file_0_register_0_bit_field_1_read_trigger[i][j][k][l][m],
          i_value:          register_if[39+5*(2*i+j)+2*k+l].value[4+4*m+:4],
          o_value:          o_register_file_11_register_file_0_register_0_bit_field_1[i][j][k][l][m]
        );
      VERYL

      expect(bit_fields[24]).to generate_code(:bit_field, :top_down, <<~'VERYL')
        inst u_bit_field: rggen::rggen_bit_field #(
          WIDTH:              4,
          INITIAL_VALUE:      INITIAL_VALUE,
          EXTERNAL_READ_DATA: true,
          TRIGGER:            true
        )(
          i_clk:            i_clk,
          i_rst:            i_rst,
          bit_field_if:     bit_field_sub_if,
          o_write_trigger:  o_register_file_11_register_file_0_register_0_bit_field_2_write_trigger[i][j][k][l][m],
          o_read_trigger:   o_register_file_11_register_file_0_register_0_bit_field_2_read_trigger[i][j][k][l][m],
          i_value:          register_if[39+5*(2*i+j)+4].value[4+:4],
          o_value:          o_register_file_11_register_file_0_register_0_bit_field_2[i][j][k][l][m]
        );
      VERYL
    end
  end
end
