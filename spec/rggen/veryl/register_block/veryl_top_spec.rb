# frozen_string_literal: true

RSpec.describe 'register_block/veryl_top' do
  include_context 'veryl common'
  include_context 'clean-up builder'

  before(:all) do
    RgGen.enable_all
  end

  def create_register_block(&body)
    configuration =
      create_configuration(
        bus_width: bus_width, enable_wide_register: true
      )
    create_veryl(configuration, &body).register_blocks.first
  end

  let(:address_width) do
    8
  end

  let(:bus_width) do
    32
  end

  describe 'clock/reset' do
    it 'clock/resetを持つ' do
      register_block = create_register_block { name 'block_0'; byte_size 256 }
      expect(register_block)
        .to have_port(:clock, name: 'i_clk', type: :clock, direction: :input)
      expect(register_block)
        .to have_port(:reset, name: 'i_rst', type: :reset, direction: :input)
    end
  end

  describe 'register_if' do
    it 'レジスタの個数分のrggen::rggen_register_ifのインスタンスを持つ' do
      register_block = create_register_block do
        name 'block_0'
        byte_size 256
        register do
          name 'register_0'
          offset_address 0x00
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
        end
      end
      expect(register_block)
        .to have_interface(
          :register_if,
          name: 'register_if', interface_type: 'rggen::rggen_register_if',
          param_values: {
            ADDRESS_WIDTH: address_width, BUS_WIDTH: bus_width, VALUE_WIDTH: 1 * bus_width
          },
          array_size: [1]
        )

      register_block = create_register_block do
        name 'block_0'
        byte_size 256
        register do
          name 'register_0'
          offset_address 0x00
          size [2, 4]
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
        end
      end
      expect(register_block)
        .to have_interface(
          :register_if,
          name: 'register_if', interface_type: 'rggen::rggen_register_if',
          param_values: {
            ADDRESS_WIDTH: address_width, BUS_WIDTH: bus_width, VALUE_WIDTH: 1 * bus_width
          },
          array_size: [8]
        )

      register_block = create_register_block do
        name 'block_0'
        byte_size 256
        register do
          name 'register_0'
          offset_address 0x00
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
        end
        register do
          name 'register_1'
          offset_address 0x10
          bit_field { name 'bit_field_0'; bit_assignment lsb: 32; type :rw; initial_value 0 }
        end
        register do
          name 'register_2'
          offset_address 0x20
          bit_field { name 'bit_field_0'; bit_assignment lsb: 64; type :rw; initial_value 0 }
        end
      end
      expect(register_block)
        .to have_interface(
          :register_if,
          name: 'register_if', interface_type: 'rggen::rggen_register_if',
          param_values: {
            ADDRESS_WIDTH: address_width, BUS_WIDTH: bus_width, VALUE_WIDTH: 3 * bus_width
          },
          array_size: [3]
        )

      register_block = create_register_block do
        name 'block_0'
        byte_size 256

        register_file do
          name 'register_file_0'
          register do
            name 'register_0'
            bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
          end
          register do
            name 'register_1'
            size [2, 2]
            bit_field { name 'bit_field_0'; bit_assignment lsb: 32; type :rw; initial_value 0 }
          end
        end

        register_file do
          name 'register_file_1'
          size [2, 2]
          register_file do
            name 'register_file_0'
            register do
              name 'register_0'
              bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
            end
            register do
              name 'register_1'
              size [2, 2]
              bit_field { name 'bit_field_0'; bit_assignment lsb: 32; type :rw; initial_value 0 }
            end
          end
        end
      end
      expect(register_block)
        .to have_interface(
          :register_if,
          name: 'register_if', interface_type: 'rggen::rggen_register_if',
          param_values: {
            ADDRESS_WIDTH: address_width, BUS_WIDTH: bus_width, VALUE_WIDTH: 2 * bus_width
          },
          array_size: [25]
        )
    end

    specify '内部信号\'value\'を参照できる' do
      register_block = create_register_block do
        name 'block_0'
        byte_size 256
        register do
          name 'register_0'
          offset_address 0x00
          bit_field { name 'bit_field_0'; bit_assignment lsb: 0; type :rw; initial_value 0 }
        end
      end
      expect(register_block.register_if[0].value).to match_identifier('register_if[0].value')
    end
  end

  describe '#write_file' do
    before do
      allow(FileUtils).to receive(:mkpath)
    end

    let(:configuration) do
      file = ['config.json', 'config.toml', 'config.yml'].sample
      path = File.join(RGGEN_SAMPLE_DIRECTORY, file)
      build_configuration_factory(RgGen.builder, false).create([path])
    end

    let(:register_map) do
      file_0 = ['block_0.rb', 'block_0.toml', 'block_0.yml'].sample
      file_1 = ['block_1.rb', 'block_1.toml', 'block_1.yml'].sample
      path = [file_0, file_1].map { |file| File.join(RGGEN_SAMPLE_DIRECTORY, file) }
      build_register_map_factory(RgGen.builder, false).create(configuration, path)
    end

    let(:register_blocks) do
      build_veryl_factory(RgGen.builder).create(configuration, register_map).register_blocks
    end

    let(:expected_code) do
      [
        File.join(RGGEN_SAMPLE_DIRECTORY, 'block_0.veryl'),
        File.join(RGGEN_SAMPLE_DIRECTORY, 'block_1.veryl')
      ].map { |path| File.binread(path) }
    end

    it 'RTLのソースファイルを書き出す' do
      expect {
        register_blocks[0].write_file('foo')
      }.to write_file match_string('foo/block_0.veryl'), expected_code[0]

      expect {
        register_blocks[1].write_file('bar')
      }.to write_file match_string('bar/block_1.veryl'), expected_code[1]
    end
  end
end
