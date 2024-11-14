# frozen_string_literal: true

module RgGen
  module Veryl
    module Utility
      class Modport < SystemVerilog::Common::Utility::InterfacePort
        def declaration
          [
            'modport',
            "#{name}:",
            port_type
          ].join(' ')
        end

        private

        def port_type
          "#{@interface_type}::#{@modport_name}#{array_size_notation}"
        end

        def array_size_notation
          return if (@array_size&.size || 0).zero?

          "[#{@array_size.join(', ')}]"
        end
      end
    end
  end
end
