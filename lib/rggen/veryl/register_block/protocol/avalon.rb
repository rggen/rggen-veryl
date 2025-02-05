# frozen_string_literal: true

RgGen.define_list_item_feature(:register_block, :protocol, :avalon) do
  veryl do
    build do
      modport :avalon_if, {
        name: 'avalon_if',
        interface_type: 'rggen::rggen_avalon_if', modport: 'agent'
      }
    end

    main_code :register_block, from_template: true
  end
end
