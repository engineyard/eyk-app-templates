# EYK Application Templates

## Simple Feature Release Process
Releasing new features is a breeze with the ahoy, 
blazer, and the rollout gems. They allow you to 
control the release of new features and easily
monitor how customers are using them.

## Develop in the same container image as production
No more "works on my machine".
Consistent, reliable one-click deployments with Engine Yard Kontainers.

## Simply git push eyk to deploy
Deployment has never been faster or easier. To deploy your code to 
containers, run the following command:

```
git push eyk <branch-name>
```

## Processes flexibly scale automatically
Define each process in your Procfile. This project has two
processes defined, the web application and the Sidekiq process.

```
web: bundle exec rails server -b 0.0.0.0 -p 5000
sidekiq: bundle exec sidekiq
```

## Sidekiq for Background Jobs
Sidekiq is configured for background jobs. See the article
[Running Background Jobs in Rails](https://www.devgraph.com/2021/03/15/running-background-jobs-in-ruby-on-rails-containers/)
for more details on how to use Sidekiq with the Rails
ActiveJob mechanism.

Be aware that when you deploy an application with more than
one entry in the Procfile, EYK will set the scale to any
non-web process types to zero by default. Thus, to start
your Sidekiq process, run the following command:
```
eyk ps:scale sidekiq=1
```
You will also need to configure the REDIS url so that
Sidekiq can connect. The easiest way to do this is to
use an application config environment variable.
You can se this using the following command:
```
eyk config:set REDIS_URL=redis://my.host.name:6379
```

