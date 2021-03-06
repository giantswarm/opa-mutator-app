# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.4.0] - 2020-11-19

### Changed

- Remove awscluster rules
- Use cert-manager v1 API

## [1.3.0] - 2020-10-29

### Removed

- Move all validating and defaulting rules except for pre-HA `awscluster` CRs to `aws-admission-controller`

## [1.2.0] - 2020-08-25

### Added

- Add changelog.
- Add NetworkPoliucy and PodSecurityPolicy.


[Unreleased]: https://github.com/giantswarm/opa-mutator-app/compare/v1.4.0...HEAD
[1.4.0]: https://github.com/giantswarm/opa-mutator-app/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/giantswarm/opa-mutator-app/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/giantswarm/opa-mutator-app/compare/v1.1.0...v1.2.0
