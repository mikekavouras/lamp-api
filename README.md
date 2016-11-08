# Lamp

A description of your application.

## Getting the code

First things first, you need the repository:

    git clone git@github.com:YOURUSERNAME/lamp.git

Once you have that you'll want to switch to that folder. This project was built using
Rails 4.2.x and Ruby 2.1.x Ruby versions are managed with rbenv and when switching to
the folder you should receive a notice that you need to install ruby if it is missing.

Once you have the code you should be able to bundle.

## Environment

Make a `.env` file:

    RACK_ENV=development
    PORT=3000
    DOMAIN=lamp.dev

## Mail

You need to send mails locally, to do this use `mailcatcher`:

    gem install mailcatcher

Then run it:

   mailcatcher

Once you have sent mails you can view them at [http://localhost:1080](http://localhost:1080)

## Database

The database requires you to use postgres in development. Assuming you have this you should be able to migrate

    bundle exec rake db:create db:migrate

For tests:

    bundle exec rake RAILS_ENV=test db:create db:migrate

For seeding:

    foreman run bundle exec rake db:seed


## Running locally

To start the app locally you'll want to use foreman:

    foreman start

## Specs

Testing is done using RSpec. You can run this continuously using Guard:

    bundle exec guard
