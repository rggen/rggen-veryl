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
          if width || array_size
            "#{type}<#{[*array_size, width].compact.join(', ')}>"
          else
            type
          end
        end

        def default_value
          "= #{default}" if @object_type in :param | :const
        end
      end
    end
  end
end
