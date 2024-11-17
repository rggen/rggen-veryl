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
          name: "REGISTER_1_BIT_FIELD_0_INITIAL_VALUE", type: :bit, width: 1, default: "1'h0"
        )
        expect(bit_fields[4]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_1_BIT_FIELD_1_INITIAL_VALUE", type: :bit, width: 8, default: "8'h01"
        )
        expect(bit_fields[5]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_1_BIT_FIELD_2_INITIAL_VALUE", type: :bit, width: 8,
          array_size: [2], default: "{8'h02 repeat 2}"
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
          name: "REGISTER_FILE_3_REGISTER_0_BIT_FIELD_0_INITIAL_VALUE", type: :bit, width: 1, default: "1'h0"
        )
        expect(bit_fields[10]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_FILE_3_REGISTER_0_BIT_FIELD_1_INITIAL_VALUE", type: :bit, width: 8, default: "8'h01"
        )
        expect(bit_fields[11]).to have_param(
          :register_block, :initial_value,
          name: "REGISTER_FILE_3_REGISTER_0_BIT_FIELD_2_INITIAL_VALUE", type: :bit, width: 8,
          array_size: [2], default: "{8'h02 repeat 2}"
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
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 8, sequence_size: 1; type :rw; initial_value [0] }
            bit_field { name 'bit_field_1'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value [1, 2] }
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
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0, width: 8, sequence_size: 1; type :rw; initial_value [0] }
              bit_field { name 'bit_field_1'; bit_assignment lsb: 16, width: 8, sequence_size: 2; type :rw; initial_value [1, 2] }
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
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [1], default: "{8'h00}"
        )
        expect(bit_fields[3]).to have_const(
          :initial_value,
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [2], default: "{8'h02, 8'h01}"
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
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [1], default: "{8'h00}"
        )
        expect(bit_fields[7]).to have_const(
          :initial_value,
          name: "INITIAL_VALUE", type: :bit, width: 8, array_size: [2], default: "{8'h02, 8'h01}"
        )
      end
    end
  end

  describe '#bit_field_sub_if' do
    it 'rggen_bit_field_ifのインスタンスを持つ' do
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
        name: 'bit_field_sub_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 1 }
      )
      expect(bit_fields[1]).to have_interface(
        :bit_field_sub_if,
        name: 'bit_field_sub_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 8 }
      )
      expect(bit_fields[2]).to have_interface(
        :bit_field_sub_if,
        name: 'bit_field_sub_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 8 }
      )
      expect(bit_fields[3]).to have_interface(
        :bit_field_sub_if,
        name: 'bit_field_sub_if', interface_type: 'rggen_bit_field_if', param_values: { WIDTH: 64 }
      )
    end
  end
end
