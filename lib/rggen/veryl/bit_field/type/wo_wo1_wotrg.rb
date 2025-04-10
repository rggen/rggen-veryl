# frozen_string_literal: true

RgGen.define_list_item_feature(:bit_field, :type, [:wo, :wo1, :wotrg]) do
  veryl do
    build do
      output :value_out, {
        name: "o_#{full_name}", width:, array_size:
      }
      if wotrg?
        output :write_trigger, {
          name: "o_#{full_name}_write_trigger", width: 1, array_size:
        }
      end
    end

    main_code :bit_field, from_template: true

    private

    def wotrg?
      bit_field.type == :wotrg
    end

    def write_trigger_signal
      wotrg? && write_trigger[loop_variables] || unused
    end

    def write_once?
      bit_field.type == :wo1
    end
  end
end
