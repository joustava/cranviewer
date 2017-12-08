# Cranviewer

> [CRAN](https://cran.r-project.org/) package viewer in Ruby/Rails
> made with:
>   Ruby version => 2.4.1
>   Rails version => 5.1.4

* Configuration

  (http://cran.r-project.org)
  CRAN_MIRROR=https://ftp.gwdg.de/pub/misc/cran
  CRAN_ARCHIVES=/src/contrib/
  CRAN_LISTING=PACKAGES

* Database creation

  $ bundle exec rake db:create

* Database initialisation

  $ bundle exec rake db:migrate

* Specs

  $ bundle exec rspec

* Workers

  Sheduled to run once a day. Imports PACKAGE descriptions by running a job for each new
  package. see ./Procfile for details.

* Deployment instructions (Heroku)

  Install the Heroku Toolbelt `$ brew install heroku/brew/heroku`
  Make sure you're logged in `heroku login`

  First time deployment steps `heroku create && git push heroku deploy:master && heroku run rake db:migrate && heroku addons:create scheduler:standard`
  heroku ps:scale web=1 worker=5

  Deploy with `$ git push heroku deploy:master`.
  Initial import of CRAN packages `heroku run cran:import`.


## Todo

- [ ] Benchmarking/Performance
- [ ] Cleanup
- [ ] Search
- [ ] Pagination
- [ ] Logging
- [ ] Monitoring

## Extra

* [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-devel/R-exts.html)
* [ActiveJob](http://edgeguides.rubyonrails.org/active_job_basics.html)
* [Que](https://github.com/chanks/que)
* [Benchmarking](http://guides.rubyonrails.org/v3.2.13/performance_testing.html)

* Simple Cron job (alternative for non Heroku environment)

  [Whenever](https://github.com/javan/whenever) can used for dealing with the task scheduling. To install and update the actual cronjob run:

  $ bundle exec whenever --update-crontab

  The scheduling configuration can be found in 'config/schedule.rb'

  $ bundle exec whenever

  Will show the actual cron configuration that would be installed.
