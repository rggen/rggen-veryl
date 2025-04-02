# frozen_string_literal: true

module RgGen
  module Veryl
    module Utility
      class ModuleDefinition < SystemVerilog::Common::Utility::StructureDefinition
        define_attribute :name
        define_attribute :package_imports
        define_attribute :generics
        define_attribute :params
        define_attribute :ports
        define_attribute :variables

        private

        def header_code(code)
          package_import_declaration(code)
          module_header_begin(code)
          generic_declarations(code)
          param_declarations(code)
          port_declarations(code)
          module_header_end(code)
        end

        def package_import_declaration(code)
          package_imports&.each do |package|
            code << "import #{package}::*;" << nl
          end
        end

        def module_header_begin(code)
          code << "pub module #{name}"
          code << ' ' unless include_generics?
        end

        def include_generics?
          (generics&.size || 0).positive?
        end

        def generic_declarations(code)
          return unless include_generics?

          wrap(code, '::<', '>') do
            add_declarations_to_header(code, generics)
          end
        end

        def param_declarations(code)
          return if (params&.size || 0).zero?

          wrap(code, '#(', ')') do
            add_declarations_to_header(code, params)
          end
        end

        def port_declarations(code)
          return if (ports&.size || 0).zero?

          wrap(code, '(', ')') do
            add_declarations_to_header(code, ports)
          end
        end

        def module_header_end(code)
          code << '{' << nl
        end

        def pre_body_code(code)
          add_declarations_to_body(code, Array(variables))
        end

        def footer_code
          '}'
        end
      end
    end
  end
end
