# frozen_string_literal: true

RSpec.describe RgGen::Veryl::Feature do
  let(:configuration) do
    RgGen::Core::Configuration::Component.new(nil, 'configuration', nil)
  end

  let(:register_map) do
    RgGen::Core::RegisterMap::Component.new(nil, 'register_map', nil, configuration)
  end

  let(:components) do
    register_block = create_component(nil, :register_block)
    register = create_component(register_block, :register)
    bit_field = create_component(register, :bit_field)
    [register_block, register, bit_field]
  end

  let(:features) do
    components.map do |component|
      described_class.new(:foo, nil, component) { |f| component.add_feature(f) }
    end
  end

  def create_component(parent, layer)
    RgGen::Veryl::Component.new(parent, 'component', layer, configuration, register_map)
  end

  describe '#generic' do
    it 'ジェネリクス宣言を追加する' do
      features[0].instance_eval { generic :foo, type: :const }
      features[1].instance_eval { generic :bar, name: 'barbar', type: :const }
      features[2].instance_eval { generic :baz, type: :const, default: 0 }

      expect(components[0]).to have_declaration(:generic, 'foo: const')
      expect(components[0]).to have_declaration(:generic, 'barbar: const')
      expect(components[0]).to have_declaration(:generic, 'baz: const = 0')
    end
  end
end
