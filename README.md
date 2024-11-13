[![CI](https://github.com/rggen/rggen-veryl/actions/workflows/ci.yml/badge.svg)](https://github.com/rggen/rggen-veryl/actions/workflows/ci.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/679372a22641b5de9a7a/maintainability)](https://codeclimate.com/github/rggen/rggen-veryl/maintainability)
[![codecov](https://codecov.io/gh/rggen/rggen-veryl/graph/badge.svg?token=iYlaqhSjat)](https://codecov.io/gh/rggen/rggen-veryl)

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

## Contact

Feedbacks, bus reports, questions and etc. are welcome! You can post them bu using following ways:

* [GitHub Issue Tracker](https://github.com/rggen/rggen/issues)
* [GitHub Discussions](https://github.com/rggen/rggen/discussions)
* [Chat Room](https://gitter.im/rggen/rggen)
* [Mailing List](https://groups.google.com/d/forum/rggen)
* [Mail](mailto:rggen@googlegroups.com)

## Copyright & License

Copyright &copy; 2024 Taichi Ishitani. RgGen::Veryl is licensed under the [MIT License](https://opensource.org/licenses/MIT), see [LICENSE](LICENSE) for futher details.

## Code of Conduct

Everyone interacting in the RgGen::Veryl project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rggen-veryl/blob/master/CODE_OF_CONDUCT.md).
