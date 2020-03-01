![MissionKontrol Logo](MissionKontrol-logo-original.png)

# MissionKontrolRelay

[![Gem Version](http://img.shields.io/gem/v/mission_kontrol_relay.svg?style=flat-square)](https://rubygems.org/gems/mission_kontrol_relay)
[![License](http://img.shields.io/:license-gpl3-blue.svg?style=flat-square)](http://www.gnu.org/licenses/gpl-3.0.html)

## Description

[MissionKontrol](https://missionkontrol.io) is a simple and effective admin interface for your applications or microservices. It is a self hosted application that is quick and easy to set up, even if you aren't a developer. MissionKontrol doesn't need to know anything about your application(s) in order to work, it just needs to connect to your database(s).

**MisisonKontrolRelay** is a gem that gives your version of MissionKontrol more power and better features by providing it with more information about your application (such as model associations and validations).

Don't worry though, with the access token generated on install, only your hosted version of MissionKontrol will get access to this information.

#### Do I have to be using MissionKontrol in order to use this gem?

No! Anyone can use this gem. To see how you can use this gem outside of MissionKontrol, please see the 'endpoints' section below.

## Installation instructions

You can install **MissionKontrolRelay** into your Rails application by adding it into your gemfile:

```ruby
gem 'mission_kontrol_relay'
```

or you can install it manually:

```bash
$ gem install 'mission_kontrol_relay'
```

Once you have installed the gem you need to run the generator:

```bash
$ rails generate mission_kontrol_relay:install
```

The generator will generate your token and save it as an environment variable. You will need this to allow MissionKontrol to talk to your application, or if you want to access the provided endpoints.

To access your token run the following:

```bash
$ printenv MISSION_KONTROL_TOKEN
```

## Contributing

Before contributing please read the code of conduct [here](https://github.com/Mission-Kontrol/MissionKontrol-rails/CODE_OF_CONDUCT.md)

Here is the contribution workflow:

1. Fork the repo on GitHub
2. Clone the project to your own machine
3. Commit changes to your own branch
4. Push your work back up to your fork
5. Submit a Pull request so that we can review your changes

### Getting set up

```bash
$ bundle install
$ RAILS_ENV=test bundle exec rails db:setup
$ RAILS_ENV=test bundle exec rails db:migrate
```

### Running tests

```bash
$ bundle exec rspec
```
