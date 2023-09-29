The changelog is automatically generated using [git-chglog](https://github.com/git-chglog/git-chglog) and it follows [Keep a Changelog](https://keepachangelog.com) format.

<a name="camunda-bpm-platform-7.6.7"></a>
## [camunda-bpm-platform-7.6.7] - 2023-09-29

<a name="camunda-bpm-platform-7.6.6"></a>
## [camunda-bpm-platform-7.6.6] - 2023-08-15

<a name="camunda-bpm-platform-7.6.5"></a>
## [camunda-bpm-platform-7.6.5] - 2023-08-10

<a name="camunda-bpm-platform-7.6.4"></a>
## [camunda-bpm-platform-7.6.4] - 2023-06-08

<a name="camunda-bpm-platform-7.6.3"></a>
## [camunda-bpm-platform-7.6.3] - 2023-06-07
### Fixed
- Fixed template for ingress apiVersion networking.k8s.io/v1

<a name="camunda-bpm-platform-7.6.2"></a>
## [camunda-bpm-platform-7.6.2] - 2023-05-10
### Added
- Added support for specifying test annotations ([#56](https://github.com/camunda-community-hub/camunda-helm/issues/56))

<a name="camunda-bpm-platform-7.6.1"></a>
## [camunda-bpm-platform-7.6.1] - 2022-08-03
### Changed
- Changed and unified chart name and updated helm repo url

<a name="camunda-bpm-platform-7.6.0"></a>
## [camunda-bpm-platform-7.6.0] - 2022-07-11
### Changed
- Changed camunda-bpm-platform chart to use v7 as a base version

<a name="camunda-bpm-platform-1.6.0"></a>
## [camunda-bpm-platform-1.6.0] - 2022-07-10
### Added
- Added extraContainers and additional customizations ([#47](https://github.com/camunda-community-hub/camunda-helm/issues/47))

<a name="camunda-bpm-platform-1.5.0"></a>
## [camunda-bpm-platform-1.5.0] - 2022-03-13
### Added
- Added support for optional deployment annotations ([#38](https://github.com/camunda-community-hub/camunda-helm/issues/38))
- Added better support for svc NodePort and LoadBalancer
- Added option to force pod recreation
- Added service annotations

<a name="camunda-bpm-platform-1.4.0"></a>
## [camunda-bpm-platform-1.4.0] - 2021-12-11
### Added
- Added option to add deployment extra volumes
- Added option to template extraEnvs with helm tpl function
### Fixed
- Fixed deployment args where all args were treated as a single arg

<a name="camunda-bpm-platform-1.3.0"></a>
## [camunda-bpm-platform-1.3.0] - 2021-10-08
### Added
- Added startup probe (disabled by default)
- Added an option to set deployment initContainers

<a name="camunda-bpm-platform-1.2.0"></a>
## [camunda-bpm-platform-1.2.0] - 2021-10-08
### Added
- Added option to customize database credentials secret keys

<a name="camunda-bpm-platform-1.1.0"></a>
## [camunda-bpm-platform-1.1.0] - 2021-10-06

<a name="camunda-bpm-platform-v1.1.0"></a>
## [camunda-bpm-platform-v1.1.0] - 2021-09-22

<a name="camunda-bpm-platform-v1.0.0"></a>
## [camunda-bpm-platform-v1.0.0] - 2021-07-17

<a name="camunda-bpm-platform-0.1.0"></a>
## camunda-bpm-platform-0.1.0 - 2020-11-12

[camunda-bpm-platform-7.6.7]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-7.6.6...camunda-bpm-platform-7.6.7
[camunda-bpm-platform-7.6.6]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-7.6.5...camunda-bpm-platform-7.6.6
[camunda-bpm-platform-7.6.5]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-7.6.4...camunda-bpm-platform-7.6.5
[camunda-bpm-platform-7.6.4]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-7.6.3...camunda-bpm-platform-7.6.4
[camunda-bpm-platform-7.6.3]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-7.6.2...camunda-bpm-platform-7.6.3
[camunda-bpm-platform-7.6.2]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-7.6.1...camunda-bpm-platform-7.6.2
[camunda-bpm-platform-7.6.1]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-7.6.0...camunda-bpm-platform-7.6.1
[camunda-bpm-platform-7.6.0]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-1.6.0...camunda-bpm-platform-7.6.0
[camunda-bpm-platform-1.6.0]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-1.5.0...camunda-bpm-platform-1.6.0
[camunda-bpm-platform-1.5.0]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-1.4.0...camunda-bpm-platform-1.5.0
[camunda-bpm-platform-1.4.0]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-1.3.0...camunda-bpm-platform-1.4.0
[camunda-bpm-platform-1.3.0]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-1.2.0...camunda-bpm-platform-1.3.0
[camunda-bpm-platform-1.2.0]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-1.1.0...camunda-bpm-platform-1.2.0
[camunda-bpm-platform-1.1.0]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-v1.1.0...camunda-bpm-platform-1.1.0
[camunda-bpm-platform-v1.1.0]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-v1.0.0...camunda-bpm-platform-v1.1.0
[camunda-bpm-platform-v1.0.0]: https://github.com/camunda-community-hub/camunda-helm/compare/camunda-bpm-platform-0.1.0...camunda-bpm-platform-v1.0.0
