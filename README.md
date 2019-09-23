# Terraform startup factory

## Coding #1

* show credentials file
* show provider.tf
* show artifacts-bucket.tf
* show main module
* terraform init, plan, apply

Ref: [AWS Provider - Authentication](https://www.terraform.io/docs/providers/aws/index.html#authentication)

Check: Do I have everything in code?

## Coding #2

* external API - Zonky
* show zonky-call.js
* show zonky-lambda.tf
* terraform init, plan, apply

Ref: [Zonky external API](https://zonky.docs.apiary.io)

Commands:

`cd lambdas; zip zonky-call-0.0.1.zip zonky-call.js; cd ..`

`aws s3 sync ./lambdas s3://406030180379-artifacts-bucket-RANDOM_ID/lambdas --profile terraform`

Check: Do I have everything in code?
