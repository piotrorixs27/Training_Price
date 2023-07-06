# Training_Price


Project Backend serverless Iac in Terraform.Backend return product price "Training" with diferent currency "CHF","EUR","ZL","USD","GBP".API return all of them currency and each separately.


##  Contests

## 1. Tools

## 1.1. Terraform -version 1.3.6

HashiCorp Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share. You can then use a consistent workflow to provision and manage all of your infrastructure throughout its lifecycle. Terraform can manage low-level components like compute, storage, and networking resources, as well as high-level components like DNS entries and SaaS features.

## 1.2. AWS(Amamzon Web Services)

Amazon Web Services (AWS) is the world’s most comprehensive and broadly adopted cloud, offering over 200 fully featured services from data centers globally. Millions of customers—including the fastest-growing startups, largest enterprises, and leading government agencies—are using AWS to lower costs, become more agile, and innovate faster.

## 1.3 Visual Studio Code

Visual Studio Code combines the simplicity of a source code editor with powerful developer tooling, like IntelliSense code completion and debugging.First and foremost, it is an editor that gets out of your way. The delightfully frictionless edit-build-debug cycle means less time fiddling with your environment, and more time executing on your ideas.

## 2. Setup

## 2.1. DynamoDb

In first step I created Datebase in AWS .This servise was DynamoDb when I did two tables :currency and price. I had five  currency :USD,GBP,EUR,ZL,CHF which each of them had different value. I turned on deletion protection enabled who protect to random delete datebase in AWS.

## 2.2. Lambda Function

I have one datebase , now I must created two different lambda functions .First return all of them currency , which give rmissions to create log groups and log streams, to upload log events to log streams.The second is almost he same , but return only one chosen currency.

## 2.3. API GATEWAY

Amazon API Gateway is a fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs at any scale. I created one API GATEWAY which can return all of them values and only one , thi is us choice . I chosen HTTPAPI ,because is more straight than Websocket API.
