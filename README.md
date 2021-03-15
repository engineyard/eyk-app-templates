# Templates for EYK Applications

This project provides templates that are starting points for Rails applications.
Choose the branch that most closely meets your requirements and use that to quickly
get started developing and deploying Rails applications on EYK.

## webapp branch
This is the basis for all the branches. It is a simple instant poll web application
that uses a sqlite database in development and a MySQL database in production.

## webapp-with-cron
The webapp branch plus the setup to run "cron jobs" using Cronenberg. 
This is a container-friendly implementation that is easy to use.
You can quickly start running your scheduled operating system processes
using this template.

## webapp-with-jobs
The webapp branch plus the setup to run Sidekiq jobs that leverage
your Rails application components. You can run asynchronous processes
either on-demand or on a scheduled basis.
