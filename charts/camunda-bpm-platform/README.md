# Camunda BPM Platform Helm Chart
![Community Extension](https://img.shields.io/badge/Community%20Extension-An%20open%20source%20community%20maintained%20project-FF4700) [![Lifecycle: Incubating](https://img.shields.io/badge/Lifecycle-Incubating-blue)](https://github.com/Camunda-Community-Hub/community/blob/main/extension-lifecycle.md#incubating-) [![Camunda BPM Platform](https://img.shields.io/badge/dynamic/yaml?label=Camunda%20BPM%20Platform&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fcamunda-community-hub%2Fcamunda-helm%2Fmain%2Fcharts%2Fcamunda-bpm-platform%2FChart.yaml?style=plastic&logo=artifacthub&logoColor=white&labelColor=417598&color=2D4857)](https://artifacthub.io/packages/helm/camunda/camunda-bpm-platform)

A Helm chart for Camunda BPM Platform, the open-source BPM platform.

## Install

```sh
$ helm repo add camunda https://helm.camunda.cloud
$ helm repo update
$ helm install demo camunda/camunda-bpm-platform
```

## Links

* Camunda homepage: https://camunda.com
* Camunda BPM Platform repo: https://github.com/camunda/camunda-bpm-platform
* Camunda BPM Platform Docker image: https://github.com/camunda/docker-camunda-bpm-platform

## Example

Using this custom values file the chart will:
* Use a custom name for deployment.
* Deploy 3 instances of [Camunda Platform Run](https://docs.camunda.org/manual/latest/user-guide/camunda-bpm-run/)
  with `REST API` only enabled (that means no `Webapps` nor `Swagger UI` will be enabled).
* Use PostgreSQL as an external database (it assumes that the database `process-engine` is already created
  and the secret `camunda-bpm-platform-postgresql-credentials` has the mandatory data `DB_USERNAME` and `DB_PASSWORD`).
* Set custom config for `readinessProbe` and checking an endpoint that queries the database
  so no traffic will be sent to the REST API if the engine pod is not able to access the database.
* Expose Prometheus metrics of the Camunda Platform over the metrics service with port `9404`.

```yaml
# Custom values.yaml

general:
  fullnameOverride: camunda-bpm-platform-rest
  replicaCount: 3

image:
  name: camunda/camunda-bpm-platform
  tag: run-latest
  command: ['./camunda.sh']
  args: ['--rest']

extraEnvs:
- name: DB_VALIDATE_ON_BORROW
  value: "false"

database:
  driver: org.postgresql.Driver
  url: jdbc:postgresql://camunda-bpm-platform-postgresql:5432/process-engine
  credentialsSecretName: camunda-bpm-platform-postgresql-credentials

service:
  type: ClusterIP
  port: 8080
  portName: http

readinessProbe:
  enabled: true
  config:
    httpGet:
      path: /engine-rest/incident/count
      port: http
    initialDelaySeconds: 120
    periodSeconds: 60

metrics:
  enabled: true
  service:
    type: ClusterIP
    port: 9404
    portName: metrics
    annotations:
      prometheus.io/scrape: "true"
      prometheus.io/path: "/"
      prometheus.io/port: "9404"
```

## Configuration

### General

#### Replicas
Set the number of replicas:
```yaml
general:
  replicaCount: 1
```
**Please note**, Camunda BPM Platform cluster mode is not supported with the default database H2,
and an external database should be used if you want to increase the number of the replicas.

#### Extra environment variables

The deployment could be customized by providing extra environment variables according to the project
[Docker image](https://github.com/camunda/docker-camunda-bpm-platform). The extra environment variables will be templated using the ['tpl' function](https://helm.sh/docs/howto/charts_tips_and_tricks/#using-the-tpl-function). This is useful to pass a template string as a value to a chart or render external configuration files.

```yaml
extraEnvs:
- name: DB_VALIDATE_ON_BORROW
  value: "false"
- name: SERVICE_PORT
  value: {{ .Values.service.port }}
```

#### Debugging
Enable debugging in the Camunda BPM Platform container by setting:
```yaml
general:
  debug: true
```

### Init Containers

For a reason or another, you could need to do some pre-startup actions before the start of the Camunda BPM Platform.
e.g. you could wait for a specific service to be ready or to post to an external service.

If that's needed, it could be done as the following:

```yaml
initContainers:
- name: pre-startup-checks
  image: busybox:1.28
  command: ['sh', '-c', 'echo "The initContainers work as expected"']
```

### Image

Camunda BPM Platform open-source Docker image comes in 3 distributions `tomcat`, `wildfly`, and `run`.
Each distro has different tags, check the list of
[supported tags/releases](https://github.com/camunda/docker-camunda-bpm-platform#supported-tagsreleases)
by Camunda BPM Platform docker project for more details.

The image used in the chart is `latest` (which's actually `tomcat-latest`).

### Database

One of the [supported databases](https://docs.camunda.org/manual/latest/introduction/supported-environments/#databases)
could be used as a database for Camunda BPM Platform.

The H2 database is used by default which works fine if you just want to test Camunda BPM Platform.
But since the database is embedded, only 1 deployment replica could be used.

For real-world workloads, an external database like PostgreSQL should be used.
The following is an example of using PostgreSQL as an external database.

First, assuming that you have a PostgreSQL system up and running with service and port
`camunda-bpm-platform-postgresql:5432`, also the database `process-engine` is created and you have its credentials,
create a secret has database credentials which will be used later by Camunda BPM Platform deployment:

```sh
$ kubectl create secret generic                 \
    camunda-bpm-platform-postgresql-credentials \
    --from-literal=DB_USERNAME=foo              \
    --from-literal=DB_PASSWORD=bar
```

Now, set the values to use the external database:

```yaml
database:
  driver: org.postgresql.Driver
  url: jdbc:postgresql://camunda-bpm-platform-postgresql:5432/process-engine
  credentialsSecretName: camunda-bpm-platform-postgresql-credentials
  # The username and password keys could be customized to whatever used in the credentials secret.
  credentialsSecretKeys:
    username: DB_USERNAME
    password: DB_PASSWORD
```

**Please note**, this Helm chart doesn't manage any external database, it just uses what's configured.

### Metrics

Enable Prometheus metrics for Camunda BPM Platform by setting the following in the values file:

```yaml
metrics:
  enabled: true
  service:
    type: ClusterIP
    port: 9404
    portName: metrics
    annotations:
      prometheus.io/scrape: "true"
      prometheus.io/path: "/"
      prometheus.io/port: "9404"
```

If there is a Prometheus configured in the cluster, it will scrap the metrics service automatically.
Check the notes after the deployment for more details about the metrics endpoint.
