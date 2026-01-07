[![Gem Version](https://badge.fury.io/rb/rggen-veryl.svg)](https://badge.fury.io/rb/rggen-veryl)
[![CI](https://github.com/rggen/rggen-veryl/actions/workflows/ci.yml/badge.svg)](https://github.com/rggen/rggen-veryl/actions/workflows/ci.yml)
[![Maintainability](https://qlty.sh/badges/7537364e-4631-4c9a-b873-5bceb9418ed0/maintainability.svg)](https://qlty.sh/gh/rggen/projects/rggen-veryl)
[![codecov](https://codecov.io/gh/rggen/rggen-veryl/graph/badge.svg?token=iYlaqhSjat)](https://codecov.io/gh/rggen/rggen-veryl)
[![Discord](https://img.shields.io/discord/1406572699467124806?style=flat&logo=discord)](https://discord.com/invite/KWya83ZZxr)

# RgGen::Veryl

RgGen::Veryl is a RgGen plugin to generate RTL code written in [Veryl](https://veryl-lang.org).

## Installation

To install RgGen::Veryl, use the following command:

```
$ gem install rggen-veryl
```

## Usage

You need to tell RgGen to load RgGen::Veryl plugin. There are two ways.

### Uisng `--plugin` runtime option

```
$ rggen --plugin rggen-veryl your_register_map.yml
```

### Using `RGGEN_PLUGINS` environment variable

```
$ export RGGEN_PLUGINS=${RGGEN_PLUGINS}:rggen-veryl
$ rggen your_register_map.yml
```

## Using Generated RTL

Generated RTL files are constructed by using common Veryl modules maintained in the repository below.

https://github.com/rggen/rggen-veryl-rtl

You need to add this repository to the `[dependencies]` section in your `Veryl.toml` file. For example:

```toml
[dependencies]
"rggen" = { github = "rggen/rggen-veryl-rtl", version = "0.6.0" }
```

## Contact

Feedbacks, bus reports, questions and etc. are welcome! You can post them by using following ways:

* [GitHub Issue Tracker](https://github.com/rggen/rggen/issues)
* [GitHub Discussions](https://github.com/rggen/rggen/discussions)
* [Discord](https://discord.com/invite/KWya83ZZxr)
* [Mailing List](https://groups.google.com/d/forum/rggen)
* [Mail](mailto:rggen@googlegroups.com)

## Copyright & License

Copyright &copy; 2024-2026 Taichi Ishitani. RgGen::Veryl is licensed under the [MIT License](https://opensource.org/licenses/MIT), see [LICENSE](LICENSE) for futher details.

## Code of Conduct

Everyone interacting in the RgGen::Veryl project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rggen/rggen-veryl/blob/master/CODE_OF_CONDUCT.md).
