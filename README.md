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

## Downloading all payments files

      $ bin/rails "bolsa_familia:download_all"

## Importing 'Bolsa Família' records

      $ bin/rails "bolsa_familia:import[month, year]"

## Downloading and Importing payments files

      $ bin/rails "bolsa_familia:download_and_import[month, year]"

## Crawler

- Install the [httrack](http://www.httrack.com/)
- Run the command

      $ httrack --list public/crawler_urls.txt --depth=0 --max-time=600000000 --sockets=1 --timeout=600000000 --retries=1

## Routes

Top 50 "bolsa familia" payments in the current year

      /v1/bolsa_familia/people/ranking

Top 50 "bolsa familia" payments in the current year and state

      /v1/bolsa_familia/people/ranking?state=sp

Top 50 "bolsa familia" payments in the informed year

      /v1/bolsa_familia/people/ranking?year=YYYY

Top 50 "bolsa familia" payments in the informed year and state

      /v1/bolsa_familia/people/ranking?year=YYYY&state=sp

Top "bolsa familia" payments grouped by state in the current year

      /v1/bolsa_familia/states/ranking

Top "bolsa familia" payments grouped by state in the informed year

      /v1/bolsa_familia/states/ranking?year=YYYY
