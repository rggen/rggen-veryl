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
end
