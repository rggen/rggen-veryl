# frozen_string_literal: true

RgGen.define_simple_feature(:register_file, :veryl_top) do
  veryl do
    include RgGen::SystemVerilog::RTL::RegisterIndex
  end
end
