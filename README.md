# Templates for EYK Applications

The master branch is a simple web app using a sqlite3 database.
This can be used as a starter template.
Be sure to do the following before deploying:
```
bin/rails credentials:edit
```
Take the value from the generated config/master.key and use it as follows:
```
eyk config:set RAILS_MASTER_KEY=<value>
eyk config:set DEIS_DOCKER_BUILD_ARGS_ENABLED=1
```
Also set the values in your development window as follows:
```
export RAILS_MASTER_KEY=<value>
export DEIS_DOCKER_BUILD_ARGS_ENABLED=1
```

