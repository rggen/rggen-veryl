# frozen_string_literal: true

module RgGen
  module Veryl
    module Utility
      class DataObject
        include Core::Utility::AttributeSetter

        def initialize(object_type, default_attributes = {})
          @object_type = object_type
          apply_attributes(**default_attributes)
          block_given? && yield(self)
        end

        define_attribute :name
        define_attribute :direction
        define_attribute :type, :logic
        define_attribute :width
        define_attribute :array_size
        define_attribute :default

        def declaration
          declaration_snippets
            .reject { _1.nil? || _1.empty? }
            .join(' ')
        end

        def identifier
          SystemVerilog::Common::Utility::Identifier.new(name) do |id|
            id.__width__(width)
            id.__array_size__(array_size)
          end
        end

        private

        def declaration_snippets
          [
            declaration_header,
            "#{name}:",
            direction_keyword,
            type_declaration,
            default_value
          ]
        end

        def declaration_header
          @object_type if @object_type in :var | :param | :const
        end

        def direction_keyword
          @direction if @object_type == :port
        end

        def type_declaration
          if emit_width? || array_size
            "#{type}<#{array_dimensions.join(', ')}>"
          else
            type
          end
        end

        def emit_width?
          (@object_type != :generic) && width && (!width.is_a?(Integer) || width >= 2)
        end

        def array_dimensions
          dimensions = Array(array_size)
          dimensions << width if emit_width?
          dimensions
        end

        def default_value
          "= #{default}" if emit_default_value?
        end

        def emit_default_value?
          instance_variable_defined?(:@default) &&
            (@object_type in :generic | :param | :const)
        end
      end
    end
  end
end
