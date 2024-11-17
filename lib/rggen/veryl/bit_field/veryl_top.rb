# frozen_string_literal: true

RgGen.define_simple_feature(:bit_field, :veryl_top) do
  veryl do
    include RgGen::SystemVerilog::RTL::BitFieldIndex

    build do
      if bit_field.fixed_initial_value?
        const :initial_value, {
          name: initial_value_name, type: :bit, width: bit_field.width,
          array_size: initial_value_size, default: initial_value_rhs
        }
      elsif bit_field.initial_value?
        param :initial_value, {
          name: initial_value_name, type: :bit, width: bit_field.width,
          array_size: initial_value_size, default: initial_value_rhs
        }
      end

      interface :bit_field_sub_if, {
        name: 'bit_field_sub_if', interface_type: 'rggen_bit_field_if',
        param_values: { WIDTH: bit_field.width }
      }
    end

    private

    def initial_value_name
      if bit_field.fixed_initial_value?
        'INITIAL_VALUE'
      else
        "#{bit_field.full_name('_').upcase}_INITIAL_VALUE"
      end
    end

    def initial_value_size
      return unless bit_field.initial_value_array?

      [bit_field.sequence_size]
    end

    def initial_value_rhs
      if !bit_field.initial_value_array?
        sized_initial_value
      elsif bit_field.fixed_initial_value?
        array(sized_initial_values)
      else
        repeat(bit_field.sequence_size, sized_initial_value)
      end
    end

    def sized_initial_value
      hex(bit_field.initial_value, bit_field.width)
    end

    def sized_initial_values
      bit_field.initial_values.map { |v| hex(v, bit_field.width) }
    end
  end
end
