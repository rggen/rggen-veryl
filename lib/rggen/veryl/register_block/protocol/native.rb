# frozen_string_literal: true

RgGen.define_list_item_feature(:register_block, :protocol, :native) do
  veryl do
    build do
      param :strobe_width, {
        name: 'STROBE_WIDTH', type: :u32, default: bus_width / 8
      }
      param :use_read_strobe, {
        name: 'USE_READ_STROBE', type: :bit, default: 0
      }
      modport :csrbus_if, {
        name: 'csrbus_if',
        interface_type: 'rggen::rggen_bus_if', modport: 'slave'
      }
    end

    main_code :register_block, from_template: true
  end
end
