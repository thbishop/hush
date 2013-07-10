## Hush

A shameless rip off of one time secret

## Introduction

Hush is a simple web app which allows you to create a string and retrieve it one time. This could be useful for keeping sensitive strings out of your email, IM, etc.

In addition to only allowing a single retrival of a string, it will also only store the string for 10 minutes.

## Installation

Hush is a Rails app which uses [Redis](http://redis.io) as the backing store. Hush has been tested with ruby 2.0.0 and redis 2.6.x.

Installing ruby and redis is beyond the scope of this doc. Once these are installed and the code has been pulled down:

Use bundler to install all of the depedencies:

```shell
bundle install
```

Create a `.env` (based off of the example):

```shell
cp .env.example .env
```

You will need to update this file with:

* an encryption key (you can use `rake secret` to generate a nice random string for you)
* the info for your redis instance
* unless in development, comment out the `RACK_ENV` assignment

Hush is setup to use foreman to manage the processes.

If you're in devlopment mode, then you'll probably want to create a `.foreman` file based off of the example.

You can do so with:

```shell
cp .foreman.example .foreman
```

You can then start the app:

```shell
foreman start
```


## Contribute
* Fork the project
* Make your feature addition or bug fix (with tests and docs) in a topic branch
* Send a pull request and I'll get it merged


## License
See LICENSE
