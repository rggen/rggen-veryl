# frozen_string_literal: true

RgGen.define_simple_feature(:register, :veryl_top) do
  veryl do
    build do
      unless register.bit_fields.empty?
        interface :bit_field_if, {
          name: 'bit_field_if', interface_type: 'rggen_bit_field_if',
          param_values: { WIDTH: register.width }
        }
      end
    end
  end
end
