# frozen_string_literal: true

module RgGen
  module Veryl
    class Feature < SystemVerilog::Common::Feature
      include Utility

      private

      def create_if_instance(_, attributes, &block)
        InterfaceInstance.new(attributes, &block)
      end

      def create_port(direction, attributes, &block)
        attributes =
          { direction: direction }
            .merge(attributes)
        DataObject.new(:port, attributes, &block)
      end

      define_entity :input, :create_port, :port, -> { register_block }
      define_entity :output, :create_port, :port, -> { register_block }
      define_entity :interface, :create_if_instance, :variable, -> { component }
    end
  end
end
