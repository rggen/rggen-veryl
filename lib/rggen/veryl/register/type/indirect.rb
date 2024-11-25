# frozen_string_literal: true

RgGen.define_list_item_feature(:register, :type, :indirect) do
  veryl do
    include RgGen::SystemVerilog::RTL::IndirectIndex

    build do
      var :indirect_match, { width: index_match_width }
    end

    main_code :register do |code|
      indirect_index_matches(code)
      code << process_template
    end

    private

    def array_index_value(value, width)
      width_cast(value, width)
    end
  end
end
