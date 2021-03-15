# Templates for EYK Applications

The webapp branch is a simple web app that implements an instant poll.
It uses a sqlite3 database in development and a MySQL database in production.
This project can be used as a starter template for your EYK project.

## Managing Secrets: Database Credentials and the Rails Master Key
Be sure to do the following before deploying:
```
bin/rails credentials:edit
```
Take the key value from the generated config/master.key and use it as follows:
```
eyk config:set RAILS_MASTER_KEY=<value>
eyk config:set DEIS_DOCKER_BUILD_ARGS_ENABLED=1
```
Note that your .gitignore should prevent you from checking in the config/master.key
Also set the key value in your development environment as follows (i.e. for bash):
```
export RAILS_MASTER_KEY=<value>
export DEIS_DOCKER_BUILD_ARGS_ENABLED=1
```

## Database Setup and Migrations
Once you have deployed the application, you can migrate the database and load the seed data using the following commands:
```
eyk apps:run 'bin/rails db:migrate RAILS_ENV=production'
eyk apps:run 'bin/rails db:seed RAILS_ENV=production'
```

If you want a way to easily manage the RDS MySQL database in your cluster, you can use one of the following projects:
1. https://github.com/engineyard/eyk-mysql-client
2. https://github.com/engineyard/mysql-admin

The config/database.yml file uses the following environment variables to connect to 
the database. You can use the EYK application config mechanism to set these variables.
```
eyk config:set db_yml_username=quizuser
eyk config:set db_yml_password=<your-password>
eyk config:set db_yml_host=your.host.rds.amazonaws.com
eyk config:set db_yml_database=quizdb
```
A few Rails specific environment variables should also be set.
```
eyk config:set RAILS_ENV=production
eyk config:set RAILS_SERVE_STATIC_FILES=true
```

