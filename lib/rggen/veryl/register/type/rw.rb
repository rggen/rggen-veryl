# frozen_string_literal: true

RgGen.define_list_item_feature(:register, :type, :rw) do
  veryl do
    main_code :register, from_template: true
  end
end
