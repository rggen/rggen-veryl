# frozen_string_literal: true

module RgGen
  module Veryl
    module Utility
      class InterfaceInstance < SystemVerilog::Common::Utility::InterfaceInstance
        alias_method :param_values, :parameter_values

        def instantiation
          [
            'inst',
            "#{name}:",
            type_notation
          ].join(' ')
        end

        private

        def type_notation
          [
            interface_type,
            array_size_notation,
            param_assignments
          ].join
        end

        def array_size_notation
          return if (array_size&.size || 0).zero?

          "[#{array_size.join(', ')}]"
        end

        def param_assignments
          return if (param_values&.size || 0).zero?

          "#(#{param_values.map { |k, v| "#{k}: #{v}" }.join(', ')})"
        end
      end
    end
  end
end
