# frozen_string_literal: true

module RgGen
  module Veryl
    module RegisterMap
      module KeywordChecker
        VERYL_KEYWORDS = [
          'always_comb', 'always_ff', 'as', 'assign', 'bit', 'break', 'case', 'clock',
          'clock_negedge', 'clock_posedge', 'const', 'default', 'else', 'embed', 'enum',
          'export', 'f32', 'f64', 'final', 'for', 'function', 'i32', 'i64', 'if',
          'if_reset', 'import', 'in', 'include', 'initial', 'inout', 'input', 'inside',
          'inst', 'interface', 'let', 'local', 'logic', 'modport', 'module', 'output',
          'outside', 'package', 'param', 'proto', 'pub', 'ref', 'repeat', 'reset',
          'reset_async_high', 'reset_async_low', 'reset_sync_high', 'reset_sync_low',
          'return', 'signed', 'step', 'struct', 'switch', 'tri', 'type', 'u32', 'u64',
          'unsafe', 'var'
        ].freeze

        def self.included(klass)
          klass.class_eval do
            verify(:feature, prepend: true) do
              error_condition do
                @name && VERYL_KEYWORDS.include?(@name)
              end
              message do
                layer_name = component.layer.to_s.sub('_', ' ')
                "veryl keyword is not allowed for #{layer_name} name: #{@name}"
              end
            end
          end
        end
      end
    end
  end
end
