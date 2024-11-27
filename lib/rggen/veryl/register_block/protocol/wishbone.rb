# frozen_string_literal: true

RgGen.define_list_item_feature(:register_block, :protocol, :wishbone) do
  veryl do
    build do
      param :use_stall, {
        name: 'USE_STALL', type: :bit, default: 1
      }
      modport :wishbone_if, {
        name: 'wishbone_if', interface_type:
        'rggen::rggen_wishbone_if', modport: 'slave'
      }
    end

    main_code :register_block, from_template: true
  end
end
