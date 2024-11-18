# frozen_string_literal: true

RSpec.shared_context 'veryl common' do
  include_context 'configuration common'
  include_context 'register map common'

  def build_veryl_factory(builder)
    builder.build_factory(:output, :veryl)
  end

  def create_veryl(configuration = nil, &data_block)
    register_map = create_register_map(configuration) do
      register_block(&data_block)
    end

    @veryl_factory[0] ||= build_veryl_factory(RgGen.builder)
    @veryl_factory[0]
      .create(
        configuration || default_configuration,
        register_map
      )
  end

  def have_port(*args, &body)
    layer, handler, attributes =
      case args.size
      when 3 then args[0..2]
      when 2 then [nil, args[0], args[1]]
      else [nil, args[0], {}]
      end
    attributes = { name: handler }.merge(attributes)
    port = RgGen::Veryl::Utility::DataObject.new(:port, **attributes, &body)
    have_declaration(layer, :port, port.declaration).and have_identifier(handler, port.identifier)
  end

  def not_have_port(*args, &body)
    layer, handler, attributes =
      case args.size
      when 3 then args[0..2]
      when 2 then [nil, args[0], args[1]]
      else [nil, args[0], {}]
      end
    attributes = { name: handler }.merge(attributes)
    port = RgGen::Veryl::Utility::DataObject.new(:port, **attributes, &body)
    not_have_declaration(layer, :port, port.declaration).and not_have_identifier(handler, port.identifier)
  end

  def have_param(*args, &body)
    layer, handler, attributes =
      case args.size
      when 3 then args[0..2]
      when 2 then [nil, args[0], args[1]]
      else [nil, args[0], {}]
      end
    attributes = { name: handler }.merge(attributes)
    param = RgGen::Veryl::Utility::DataObject.new(:param, **attributes, &body)
    have_declaration(layer, :parameter, param.declaration).and have_identifier(handler, param.identifier)
  end

  def have_const(*args, &body)
    layer, handler, attributes =
      case args.size
      when 3 then args[0..2]
      when 2 then [nil, args[0], args[1]]
      else [nil, args[0], {}]
      end
    attributes = { name: handler }.merge(attributes)
    const = RgGen::Veryl::Utility::DataObject.new(:const, **attributes, &body)
    have_declaration(layer, :parameter, const.declaration).and have_identifier(handler, const.identifier)
  end

  def have_interface(*args, &body)
    layer, handler, attributes =
      case args.size
      when 3 then args[0..2]
      when 2 then [nil, args[0], args[1]]
      else [nil, args[0], {}]
      end
    attributes = { name: handler }.merge(attributes)
    interface = RgGen::Veryl::Utility::InterfaceInstance.new(**attributes, &body)
    have_declaration(layer, :variable, interface.declaration).and have_identifier(handler, interface.identifier)
  end

  def not_have_interface(*args, &body)
    layer, handler, attributes =
      case args.size
      when 3 then args[0..2]
      when 2 then [nil, args[0], args[1]]
      else [nil, args[0], {}]
      end
    attributes = { name: handler }.merge(attributes)
    interface = RgGen::Veryl::Utility::InterfaceInstance.new(**attributes, &body)
    not_have_declaration(layer, :variable, interface.declaration).and not_have_identifier(handler, interface.identifier)
  end

  def delete_veryl_factory
    @veryl_factory.clear
  end

  before(:all) do
    @veryl_factory ||= []
  end
end

RSpec.shared_context 'bit field common' do
  include_context 'veryl common'

  before(:all) do
    RgGen.enable(:global, [:bus_width, :address_width, :enable_wide_register])
    RgGen.enable(:register_block, :byte_size)
    RgGen.enable(:register_file, [:name, :size, :offset_address])
    RgGen.enable(:register, [:name, :size, :type, :offset_address])
    RgGen.enable(:bit_field, [:name, :bit_assignment, :initial_value, :reference, :type])
    RgGen.enable(:register_block, :veryl_top)
    RgGen.enable(:register_file, :veryl_top)
    RgGen.enable(:register, :veryl_top)
    RgGen.enable(:bit_field, :veryl_top)
  end

  def create_bit_fields(&body)
    configuration = create_configuration(enable_wide_register: true)
    create_veryl(configuration, &body).bit_fields
  end
end
