# frozen_string_literal: true

RSpec.describe RgGen::Veryl::Utility::Modport do
  def modport(if_type, name, attributes = {}, &block)
    described_class.new(
      { interface_type: if_type, name: name }
        .merge(attributes),
      &block
    )
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
    end
  end
end
