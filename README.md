# THP project : Eventbrite like website

The project of the week is to develop a website, with most of the functionalities of the previous gossip project. We will implement more as days goes during this week.

## Description

This is the start of a website similar to eventbrite, in its functionalities, such as :

* Creating a user account
* Creating an event
* Subscribing to an event
* Sending email when user creates an account and create / subscribe to an event through SendGrid

Tomorrow, we will add the Ruby gem 'devise' to manage the account features.

## Installation

Works with the ruby version 2.7.1 and rails 5.2.4.4.

Download this repo, access it then type in the CLI the following :

```console
$ bundle install
$ rails db:create
$ rails db:migrate
```

Then, go to [SendGrid](https://sendgrid.com/) and create anccount if you don't have one. Precise that you are a developper.

Then, create a first sender with an email. Be careful, this project will send lots of mails, so you if don't want to use your email to spam other emails, then choose one with Yopmail domain ('example@yopmail.com'). Confirm your email then go to SendGrid's [API] page to create an API key.

Create a .env file and add in it :

```ruby
SENDGRID_LOGIN='apikey'
SENDGRID_PWD='Your_API_password_that_starts_with_SG'
```

Go to the app directory, and change the default sender email in 'app/mailer/user_mailer.rb'

```ruby
default from: 'exemple@yopmail.com'
```

And you are ready to go !

## Usage

If you run the seeds file, you will create several users, events and attendances (which represents the number of subscriptions to an event). The users have random name and the email will be "prenom.nom1@yopmail.com, prenom.nom2@yopmail.com, and so on…".

## Author

Maxime WONG