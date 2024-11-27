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
        name: 'bit_field_sub_if', interface_type: 'rggen::rggen_bit_field_if',
        param_values: { WIDTH: bit_field.width },
        variables: [
          'valid', 'read_mask', 'write_mask', 'write_data', 'read_data', 'value'
        ]
      }
    end

    main_code :register do
      local_scope("g_#{bit_field.name}") do |s|
        s.loop_size loop_size
        s.consts consts
        s.variables variables
        s.body { |c| body_code(c) }
      end
    end

    export def value(offsets = nil, width = nil)
      value_lsb = bit_field.lsb(offsets&.last || local_index)
      value_width = width || bit_field.width
      register_if(offsets&.[](0..-2)).value[value_lsb, value_width]
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

    def register_if(offsets)
      index = register.index(offsets || register.local_indices)
      register_block.register_if[index]
    end

    def loop_size
      loop_variable = local_index
      return unless loop_variable

      { loop_variable => bit_field.sequence_size }
    end

    def consts
      bit_field.declarations[:parameter]
    end

    def variables
      bit_field.declarations[:variable]
    end

    def body_code(code)
      bit_field.generate_code(code, :bit_field, :top_down)
    end
  end
end
