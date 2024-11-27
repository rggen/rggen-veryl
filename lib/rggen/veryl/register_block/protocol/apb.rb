# frozen_string_literal: true

RgGen.define_list_item_feature(:register_block, :protocol, :apb) do
  veryl do
    build do
      modport :apb_if, {
        name: 'apb_if',
        interface_type: 'rggen::rggen_apb_if', modport: 'slave'
      }
    end

    main_code :register_block, from_template: true
  end
end
