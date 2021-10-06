**NOTE:** This file contains the changelogs with the old format. The CHANGELOG.md is generated automatically and follows [Keep a Changelog](https://keepachangelog.com) format.

# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## 1.0.0 (2021-07-17)


### ⚠ BREAKING CHANGES

* H2 anti-pattern has been fixed and now all databases has the same way to config. This will break the previous version of the chart, and the "database" values should be updated to the new syntax.

### Features

* add customizable readiness/liveness probes ([88b6e6f](https://github.com/camunda-community-hub/camunda-helm/commit/88b6e6f3ab1001999920fb6ccf79e0f00e829381))
* allow to customize image command and args ([cd9500b](https://github.com/camunda-community-hub/camunda-helm/commit/cd9500b39dbb70abc7c4213f15816ed348cc0df1))
* **charts:** first version of camunda-bpm-platform chart ([f38caf2](https://github.com/camunda-community-hub/camunda-helm/commit/f38caf20a8caf6cdf3935e9b08b9fc9052ccfb92))
* enable fsGroup by defult ([11e967d](https://github.com/camunda-community-hub/camunda-helm/commit/11e967dae43cb918d5638a954f370b4e0eb863ab))


### Bug Fixes

* add ingress path ([f30f499](https://github.com/camunda-community-hub/camunda-helm/commit/f30f499fa12b8aa6f9bac82a9dbe71d904901ef7))


### Refactor

* unify databases access ([f4ca61f](https://github.com/camunda-community-hub/camunda-helm/commit/f4ca61f8be39faed83bc0433ff14dd5378f265dc))


### Docs

* add example of custom values.yaml ([3add1b1](https://github.com/camunda-community-hub/camunda-helm/commit/3add1b125509f7fcbf826f1021d4b5e099c54aa8))
* remove generated markdown toc ([7a9be7a](https://github.com/camunda-community-hub/camunda-helm/commit/7a9be7a443aac5e0f66e54281325119bd4d5d958))


### Chore

* bump camunda-bpm-platform chart version to 1.0.0 ([a62b473](https://github.com/camunda-community-hub/camunda-helm/commit/a62b473d066d39711c24d6efa13c10e1411bbd02))
* tidy up NOTES.txt file ([841c41b](https://github.com/camunda-community-hub/camunda-helm/commit/841c41baf16ab9bb8b7d47c79b0353dbb4c67c7f))
* unify the project name ([c1c2bf3](https://github.com/camunda-community-hub/camunda-helm/commit/c1c2bf3498705bad89484b5f7a6e54af5c307698))
* use latest as version for camunda-bpm-platform image ([50776d6](https://github.com/camunda-community-hub/camunda-helm/commit/50776d6b1df37ca45b7b5d5c2a6a17b652fd886c))
