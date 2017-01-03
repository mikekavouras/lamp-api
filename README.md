# Lamps

A description of your application.

## Getting the code

First things first, you need the repository:

    git clone git@git.electrolamp.org:lamp-api.git

Once you have that you'll want to switch to that folder. This project was built using Rails 5.x and Ruby 2.3.x Ruby versions are managed with rbenv and when switching to the folder you should receive a notice that you need to install ruby if it is missing.

Once you have the code you should be able to bundle.

## Environment

Make a `.env` file:

```
PARTICLE_ACCESS_TOKEN=YOURACCESSTOKEN
PARTICLE_DEVICE_ID=YOURDEVICEID
HASHIDS_SALT=
AWS_BUCKET=electrolamp-photos
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
APPLICATION_UID=
RACK_ENV=development
PORT=3000
```

Most of the environment can be obtained from another developer.

To get your particle access token you need to go to https://build.particle.io/ and click on the gear icon. This will take you to your particle settings and you can copy the access token listed in the panel.

To obtain your particle device id you can get it from the iOS application or run `particle list`.

```bash
$ particle list
<no name> [300041001147353138383138] (Photon) is online
  Variables:
    version (string)
  Functions:
    int glow(String args)
    int blink(String args)
```

## Database

The database requires you to use postgres in development. Assuming you have this you should be able to migrate

    bundle exec rake db:create db:migrate

For tests:

    bundle exec rake RAILS_ENV=test db:create db:migrate

For seeding:

    foreman run bundle exec rake db:seed

If you want to run this all as one command:

    foreman run rake db:setup

## Running locally

To start the app locally you'll want to use foreman:

    foreman start

## Specs

Testing is done using RSpec. You can run this continuously using Guard:

    bundle exec guard

## Insomnia

Go get Insomnia Rest Client from https://insomnia.rest/. Once you have it you'll want to import the `config/insomnia.json`. At this point you should be able to generate an access token. Click on the `POST #create` action in `Auth` and click send:

![](https://rpl.cat/uploads/FC2EFY_3q0KQgtFjioxTFJCW84BQcKwYEyjDpVt233g/public.png)

Copy the `access_token` value and add it to your local environment:

![](https://rpl.cat/uploads/Bo4sJsPx4fr0hxkitww0M8wFF9ympCpW9BrrpjRX6d4/public.png)

Set the access token; also, set the particle id while you are there.

![](https://rpl.cat/uploads/tKhftFkrH3MDhu_9PmAKluiuDi4SPQrRHOyBsBUDOts/public.png)


Now you should be able to run the `GET #purple` test action and also create Device.

## Changing the particle code

mike says beep
