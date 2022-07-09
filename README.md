# Weathery Space API

In fulfillment of Spacebox's hiring challenge requirements for RoR engineer role.

## Scope of work

It has a very simple product requirement. A weather forcasting API that connects with a 3rd party weather API to perform 2 main functions

1. As a user, I can select a location and query for the forecast for the next 7 days
2. As a user, I can view location's weather report based on a date range

The API outputs JSON retrieved from the 3rd party weather API which will be consumed by [this](https://github.com/Fahmiin-Abdullah/weathery-space-ui) SPA frontend.

P.S. The features necessary for this API to work is stuck behind a paywall in Weatherstack. So I opted for a free [alternative](https://www.visualcrossing.com/) that does just 2 things great - forecasting and historical data - exactly what we needed for this app.

## Setting up the app

1. Clone this repo
2. Run `bundle`
3. Run `rails db:setup`
4. Create an `application.yml` file to the config folder with the following values.
```yml
default: &default
  DB_HOST: '127.0.0.1'
  DB_PORT: '5432'
  DB_USERNAME: 'username' # Use your own local db username
  DB_PASSWORD: 'password' # Use your own local db password
  WEATHER_API_KEY: 'HRL8PTLUJGW6PNH75W6MDN7A6' # API key from VisualCrossing

development:
  <<: *default

test:
  <<: *default

staging:
  <<: *default

production:
  <<: *default

```
5. Run `rails s` to start
6. In something like postman or in cUrl, make a request to `POST http://localhost:3000/forecast` and payload
```json
{
  "location": "Brunei",
  "start_date": "2022-07-01", // for /history endpoint
  "end_date": "2022-07-08", // for /history endpoint
}
```
