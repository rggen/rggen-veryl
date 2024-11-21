# frozen_string_literal: true

RgGen.define_simple_feature(:register_block, :veryl_top) do
  veryl do
    build do
      input :clock, { name: 'i_clk', type: :clock }
      input :reset, { name: 'i_rst', type: :reset }

      interface :register_if, {
        name: 'register_if', interface_type: 'rggen_register_if',
        param_values: param_values, array_size: [total_registers], variables: ['value']
      }
    end

    export def value_width
      register_block.registers.max_by(&:width)&.width
    end

    export def total_registers
      register_block.files_and_registers.sum(&:count)
    end

    private

    def param_values
      { ADDRESS_WIDTH: address_width, BUS_WIDTH: bus_width, VALUE_WIDTH: value_width }
    end

    def address_width
      register_block.local_address_width
    end

    def bus_width
      configuration.bus_width
    end
  end
end
