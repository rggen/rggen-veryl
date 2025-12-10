# frozen_string_literal: true

module RgGen
  module Veryl
    module Utility
      class Modport < SystemVerilog::Common::Utility::InterfacePort
        define_attribute :generics

        def declaration
          [
            "#{name}:",
            'modport',
            port_type
          ].join(' ')
        end

        private

        def port_type
          "#{@interface_type}#{generics_notation}::#{@modport_name}#{array_size_notation}"
        end

        def generics_notation
          return unless @generics

          "::<#{@generics.join(', ')}>"
        end

        def array_size_notation
          return if (@array_size&.size || 0).zero?

          "[#{@array_size.join(', ')}]"
        end
      end
    end
  end
end
