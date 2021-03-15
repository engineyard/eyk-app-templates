# Templates for EYK Applications

The webapp-with-jobs branch shows how you can use Cronenberg
to run scheduled operating system level processes within
your container.

See the article https://www.devgraph.com/2021/03/15/running-background-jobs-in-ruby-on-rails-containers/
for more details on how to use Cronenberg in your container.

Note that the Procfile has a second entry
```
cronenberg: cronenberg ./config/cron-jobs.yml
```
Be aware that when you deploy an application with more than
one entry in the Procfile, EYK will set the scale to any
non-web process types to zero by default. Thus, to start
your Sidekiq process, run the following command:
```
eyk ps:scale cronenberg=1
```

