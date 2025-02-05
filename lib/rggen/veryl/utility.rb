# frozen_string_literal: true

module RgGen
  module Veryl
    module Utility
      private

      def local_scope(name, attributes = {}, &)
        LocalScope
          .new(attributes.merge(name:), &)
          .to_code
      end

      def module_definition(name, attributes = {}, &)
        ModuleDefinition
          .new(attributes.merge(name:), &)
          .to_code
      end

      def width_cast(expression, width)
        "(#{expression} as #{width})"
      end

      def repeat(count, expression)
        "{#{expression} repeat #{count}}"
      end

      def array(expressions)
        concat(expressions.reverse)
      end

      def unused
        '_'
      end
    end
  end
end
