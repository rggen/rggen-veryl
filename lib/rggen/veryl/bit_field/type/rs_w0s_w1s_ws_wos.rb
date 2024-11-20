# frozen_string_literal: true

RgGen.define_list_item_feature(:bit_field, :type, [:rs, :w0s, :w1s, :ws, :wos]) do
  veryl do
    build do
      input :clear, {
        name: "i_#{full_name}_clear",
        width: width, array_size: array_size
      }
      output :value_out, {
        name: "o_#{full_name}",
        width: width, array_size: array_size
      }
    end

    main_code :bit_field, from_template: true

    private

    def read_action
      {
        rs: 'READ_SET', wos: 'READ_NONE'
      }.fetch(bit_field.type, 'READ_DEFAULT')
    end

    def write_action
      {
        rs: 'WRITE_NONE', w0s: 'WRITE_0_SET', w1s: 'WRITE_1_SET'
      }.fetch(bit_field.type, 'WRITE_SET')
    end

    def sw_write_enable
      bit_field.writable? && all_bits_1 || all_bits_0
    end
  end
end
