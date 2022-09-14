# Camunda Community Helm
![Community Extension](https://img.shields.io/badge/Community%20Extension-An%20open%20source%20community%20maintained%20project-FF4700)
[![Lifecycle:Incubating](https://img.shields.io/badge/Lifecycle-Incubating-blue)](https://github.com/Camunda-Community-Hub/community/blob/main/extension-lifecycle.md#incubating-)
![Compatible with: Camunda Platform 7](https://img.shields.io/badge/Compatible%20with-Camunda%20Platform%207-26d07c)
[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/camunda)](https://artifacthub.io/packages/search?repo=camunda-community-hub)

Camunda public Kubernetes Helm repo and charts.

> **Note**
>
> This repo is a community effort for **Camunda Platform 7**, if you are looking for the brand new Camunda platform
> then go to the official [**Camunda Platform 8** Helm repo](https://github.com/camunda/camunda-platform-helm).

## Repository

```sh
$ helm repo add camunda https://helm.cch.camunda.cloud
$ helm repo update
```

## Charts

* [Camunda BPM Platform](./charts/camunda-bpm-platform)

## CI/CD

The CI/CD are done in GitHub Actions, and main actions are used:

* Testing charts via Helm [chart-testing-action](https://github.com/helm/chart-testing-action).
* Validating charts with different Kubernetes versions via [kind-action](https://github.com/helm/kind-action).
* Releasing charts via Helm [chart-releaser-action](https://github.com/helm/chart-releaser-action).

## Project status

Please note, this project still in under development, and could be there breaking changes but it will follow the SemVer convention.

## Contributing
We value all feedback and contributions. If you find any issues or want to contribute,
please feel free to [fill an issue](https://github.com/camunda-community-hub/camunda-helm/issues),
or [create a PR](https://github.com/camunda-community-hub/camunda-helm/pulls).

## License
This is open source software licensed using the Apache License 2.0. Please see [LICENSE](LICENSE) for details.
