# frozen_string_literal: true

RgGen.define_list_feature(:register, :type) do
  veryl do
    base_feature do
      include RgGen::SystemVerilog::RTL::RegisterType

      private

      def readable?
        register.readable?
      end

      def writable?
        register.writable?
      end

      def register_if
        register_block.register_if[register.index]
      end

      def bit_field_if
        register.bit_field_if
      end
    end

    default_feature do
      template = File.join(__dir__, 'type', 'default.erb')
      main_code :register, from_template: template
    end

    factory do
      def target_feature_key(_configuration, register)
        type = register.type
        return type if [:default, *target_features.keys].any? { type == _1 }

        error "code generator for #{type} register type " \
              'is not implemented'
      end
    end
  end
end
