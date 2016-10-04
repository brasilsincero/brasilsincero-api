# Brasil Sincero - API

[![Codeship Status for brasilsincero/brasilsincero-api](https://codeship.com/projects/0c579630-4257-0134-daa8-1ed03da5965c/status?branch=master)](https://codeship.com/projects/168152)

## Getting Start

- Clone project
- Setup the database

      $ bin/rails db:setup

- Install Embulk - instructions [here](https://github.com/embulk/embulk#quick-start)
- Install Embulk dependencies

      $ cd lib/embulk/embulk_bundle && embulk bundle install

## Creating the infrastructure

      $ bin/rails bolsa_familia:infrastructure

## Downloading payments files

      $ bin/rails "bolsa_familia:download[month, year]"

## Importing 'Bolsa Família' records

      $ bin/rails "bolsa_familia:import[month, year]"

## Downloading and Importing payments files

      $ bin/rails "bolsa_familia:download_and_import[month, year]"
