# frozen_string_literal: true

RSpec.describe 'bit_field_type' do
  include_context 'clean-up builder'
  include_context 'veryl common'

  context 'コード生成が実装されていないビットフィールドが指定された場合' do
    before(:all) do
      RgGen.enable(:bit_field, :type)
      RgGen.define_list_item_feature(:bit_field, :type, :foo) do
        register_map {}
        veryl {}
      end
      RgGen.define_list_item_feature(:bit_field, :type, :bar) do
        register_map {}
      end
      RgGen.enable(:bit_field, :type, [:foo, :bar])
    end

    after(:all) do
      delete_register_map_factory
      delete_veryl_factory
      RgGen.delete(:bit_field, :type, [:foo, :bar])
    end

    it 'GeneratorErrorを起こす' do
      expect {
        create_veryl do
          register_block do
            register { bit_field { type :foo } }
          end
        end
      }.not_to raise_error

      expect {
        create_veryl do
          register_block do
            register { bit_field { type :bar } }
          end
        end
      }.to raise_error RgGen::Core::GeneratorError, 'code generator for bar bit field type is not implemented'
    end
  end
end
