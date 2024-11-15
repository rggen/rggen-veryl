# frozen_string_literal: true

RSpec.describe RgGen::Veryl::Utility::InterfaceInstance do
  def interface_instance(if_type, name, &block)
    described_class.new(interface_type: if_type, name: name, &block)
  end

  describe '#instantiation' do
    it 'インターフェースのインスタンス記述を返す' do
      expect(interface_instance(:foo_if, :foo).instantiation)
        .to match_string('inst foo: foo_if')
      expect(interface_instance(:foo_if, :foo) { |i|
        i.param_values BAR: 2, BAZ: 3
      }.instantiation)
        .to match_string('inst foo: foo_if#(BAR: 2, BAZ: 3)')
      expect(interface_instance(:foo_if, :foo) { |i|
        i.array_size [2, 3]
      }.instantiation)
        .to match_string('inst foo: foo_if[2, 3]')
      expect(interface_instance(:foo_if, :foo) { |i|
        i.array_size [2, 3]
        i.param_values BAR: 4, BAZ: 5
      }.instantiation)
        .to match_string('inst foo: foo_if[2, 3]#(BAR: 4, BAZ: 5)')
    end
  end
end
