pg-liquibase-update
================

Docker image to execute a liquibase update

The image uses liquibase 3.3.0 and postgres driver 9.3-1102-jdbc41

When run the container will execute a liquibase update of a specified changelog on a linked postgres container

The default behaviour will retry the update 4 times before exiting. The retry count can be set using the environment variable MAX_TRIES

#### Example use

```
docker run -id \
  --link=thePostgresContainer:postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=database \
  -e POSTGRES_HOST=postgres \
  -e POSTGRES_PORT=5432 \
  -e CHANGELOG_FILE=changelog.xml \
  -v /project/liquibase:/changelogs \
  --name liquibase \
  beresfordt/pg-liquibase-update
```

The volume (-v or --volume=) must mount the directory within which the changelog resides

The environment variables required are:

`POSTGRES_USER` - the user to the target database
`POSTGRES_PASSWORD` - password to the target database
`POSTGRES_DB` - the target database name
`POSTGRES_HOST` - the IP address of the target database
`POSTGRES_PORT` - the port postgres is running on
`CHANGELOG_FILE` - the name of the changelog file (absolute path, unless using `CHANGELOG_PWD`)

and optionally

`CHANGELOG_PWD` - sets the PWD for liquibase to run from
`MAX_TRIES` - default which defaults to 4 if not set
