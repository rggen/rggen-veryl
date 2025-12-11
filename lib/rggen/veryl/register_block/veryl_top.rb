# frozen_string_literal: true

RgGen.define_simple_feature(:register_block, :veryl_top) do
  veryl do
    build do
      input :clock, { name: 'i_clk', type: :clock }
      input :reset, { name: 'i_rst', type: :reset }

      interface :register_if, {
        name: 'register_if', interface_type: 'rggen::rggen_register_if',
        param_values:, array_size: [total_registers], variables: ['value']
      }
    end

    export def value_width
      register_block.registers.max_by(&:width)&.width
    end

    export def total_registers
      register_block.files_and_registers.sum(&:count)
    end

    write_file '<%= register_block.name %>.veryl' do |f|
      f.body do |code|
        code << module_definition(register_block.name) do |m|
          m.attributes attributes
          m.package_imports packages
          m.generics generics
          m.params params
          m.ports ports
          m.variables variables
          m.body { |c| body_code(c) }
        end
      end
    end

    private

    def param_values
      { ADDRESS_WIDTH: address_width, BUS_WIDTH: bus_width, VALUE_WIDTH: value_width }
    end

    def address_width
      register_block.local_address_width
    end

    def bus_width
      register_block.bus_width
    end

    def attributes
      { fmt: :skip }
    end

    def packages
      ['rggen::rggen_rtl_pkg', *register_block.package_imports(:register_block)]
    end

    def generics
      register_block.declarations[:generic]
    end

    def params
      register_block.declarations[:parameter]
    end

    def ports
      register_block.declarations[:port]
    end

    def variables
      register_block.declarations[:variable]
    end

    def body_code(code)
      { register_block: nil, register_file: 1 }.each do |kind, depth|
        register_block.generate_code(code, kind, :top_down, depth)
      end
    end
  end
end
