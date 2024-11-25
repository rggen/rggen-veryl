# frozen_string_literal: true

RgGen.define_simple_feature(:register_file, :veryl_top) do
  veryl do
    include RgGen::SystemVerilog::RTL::RegisterIndex

    main_code :register_file do
      local_scope("g_#{register_file.name}") do |s|
        s.loop_size loop_size
        s.body { |c| body_code(c) }
      end
    end

    private

    def loop_size
      return nil unless register_file.array?

      local_loop_variables.zip(register_file.array_size).to_h
    end

    def body_code(code)
      register_file.generate_code(code, :register_file, :top_down, 1)
    end
  end
end
