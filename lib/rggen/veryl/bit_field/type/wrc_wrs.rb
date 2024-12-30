# frozen_string_literal: true

RgGen.define_list_item_feature(:bit_field, :type, [:wrc, :wrs]) do
  veryl do
    build do
      output :value_out, {
        name: "o_#{full_name}", width:, array_size:
      }
    end

    main_code :bit_field, from_template: true

    private

    def read_action
      { wrc: 'READ_CLEAR', wrs: 'READ_SET' }[bit_field.type]
    end
  end
end
