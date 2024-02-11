# AdminCentre&sup2;
Welcome back to watchmojo.com where today we will be counting down the top 10 most generic names in software.

Dysfunctional Axon ripoff handling licensing and blacklisting for kryptic. It's different *enough.*

## A disclaimer
We've open sourced this for convenience and so that you can take a ponder at our god awful source code, this is really customised to kryptic and would require a bit of modification to get working for your own group. Provided you know Rails, it shouldn't be too hard, you'd need to edit:  
- `db/migrate/20240208024354_create_licenses.rb` (add or rename columns to your liking)
- `app/controllers/license.rb`
- `app/helpers/license_helper.rb`
- basically everything in `app/views/licenses`
- `app/models/admin.rb` (remove line 5 to disable domain lock if you don't have Cloud Identity/Workspace)

## Feature List
- [x] User Blacklists + API endpoint
- [x] Licenses + API endpoint
- [x] User Management
- [x] Profiles & User Settings
- [ ] Requests
- [ ] Connection to a hub game
- [x] [Bot](https://github.com/WindevSystems/AC2-Discord)

## Prerequisites
- RVM (not required per se but recommended)
- Ruby 2.5.1
- For production: a PostgreSQL server
- A good amount of self hatred

## Development setup
Setting up for development work isn't too hard.
- Provided you use rvm, `rvm install 2.5.1`
- `git clone https://github.com/WindevSystems/AdminCentre2` (skip if using Codespaces)
- `cd AdminCentre2` (skip if using Codespaces)
- Copy .env and fill it with the respective values from the GCP console
- Copy sentry.example.rb to sentry.rb and fill in the DSN
- `bundle install`
- `rake setup:apitoken`, place the output in .env
- `rails db:migrate`
- `whenever --update-crontab`
- `rails s`
- Log in for the first time (localhost:3000)
- Make yourself a superadmin (`rake usermgmt:superadmin`)

## Production Setup
guide coming soonish, once we actually set it up in production first

## Contributing
Follow development setup instructions