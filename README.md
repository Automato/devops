# Automato devops

This repository is dedicated to automating Automato's infrastructure in a public and tested manner.

## Development Plan

* Pull requests only
* Pull request will initiate build & test
* Build & test will perform a dry run and declare the proposed changes
* Tests will be used to make assertions about infrastructure

## Useage

(TBC) I'm the only one using this, so I haven't documented how yet.

## Useage in your own cloud

Unless you have the sufficient permissions to configure the Automato cloud, you'll have a hard time running this repo without modification.
You can, however, use this repository in a meaningful manner by doing the following:

* Fork this repo
* Create necessary AWS account and API credentials
* Store credentials locally in `~/.aws/credentials`
* Create a `secrets.tf` file at the root of this repo with an [AWS provider config](https://www.terraform.io/docs/providers/aws/index.html)
* Modify the `bootstrap.sh` and `bootstrap.tf` files to point to a bucket which you will be able to create (names must be unique, globally) and will use for administrative files.
* Run `bootstrap.sh`
* Now you can go to `/terraform` or `/packer` directories and read the README there for useage and modify at your will.
