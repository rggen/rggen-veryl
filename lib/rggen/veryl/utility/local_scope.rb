# frozen_string_literal: true

module RgGen
  module Veryl
    module Utility
      class LocalScope < SystemVerilog::Common::Utility::StructureDefinition
        define_attribute :name
        define_attribute :consts
        define_attribute :variables
        define_attribute :loop_size

        private

        def header_code(code)
          code << ":#{name} {" << nl
        end

        def footer_code(code)
          code << '}'
        end

        def pre_body_code(code)
          generate_for_header(code)
          add_declarations_to_body(code, Array(consts))
          add_declarations_to_body(code, Array(variables))
        end

        def generate_for_header(code)
          loop_size&.each do |genvar, size|
            code << "for #{genvar} in 0..#{size} :g {" << nl
            code.indent += 2
          end
        end

        def post_body_code(code)
          generate_for_footer(code)
        end

        def generate_for_footer(code)
          loop_size&.each do
            code.indent -= 2
            code << '}' << nl
          end
        end
      end
    end
  end
end
