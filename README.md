# Lagoon Ghost example

This is a best practice implementation of Ghost 4 running in Lagoon.

**Features:**

* Always up to date with the latest version of Ghost, this is built at image build time. You may wish to pin this in production (to avoid surprise upgrades).
* Uses MySQL for the database, and this will work with the `dbaas-operator`, so the database will be Highly Available.
* Ghost can be made to run with 2 or more pods, so the application is Highly Available.

## Local development

I use the excellent Go fork of Pygmy called [pygmy-go](https://github.com/fubarhouse/pygmy-go). Installation is simple on a Mac:

```bash
brew tap fubarhouse/pygmy-go;
brew install pygmy-go;
```

To start you local docker images:

```bash
pygmy-go up
docker-compose up -d --build
```

## Deploy to Lagoon

Talk to your Lagoon administrator to get a Lagoon project created, then you can deploy this repository as is to it. You may wish to add a custom route, this is up to you.
