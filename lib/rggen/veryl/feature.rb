# frozen_string_literal: true

module RgGen
  module Veryl
    class Feature < SystemVerilog::Common::Feature
      include Utility

      private

      def create_if_instance(_, attributes, &)
        InterfaceInstance.new(attributes, &)
      end

      def create_port(direction, attributes, &)
        attributes =
          { direction: }
            .merge(attributes)
        DataObject.new(:port, attributes, &)
      end

      def create_modport(_, attributes, &)
        Modport.new(attributes, &)
      end

      def create_generic(_, attributes, &)
        DataObject.new(:generic, attributes, &)
      end

      def create_param(_, attributes, &)
        DataObject.new(:param, attributes, &)
      end

      def create_const(_, attributes, &)
        DataObject.new(:const, attributes, &)
      end

      def create_var(_, attributes, &)
        DataObject.new(:var, attributes, &)
      end

      define_entity :input, :create_port, :port, -> { register_block }
      define_entity :output, :create_port, :port, -> { register_block }
      define_entity :modport, :create_modport, :port, -> { register_block }
      define_entity :interface, :create_if_instance, :variable, -> { component }
      define_entity :generic, :create_generic, :generic, -> { register_block }
      define_entity :param, :create_param, :parameter, -> { register_block }
      define_entity :const, :create_const, :parameter, -> { component }
      define_entity :var, :create_var, :variable, -> { component }
    end
  end
end
