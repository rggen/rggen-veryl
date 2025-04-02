# frozen_string_literal: true

RgGen.define_list_item_feature(:register_block, :protocol, :axi4lite) do
  veryl do
    build do
      param :id_width, {
        name: 'ID_WIDTH', type: :u32, default: 0
      }
      param :write_first, {
        name: 'WRITE_FIRST', type: :bool, default: true
      }
      modport :axi4lite_if, {
        name: 'axi4lite_if',
        interface_type: 'rggen::rggen_axi4lite_if', modport: 'slave'
      }
    end

    main_code :register_block, from_template: true
  end
end
