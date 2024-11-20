# frozen_string_literal: true

RgGen.define_list_item_feature(
  :bit_field, :type, [:w0crs, :w0src, :w1crs, :w1src, :wcrs, :wsrc]
) do
  veryl do
    build do
      output :value_out, {
        name: "o_#{full_name}",
        width: width, array_size: array_size
      }
    end

    main_code :bit_field, from_template: true

    private

    def read_action
      {
        w0crs: 'READ_SET', w1crs: 'READ_SET', wcrs: 'READ_SET'
      }.fetch(bit_field.type, 'READ_CLEAR')
    end

    def write_action
      {
        w0crs: 'WRITE_0_CLEAR',
        w0src: 'WRITE_0_SET',
        w1crs: 'WRITE_1_CLEAR',
        w1src: 'WRITE_1_SET',
        wcrs: 'WRITE_CLEAR',
        wsrc: 'WRITE_SET'
      }[bit_field.type]
    end
  end
end
