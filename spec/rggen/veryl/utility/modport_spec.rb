# frozen_string_literal: true

RSpec.describe RgGen::Veryl::Utility::Modport do
  def modport(if_type, name, attributes = {}, &block)
    described_class.new(
      { interface_type: if_type, name: name }
        .merge(attributes),
      &block
    )
  end

  let(:generics) do
    foo =
      RgGen::Veryl::Utility::DataObject
        .new(:generic, name: :FOO, type: :proto_foo)
        .identifier
    bar =
      RgGen::Veryl::Utility::DataObject
        .new(:generic, name: :BAR, type: :const, default: 0)
        .identifier
    [foo, bar]
  end

  describe '#declaration' do
    it 'modportの宣言を返す' do
      expect(modport(:foo_if, :foo, modport: :slave))
        .to match_declaration('foo: modport foo_if::slave')
      expect(modport(:foo_if, :foo, modport: [:slave, :bar, :baz]))
        .to match_declaration('foo: modport foo_if::slave')
      expect(modport(:foo_if, :foo, modport: :slave, array_size: [2]))
        .to match_declaration('foo: modport foo_if::slave[2]')
      expect(modport(:foo_if, :foo, modport: [:slave, :bar, :baz], array_size: [2]))
        .to match_declaration('foo: modport foo_if::slave[2]')
      expect(modport(:foo_if, :foo, modport: :slave, array_size: [2, 3]))
        .to match_declaration('foo: modport foo_if::slave[2, 3]')
      expect(modport(:foo_if, :foo, modport: [:slave, :bar, :baz], array_size: [2, 3]))
        .to match_declaration('foo: modport foo_if::slave[2, 3]')
      expect(modport(:foo_if, :foo, modport: :slave, generics: []))
        .to match_declaration('foo: modport foo_if::<>::slave')
      expect(modport(:foo_if, :foo, modport: :slave, generics: generics))
        .to match_declaration('foo: modport foo_if::<FOO, BAR>::slave')
    end
  end
end
