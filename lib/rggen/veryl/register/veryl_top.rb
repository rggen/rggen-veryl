# frozen_string_literal: true

RgGen.define_simple_feature(:register, :veryl_top) do
  veryl do
    include RgGen::SystemVerilog::RTL::RegisterIndex

    build do
      unless register.bit_fields.empty?
        interface :bit_field_if, {
          name: 'bit_field_if', interface_type: 'rggen::rggen_bit_field_if',
          param_values: { WIDTH: register.width },
          variables: [
            'read_valid', 'write_valid', 'mask', 'write_data', 'read_data', 'value'
          ]
        }
      end
    end

    main_code :register_file do
      local_scope("g_#{register.name}") do |s|
        s.loop_size loop_size
        s.variables variables
        s.body { |c| body_code(c) }
      end
    end

    private

    def loop_size
      return nil unless register.array?

      local_loop_variables.zip(register.array_size).to_h
    end

    def variables
      register.declarations[:variable]
    end

    def body_code(code)
      register.generate_code(code, :register, :top_down)
    end
  end
end
