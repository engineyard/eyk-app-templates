# Templates for EYK Applications

The webapp-with-jobs branch shows how you can use Sidekiq
to run on-demand or scheduled asynchronous processes.

See the article https://www.devgraph.com/2021/03/15/running-background-jobs-in-ruby-on-rails-containers/
for more details on how to use Sidekiq with the Rails
ActiveJob mechanism.

Note that the Procfile has a second entry
```
sidekiq: bundle exec sidekiq
```
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

