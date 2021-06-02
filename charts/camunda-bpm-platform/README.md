# Camunda BPM Platform Helm Chart

A Helm chart for Camunda BPM, the open-source BPM platform.

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

## Configuration

### Image

Camunda BPM open-source Docker image comes in 3 distributions `tomcat` , `wildfly` , and `run` .
Each distro has different tags, check the list of [supported tags/releases](https://github.com/camunda/docker-camunda-bpm-platform#supported-tagsreleases) by the docker project for more details.

The image used in the chart is `latest` (which's actually `tomcat-latest` ).

### Database

Camunda BPM has 2 options in terms of databases.

#### Internal database

The H2 database is used by default which works fine if you just want to test Camunda BPM Platform.
But since the database is embedded, only 1 deployment replica could be used.

#### External database

Databases like PostgreSQL or MySQL could be used also which is the same as in production.

You have the option to use a managed instanse of whether PostgreSQL or MySQL in your Camunda BPM installation.

The chart integrates with corresponding subcharts which installs appropriate databases. The boolean variables `tags.managed-postgresql` and `tags.managed-mysql` gives you the option to choose the RDMS you prefer. By default, neither databases are installed.

```shell
# postgresql + camunda
helm install camunda camunda-bpm-platform --set tags.managed-postgresql=true

# mysql + camunda
helm install camunda camunda-bpm-platform --set tags.managed-mysql=true
```

The chart parameters will align according to the chosen managed database, e.g. driver, connection URL and auth data. Also, the special secret will be created to store authentication info for Camunda BPM to access the DB.

> Warning: deployments of Camunda BPM and PostgreSQL/MySQL are not syncronized. Therefore, Camunda BPM can fails several times until the RDMS is becomes ready.

> Warning: you have an option to use only one managed DB. You cannot combine woth `tags.managed-postgresql` and `tags.managed-mysql` . If you do so, the chart installation will fail due to values constrains:

```shell
# will fail
helm install camunda camunda-bpm-platform --set tags.managed-postgresql=true,tags.managed.mysql=true

```

Otherwise, you may use an external database, but without an managed database. In this case, do not specify `tags.managed-*` paramenters and you should create the secret by yourself.

Here is an example to use PostgreSQL as an external database, without any managed installation.

First, create the secret that has the database credentials.

```sh
$ kubectl create secret generic                 \
    camunda-bpm-platform-postgresql-credentials \
    --from-literal=DB_USERNAME=foo              \
    --from-literal=DB_PASSWORD=bar
```

Then set the values to use the external database:

```yaml
database:
  internal:
    enabled: false
  external:
    enabled: true
    credentialsSecretName: camunda-bpm-platform-postgresql-credentials
    driver: "org.postgresql.Driver"
    url: "jdbc:postgresql://cambpm-demo-db:5432/process-engine"
```

### Metrics

To get Prometheus metrics for Camunda BPM, it could be enabled in values file using:

```yaml
metrics:
  enabled: true
```

If there is Prometheus is setup it will scrap the metrics service automatically.

### Misc

* Debugging in the Camunda BPM container could be enabled by setting `general.debug: true`.
