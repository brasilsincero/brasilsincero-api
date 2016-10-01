# Brasil Sincero - API

[![Codeship Status for brasilsincero/brasilsincero-api](https://codeship.com/projects/0c579630-4257-0134-daa8-1ed03da5965c/status?branch=master)](https://codeship.com/projects/168152)

## Getting Start

- Clone project
- Setup the database

      $ bin/rails db:setup

- Install Embulk - instructions [here](https://github.com/embulk/embulk#quick-start)
- Install Embulk Postgresql Output plugin

      $ embulk gem install embulk-output-postgresql

- Install Embulk RubyProc Filter plugin

      $ embulk gem install embulk-filter-ruby_proc

## Importing 'Bolsa Família' records

- Change the filename in lib/embulk/bolsa_familia.yml
- Import from csv to database

      $ embulk run lib/embulk/bolsa_familia.yml

## Routes
