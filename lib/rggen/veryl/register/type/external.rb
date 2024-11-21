# frozen_string_literal: true

RgGen.define_list_item_feature(:register, :type, :external) do
  veryl do
    build do
      param :strobe_width, {
        name: "#{register.name}_strobe_width".upcase,
        type: :int, default: configuration.byte_width
      }
      modport :bus_if, {
        name: "#{register.name}_bus_if",
        interface_type: 'rggen_bus_if', modport: 'master'
      }
    end

    main_code :register, from_template: true

    private

    def start_address
      hex(register.address_range.begin, address_width)
    end

    def byte_size
      register.total_byte_size
    end
  end
end
