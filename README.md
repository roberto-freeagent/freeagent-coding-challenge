# FreeAgent Coding Challenge

Thank you for your interest in the FreeAgent Coding Challenge.  This template is a barebones guide to get you started.  Please add any gems, folders, files, etc. you see fit in order to produce a solution you're proud of.

## Coding Challenge Instructions

Please see the INSTRUCTIONS.md file for more information.

## Your Solution Setup and Run Instructions

1. Install gems with bundler
```
bundle install
```

2. Create and migrate the DB (development & test)
```
bundle exec rake db:create db:migrate RAILS_ENV=development
bundle exec rake db:create db:migrate RAILS_ENV=test
```

3. Import the rates
```
bundle exec rake fx:import[./data/eurofxref-hist-90d.json, EUR]
```

3. Run the tests
```
bundle exec rspec
```

N.B
I've also included an executable console helper script:
```
./bin/console
```
From here we have a Pry session where we can output Exchange Rates

```
[1] pry(main)> CurrencyExchange.rate(DateTime.new(2018, 11, 22), 'USD', 'GBP')
=> 0.777
```
## Your Design Decisions

I've created a sub directory in lib to seperate the importer logic from the rate fetching logic.  For the importer logic, I've followed the strategy pattern, sub-classing a concrete EuroFxImporter from a generic importer class so that it is easy to add importers from different sources in the future.

I've decided to use a lightweight sqlite3 schema to store historic exchange rates, while also using ActiveRecord for it's very helpful convenience methods.

Like any solution - there are advantages and drawbacks to my approach.  Initially, I planned on calculating all inverse rates and cross rates at import time.  However, the import was very slow.  This was because there are 2^n rates created when we factor in cross-rates.  In a production application, this could be offloaded to a scheduler to run as a background job which would alleviate this concern. 

Instead, I created a calculator class which decides, based on the input currencies, which calculation method to use.
