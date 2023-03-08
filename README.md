# WIP Rails 4.2 Docker Example

This is a test project as a first step to adding docker for a monolithic old
rails app. Start simple :)

Web links - for when the project is working

* [Admin](/admin)
* [Sidekiq](/sidekiq)

## Quick start

Prerequisites:

* you have a working postgres setup 
* you have a working redis setup
* you have docker-desktop
* `git clone https://github.com/wiseleyb/rei-rails42-ruby26-docker`
* `cd rei-rails42-ruby26-docker`
* Create a key=value `.env` file with (replace un/pw). You can get the un/pw
   for BUNDLE_ENTERPRISE from Ben/Michael

```
BUNDLE_ENTERPRISE_CONTRIBSYS_COM=un:pw
```
* In .rbenv-vars put non-build specific ENVs

```
DATABASE_URL=postgresql://un:pw@host.docker.internal/rails_4_docker
REDIS_URL=redis://host.docker.internal:6379
```

* Create some alias'

```
alias dccomp='docker-compose'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias dcbuild='docker-compose build'
alias dccon='docker-compose web bundle exec rails c'
alias dcrails='docker-compose run web bundle exec rails'
alias dcrake='docker-compose run web bundle exec rake'
```

* `dcbuild` - this will take a long time - like 20 minutes
* `dcrake db:create`
* `dcrake db:migrate`
* `dcup`
* Go to `localhost:3000` and see this read me file and links to admin/sidekiq

## Simple Docker example for:

* Docker-desktop 4.17.0
* Rails 4.2.11.3
* Ruby 2.6.6
* Postgres 
* PG Gem 0.20.0
* Redis
* Sidekiq 4.1.4
* Copy updated Gemfile.lock 
* TODO: ElasticSearch

### Redis

Test in console:

```
RedisHelper.set('bob', 'jim')
puts RedisHelper.get('bob')
>> 'jim'
```

### Sidekiq

Test in console:

````Ruby
TestJob.perform_async("test #{Time.now.to_f}")
sleep 3
RedisHelper.get('testjob') # should return thekey above
````

## Required

This assumes you are connecting to an external db, redis, elastic-search

* install postgres (TODO: best was to do this - postico, etc)
* install redis
  * `brew install redis`
  * `brew services start redis`
  * `redis-cli`
  * `> set 'bob' 'jim'`
  * `> get 'bob'`
  * `> jim`
  * `> quit`
* install elastic-search (TODO: best way to do this)

## ignored files required

* `.env` - key/value file (see quick start above)

## ENV

This uses `.rbenv-vars` but you can set things in your bash/alias file as well

* `DATABASE_URL`: format should be 
  postgresql://username:password@localhost/database_name 
  This override config/database.yml
* `REDIS_URl`: redis://host.docker.internal:6379

NOTE on DATABASE_URL: if your username/password/database_name contains non
a-Z0-9 characters you need to url encoded it. So if your password is bob!jones
it's be bob%21jones. You can use this site to url encode strings
https://www.w3schools.com/tags/ref_urlencode.ASP

## Bash helpers

```
alias dccomp='docker-compose'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias dcbuild='docker-compose build'
alias dccon='docker-compose web bundle exec rails c'
alias dcrails='docker-compose run web bundle exec rails'
alias dcrake='docker-compose run web bundle exec rake'
```

TODO: Figure out better way to do this.
Copy Gemfile.lock changes during docker build back to local file system (to put in source control).

```
touch Gemfile.lock && \
  docker-compose build && \
  docker cp rei-rails42-ruby26-docker-web-1:/app/Gemfile.lock Gemfile.lock
```

### Gemfile.lock

When you update the Gemfile, then run docker, it updates the Gemfile.lock - but
only on the docker container. You should store this in git. There's probably a
better way to do this but - I've been doing this to grab the updated
Gemfile.lock file

```
touch Gemfile.lock && \
  docker-compose build && \
  docker cp rei-rails-4-docker-web-1:/app/Gemfile.lock Gemfile.lock
```

# dcbuild vs dcup

`dcbuild` takes a LONG time to run (like 15+ minutes on a M2 Mac, depending on
what you change). Still trying to figure out when this needs to be run:

* Changing README.md (if you want to see it on the home page)
* Changing Dockerfile
* Adding new files
* Changing anything outside the auto-load path (like lib)
* Changing Gemfile (slow)

`dcup`
* TODO test reload of items in rails path (like controllers/models)

