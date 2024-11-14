# frozen_string_literal: true

module RgGen
  module Veryl
    module Utility
      class InterfaceInstance < SystemVerilog::Common::Utility::InterfaceInstance
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
            parameter_assignments
          ].join
        end

        def array_size_notation
          return if (array_size&.size || 0).zero?

          "[#{array_size.join(', ')}]"
        end

        def parameter_assignments
          return if (parameter_values&.size || 0).zero?

          "#(#{parameter_values.map { |k, v| "#{k}: #{v}" }.join(', ')})"
        end
      end
    end
  end
end
