# frozen_string_literal: true

RgGen.define_list_item_feature(:bit_field, :type, [:rc, :w0c, :w1c, :wc, :woc]) do
  veryl do
    build do
      input :set, {
        name: "i_#{full_name}_set", width:, array_size:
      }
      output :value_out, {
        name: "o_#{full_name}", width:, array_size:
      }
      if bit_field.reference?
        output :value_unmasked, {
          name: "o_#{full_name}_unmasked", width:, array_size:
        }
      end
    end

    main_code :bit_field, from_template: true

    private

    def read_action
      {
        rc: 'READ_CLEAR', woc: 'READ_NONE'
      }.fetch(bit_field.type, 'READ_DEFAULT')
    end

    def write_action
      {
        rc: 'WRITE_NONE', w0c: 'WRITE_0_CLEAR', w1c: 'WRITE_1_CLEAR'
      }.fetch(bit_field.type, 'WRITE_CLEAR')
    end

    def value_out_unmasked_singal
      bit_field.reference? && value_unmasked[loop_variables] || unused
    end

    def external_mask?
      bit_field.reference?
    end
  end
end
