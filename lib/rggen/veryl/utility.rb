# frozen_string_literal: true

module RgGen
  module Veryl
    module Utility
      private

      def local_scope(name, attributes = {}, &block)
        LocalScope
          .new(attributes.merge(name: name), &block)
          .to_code
      end

      def module_definition(name, attributes = {}, &block)
        ModuleDefinition
          .new(attributes.merge(name: name), &block)
          .to_code
      end
    end
  end
end
