# frozen_string_literal: true

RSpec.describe RgGen::Veryl::Utility::ModuleDefinition do
  include RgGen::Veryl::Utility

  let(:attributes) do
    { allow: :unused_variable, fmt: :skip }
  end

  let(:packages) do
    [:foo_pkg, :bar_pkg]
  end

  let(:generics) do
    foo =
      RgGen::Veryl::Utility::DataObject
        .new(:generic, name: :FOO, type: :proto_foo)
        .declaration
    bar =
      RgGen::Veryl::Utility::DataObject
        .new(:generic, name: :BAR, type: :const, default: 0)
        .declaration
    [foo, bar]
  end

  let(:params) do
    [:FOO, :BAR].map.with_index do |name, i|
      RgGen::Veryl::Utility::DataObject
        .new(:param, name: name, type: :u32, default: i)
        .declaration
    end
  end

  let(:ports) do
    [[:i_foo, :input], [:o_bar, :output]].map do |(name, direction)|
      RgGen::Veryl::Utility::DataObject
        .new(:port, name: name, direction: direction, type: :logic)
        .declaration
    end
  end

  let(:variables) do
    [:foo, :bar].map do |name|
      RgGen::Veryl::Utility::DataObject
        .new(:var, name: name, type: :logic)
        .declaration
    end
  end

  it 'モジュール定義を行うコードを返す' do
    expect(
      module_definition(:foo)
    ).to match_string(<<~'VERYL')
      pub module foo {
      }
    VERYL

    expect(
      module_definition(:foo) do |m|
        m.attributes attributes
      end
    ).to match_string(<<~'VERYL')
    #[allow(unused_variable)]
    #[fmt(skip)]
    pub module foo {
    }
    VERYL

    expect(
      module_definition(:foo) do |m|
        m.package_imports packages
      end
    ).to match_string(<<~'VERYL')
      pub module foo {
        import foo_pkg::*;
        import bar_pkg::*;
      }
    VERYL

    expect(
      module_definition(:foo) do |m|
        m.generics generics
      end
    ).to match_string(<<~'VERYL')
      pub module foo::<
        FOO: proto_foo,
        BAR: const = 0
      >{
      }
    VERYL

    expect(
      module_definition(:foo) do |m|
        m.params params
      end
    ).to match_string(<<~'VERYL')
      pub module foo #(
        param FOO: u32 = 0,
        param BAR: u32 = 1
      ){
      }
    VERYL

    expect(
      module_definition(:foo) do |m|
        m.ports ports
      end
    ).to match_string(<<~'VERYL')
      pub module foo (
        i_foo: input logic,
        o_bar: output logic
      ){
      }
    VERYL

    expect(
      module_definition(:foo) do |m|
        m.variables variables
      end
    ).to match_string(<<~'VERYL')
      pub module foo {
        var foo: logic;
        var bar: logic;
      }
    VERYL

    expect(
      module_definition(:foo) do |m|
        m.body { 'assign foo = 0;' }
        m.body { |code| code << 'assign bar = 1;' }
      end
    ).to match_string(<<~'VERYL')
      pub module foo {
        assign foo = 0;
        assign bar = 1;
      }
    VERYL

    expect(
      module_definition(:foo) do |m|
        m.attributes attributes
        m.package_imports packages
        m.generics generics
        m.params params
        m.ports ports
        m.variables variables
        m.body { 'assign foo = 0;' }
        m.body { |code| code << 'assign bar = 1;' }
      end
    ).to match_string(<<~'VERYL')
      #[allow(unused_variable)]
      #[fmt(skip)]
      pub module foo::<
        FOO: proto_foo,
        BAR: const = 0
      >#(
        param FOO: u32 = 0,
        param BAR: u32 = 1
      )(
        i_foo: input logic,
        o_bar: output logic
      ){
        import foo_pkg::*;
        import bar_pkg::*;
        var foo: logic;
        var bar: logic;
        assign foo = 0;
        assign bar = 1;
      }
    VERYL
  end
end
