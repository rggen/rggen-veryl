# frozen_string_literal: true

module RgGen
  module Veryl
    module RegisterMap
      module KeywordChecker
        VERYL_KEYWORDS = [
          'alias', 'always_comb', 'always_ff', 'assign', 'as', 'bind', 'bit', 'block', 'bbool', 'lbool', 'case',
          'clock', 'clock_posedge', 'clock_negedge', 'connect', 'const', 'converse', 'default', 'else', 'embed',
          'enum', 'f32', 'f64', 'false', 'final', 'for', 'function', 'i8', 'i16', 'i32', 'i64', 'if_reset', 'if',
          'import', 'include', 'initial', 'inout', 'input', 'inside', 'inst', 'interface', 'in', 'let', 'logic',
          'lsb', 'modport', 'module', 'msb', 'output', 'outside', 'package', 'param', 'proto', 'pub', 'repeat',
          'reset', 'reset_async_high', 'reset_async_low', 'reset_sync_high', 'reset_sync_low', 'return', 'rev',
          'break', 'same', 'signed', 'step', 'string', 'struct', 'switch', 'tri', 'true', 'type', 'u8', 'u16', 'u32',
          'u64', 'union', 'unsafe', 'var'
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
