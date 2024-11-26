# frozen_string_literal: true

RgGen.define_list_feature(:register_block, :protocol) do
  veryl do
    shared_context.feature_registry(registry)

    base_feature do
      build do
        param :address_width, {
          name: 'ADDRESS_WIDTH', type: :u32, default: local_address_width
        }
        param :pre_decode, {
          name: 'PRE_DECODE', type: :bit, default: 0
        }
        param :base_address, {
          name: 'BASE_ADDRESS', type: :bit, width: address_width, default: all_bits_0
        }
        param :error_status, {
          name: 'ERROR_STATUS', type: :bit, default: 0
        }
        param :default_read_data, {
          name: 'DEFAULT_READ_DATA', type: :bit, width: bus_width, default: all_bits_0
        }
        param :insert_slicer, {
          name: 'INSERT_SLICER', type: :bit, default: 0
        }
      end

      private

      def bus_width
        configuration.bus_width
      end

      def local_address_width
        register_block.local_address_width
      end

      def total_registers
        register_block.files_and_registers.sum(&:count)
      end

      def byte_size
        register_block.byte_size
      end
    end

    factory do
      def target_feature_key(configuration, _register_block)
        configuration.protocol
      end
    end
  end
end
