# frozen_string_literal: true

RSpec.describe RgGen::Veryl::Utility::LocalScope do
  include RgGen::Veryl::Utility

  let(:consts) do
    [:BAR, :BAZ].map do |name|
      RgGen::Veryl::Utility::DataObject
        .new(:const, name: name, type: :bit, default: 0)
        .declaration
    end
  end

  let(:variables) do
    [:bar, :baz].map do |name|
      RgGen::Veryl::Utility::DataObject
        .new(:var, name: name)
        .declaration
    end
  end

  let(:loop_size) do
    { i: 1, j: 2, k: 3 }
  end

  it 'ローカルスコープを定義するコードを返す' do
    expect(
      local_scope(:foo)
    ).to match_string(<<~'VERYL')
      :foo {
      }
    VERYL

    expect(
      local_scope(:foo) do |s|
        s.consts consts
      end
    ).to match_string(<<~'VERYL')
      :foo {
        const BAR: bit = 0;
        const BAZ: bit = 0;
      }
    VERYL

    expect(
      local_scope(:foo) do |s|
        s.variables variables
      end
    ).to match_string(<<~'VERYL')
      :foo {
        var bar: logic;
        var baz: logic;
      }
    VERYL

    expect(
      local_scope(:foo) do |s|
        s.loop_size loop_size
      end
    ).to match_string(<<~'VERYL')
      :foo {
        for i in 0..1 :g {
          for j in 0..2 :g {
            for k in 0..3 :g {
            }
          }
        }
      }
    VERYL

    expect(
      local_scope(:foo) do |s|
        s.body { 'assign bar = 1;' }
        s.body { |c| c << 'assign baz = 2;' }
      end
    ).to match_string(<<~'VERYL')
      :foo {
        assign bar = 1;
        assign baz = 2;
      }
    VERYL

    expect(
      local_scope(:foo) do |s|
        s.body { 'assign bar = 1;' }
        s.body { |c| c << 'assign baz = 2;' }
        s.loop_size loop_size
        s.variables variables
        s.consts consts
      end
    ).to match_string(<<~'VERYL')
      :foo {
        for i in 0..1 :g {
          for j in 0..2 :g {
            for k in 0..3 :g {
              const BAR: bit = 0;
              const BAZ: bit = 0;
              var bar: logic;
              var baz: logic;
              assign bar = 1;
              assign baz = 2;
            }
          }
        }
      }
    VERYL
  end
end
