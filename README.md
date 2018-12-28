# Postcoder [![Build status](https://badge.buildkite.com/e4df0912e62c296fba88d74ee6b8d04b4b641cd7c7a04fdb31.svg)](https://buildkite.com/fivegoodfriends/postcoder)

Microservice to return surrounding postcodes given an Australian postcode.  Leverages the `australia_postcode` gem. All distance calculations are performed in memory.

## System Dependencies

- Ruby MRI 2.6.0
- Rails 5.1.5
- `API_TOKEN` secret environment variable
- [direnv](https://direnv.net/) *(Recommended in development)*

There's no database, `australia_postcode` reads data from a CSV.

## Usage

The service only has one endpoint, `/`. Target this with a `GET` request,
supplying the `api_token` and `postcode` query parameters, and you'll receive a
JSON response of the shape:
```
{
  "3": [<array of integer postcodes>],
  "7": [<array of integer postcodes>],
  "10": [<array of integer postcodes>],
  "20": [<array of integer postcodes>],
}
```

e.g.:
```
# assuming you've defined the environment variable API_TOKEN=ASDF
$ curl "http://localhost:3000/?api_token=ASDF&postcode=2752"
# => {"3":[2752],"7":[2570,2752],"10":[2570,2745,2752],"20":[2555,2556,2557,2567,2570,2745,2752,2773]}
```

## Development

Install the application's dependencies:

```
$ bundle
```

Start the application server:

```
$ bundle exec rails server
```

## Testing

Run the entire test suite.

```
$ bundle exec rspec
```

## Deploying

This application is automatically deployed when commits are pushed to the master branch and the tests on the master branch pass.
