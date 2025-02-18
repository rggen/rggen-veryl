# frozen_string_literal: true

RgGen.define_list_feature(:bit_field, :type) do
  veryl do
    base_feature do
      pre_code :bit_field, from_template: File.join(__dir__, 'common.erb')

      private

      def full_name
        bit_field.full_name('_')
      end

      def width
        bit_field.width
      end

      def lsb
        bit_field.lsb(bit_field.local_index)
      end

      def clock
        register_block.clock
      end

      def reset
        register_block.reset
      end

      def array_size
        bit_field.array_size
      end

      def initial_value
        index = bit_field.initial_value_array? && loop_variables || nil
        bit_field.initial_value[index]
      end

      def bit_field_if
        bit_field.bit_field_sub_if
      end

      def reference_bit_field
        return unless bit_field.reference?

        bit_field
          .find_reference(register_block.bit_fields)
          .value(bit_field.local_indexes, bit_field.reference_width)
      end

      def mask
        reference_bit_field || all_bits_1
      end

      def loop_variables
        bit_field.loop_variables
      end
    end

    factory do
      def target_feature_key(_configuration, bit_field)
        return bit_field.type if target_features.key?(bit_field.type)

        error "code generator for #{bit_field.type} " \
              'bit field type is not implemented'
      end
    end
  end
end
