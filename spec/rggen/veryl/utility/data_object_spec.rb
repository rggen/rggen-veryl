# frozen_string_literal: true

RSpec.describe RgGen::Veryl::Utility::DataObject do
  def var(name, &block)
    described_class.new(:var, name: name, &block)
  end

  def param(name, &block)
    described_class.new(:param, name: name, &block)
  end

  def const(name, &block)
    described_class.new(:const, name: name, &block)
  end

  def input(name, &block)
    described_class.new(:port, name: name, direction: :input, &block)
  end

  def output(name, &block)
    described_class.new(:port, name: name, direction: :output, &block)
  end

  def data_object(name, &block)
    type = [:var, :param, :const, :port].sample
    described_class.new(type, name: name, &block)
  end

  describe '#declaration' do
    context '変数の場合' do
      it '変数宣言を返す' do
        expect(var('foo')).to match_declaration('var foo: logic')
        expect(var('foo') { |o| o.width 2 }).to match_declaration('var foo: logic<2>')
        expect(var('foo') { |o| o.width 'WIDTH' }).to match_declaration('var foo: logic<WIDTH>')

        expect(var('foo') { |o| o.array_size [3] }).to match_declaration('var foo: logic<3>')
        expect(var('foo') { |o| o.array_size [3]; o.width 2 }).to match_declaration('var foo: logic<3, 2>')
        expect(var('foo') { |o| o.array_size [3]; o.width 'WIDTH' }).to match_declaration('var foo: logic<3, WIDTH>')

        expect(var('foo') { |o| o.array_size [4, 3] }).to match_declaration('var foo: logic<4, 3>')
        expect(var('foo') { |o| o.array_size [4, 3]; o.width 2 }).to match_declaration('var foo: logic<4, 3, 2>')
        expect(var('foo') { |o| o.array_size [4, 3]; o.width 'WIDTH' }).to match_declaration('var foo: logic<4, 3, WIDTH>')

        expect(var('foo') { |o| o.array_size ['ARRAY_SIZE'] }).to match_declaration('var foo: logic<ARRAY_SIZE>')
        expect(var('foo') { |o| o.array_size ['ARRAY_SIZE']; o.width 2 }).to match_declaration('var foo: logic<ARRAY_SIZE, 2>')
        expect(var('foo') { |o| o.array_size ['ARRAY_SIZE']; o.width 'WIDTH' }).to match_declaration('var foo: logic<ARRAY_SIZE, WIDTH>')
      end
    end

    context '入出力ポートの場合' do
      it 'ポート宣言を返す' do
        expect(input('foo')).to match_declaration('foo: input logic')
        expect(input('foo') { |o| o.width 2 }).to match_declaration('foo: input logic<2>')
        expect(input('foo') { |o| o.width 'WIDTH' }).to match_declaration('foo: input logic<WIDTH>')

        expect(input('foo') { |o| o.array_size [3] }).to match_declaration('foo: input logic<3>')
        expect(input('foo') { |o| o.array_size [3]; o.width 2 }).to match_declaration('foo: input logic<3, 2>')
        expect(input('foo') { |o| o.array_size [3]; o.width 'WIDTH' }).to match_declaration('foo: input logic<3, WIDTH>')

        expect(input('foo') { |o| o.array_size [4, 3] }).to match_declaration('foo: input logic<4, 3>')
        expect(input('foo') { |o| o.array_size [4, 3]; o.width 2 }).to match_declaration('foo: input logic<4, 3, 2>')
        expect(input('foo') { |o| o.array_size [4, 3]; o.width 'WIDTH' }).to match_declaration('foo: input logic<4, 3, WIDTH>')

        expect(input('foo') { |o| o.array_size ['ARRAY_SIZE'] }).to match_declaration('foo: input logic<ARRAY_SIZE>')
        expect(input('foo') { |o| o.array_size ['ARRAY_SIZE']; o.width 2 }).to match_declaration('foo: input logic<ARRAY_SIZE, 2>')
        expect(input('foo') { |o| o.array_size ['ARRAY_SIZE']; o.width 'WIDTH' }).to match_declaration('foo: input logic<ARRAY_SIZE, WIDTH>')

        expect(output('foo')).to match_declaration('foo: output logic')
        expect(output('foo') { |o| o.width 2 }).to match_declaration('foo: output logic<2>')
        expect(output('foo') { |o| o.width 'WIDTH' }).to match_declaration('foo: output logic<WIDTH>')

        expect(output('foo') { |o| o.array_size [3] }).to match_declaration('foo: output logic<3>')
        expect(output('foo') { |o| o.array_size [3]; o.width 2 }).to match_declaration('foo: output logic<3, 2>')
        expect(output('foo') { |o| o.array_size [3]; o.width 'WIDTH' }).to match_declaration('foo: output logic<3, WIDTH>')

        expect(output('foo') { |o| o.array_size [4, 3] }).to match_declaration('foo: output logic<4, 3>')
        expect(output('foo') { |o| o.array_size [4, 3]; o.width 2 }).to match_declaration('foo: output logic<4, 3, 2>')
        expect(output('foo') { |o| o.array_size [4, 3]; o.width 'WIDTH' }).to match_declaration('foo: output logic<4, 3, WIDTH>')

        expect(output('foo') { |o| o.array_size ['ARRAY_SIZE'] }).to match_declaration('foo: output logic<ARRAY_SIZE>')
        expect(output('foo') { |o| o.array_size ['ARRAY_SIZE']; o.width 2 }).to match_declaration('foo: output logic<ARRAY_SIZE, 2>')
        expect(output('foo') { |o| o.array_size ['ARRAY_SIZE']; o.width 'WIDTH' }).to match_declaration('foo: output logic<ARRAY_SIZE, WIDTH>')
      end
    end

    context 'パラメータの場合' do
      it 'パラメータ宣言を返す' do
        expect(param('foo') { |o| o.default 0 }).to match_declaration('param foo: logic = 0')
        expect(param('foo') { |o| o.type :bit; o.width 2; o.default 0 }).to match_declaration('param foo: bit<2> = 0')
        expect(param('foo') { |o| o.type :bit; o.width 'WIDTH'; o.default 0 }).to match_declaration('param foo: bit<WIDTH> = 0')

        expect(param('foo') { |o| o.type :bit; o.array_size [3]; o.default 0 }).to match_declaration('param foo: bit<3> = 0')
        expect(param('foo') { |o| o.type :bit; o.array_size [3]; o.width 2; o.default 0 }).to match_declaration('param foo: bit<3, 2> = 0')
        expect(param('foo') { |o| o.type :bit; o.array_size [3]; o.width 'WIDTH'; o.default 0 }).to match_declaration('param foo: bit<3, WIDTH> = 0')

        expect(param('foo') { |o| o.type :bit; o.array_size [4, 3]; o.default 0 }).to match_declaration('param foo: bit<4, 3> = 0')
        expect(param('foo') { |o| o.type :bit; o.array_size [4, 3]; o.width 2; o.default 0 }).to match_declaration('param foo: bit<4, 3, 2> = 0')
        expect(param('foo') { |o| o.type :bit; o.array_size [4, 3]; o.width 'WIDTH'; o.default 0 }).to match_declaration('param foo: bit<4, 3, WIDTH> = 0')

        expect(param('foo') { |o| o.type :bit; o.array_size ['ARRAY_SIZE']; o.default 0 }).to match_declaration('param foo: bit<ARRAY_SIZE> = 0')
        expect(param('foo') { |o| o.type :bit; o.array_size ['ARRAY_SIZE']; o.width 2; o.default 0 }).to match_declaration('param foo: bit<ARRAY_SIZE, 2> = 0')
        expect(param('foo') { |o| o.type :bit; o.array_size ['ARRAY_SIZE']; o.width 'WIDTH'; o.default 0 }).to match_declaration('param foo: bit<ARRAY_SIZE, WIDTH> = 0')
      end
    end

    context '定数の場合' do
      it '定数宣言を返す' do
        expect(const('foo') { |o| o.default 0 }).to match_declaration('const foo: logic = 0')
        expect(const('foo') { |o| o.type :bit; o.width 2; o.default 0 }).to match_declaration('const foo: bit<2> = 0')
        expect(const('foo') { |o| o.type :bit; o.width 'WIDTH'; o.default 0 }).to match_declaration('const foo: bit<WIDTH> = 0')

        expect(const('foo') { |o| o.type :bit; o.array_size [3]; o.default 0 }).to match_declaration('const foo: bit<3> = 0')
        expect(const('foo') { |o| o.type :bit; o.array_size [3]; o.width 2; o.default 0 }).to match_declaration('const foo: bit<3, 2> = 0')
        expect(const('foo') { |o| o.type :bit; o.array_size [3]; o.width 'WIDTH'; o.default 0 }).to match_declaration('const foo: bit<3, WIDTH> = 0')

        expect(const('foo') { |o| o.type :bit; o.array_size [4, 3]; o.default 0 }).to match_declaration('const foo: bit<4, 3> = 0')
        expect(const('foo') { |o| o.type :bit; o.array_size [4, 3]; o.width 2; o.default 0 }).to match_declaration('const foo: bit<4, 3, 2> = 0')
        expect(const('foo') { |o| o.type :bit; o.array_size [4, 3]; o.width 'WIDTH'; o.default 0 }).to match_declaration('const foo: bit<4, 3, WIDTH> = 0')

        expect(const('foo') { |o| o.type :bit; o.array_size ['ARRAY_SIZE']; o.default 0 }).to match_declaration('const foo: bit<ARRAY_SIZE> = 0')
        expect(const('foo') { |o| o.type :bit; o.array_size ['ARRAY_SIZE']; o.width 2; o.default 0 }).to match_declaration('const foo: bit<ARRAY_SIZE, 2> = 0')
        expect(const('foo') { |o| o.type :bit; o.array_size ['ARRAY_SIZE']; o.width 'WIDTH'; o.default 0 }).to match_declaration('const foo: bit<ARRAY_SIZE, WIDTH> = 0')
      end
    end
  end

  describe '#identifier' do
    it '自信の識別子を返す' do
      expect(data_object('foo')).to match_identifier('foo')
      expect(data_object('foo') {|o| o.width 2 }).to match_identifier('foo')
      expect(data_object('foo') {|o| o.width 2; o.array_size [2, 3] }).to match_identifier('foo')
      expect(data_object('foo') {|o| o.width 2; o.array_size [2, 3] }.identifier[[:i, :j]]).to match_identifier('foo[i][j]')
    end
  end
end
