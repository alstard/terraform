# Terraform Repository (formerly for "Up and Running" examples)

## Introduction
This repo contains examples and tests concerning terraform code and it's integration into the DPE AWS account with ConcourseCI

## Useful Snippets
Show the private IP addresses/DNS Names of running instances (atd ones)  

```aws ec2 describe-instances --filters "Name=tag:Name,Values=atd*" "Name=instance-state-name,Values=running"  --query "Reservations[*].Instances[*].[PrivateIpAddress,PrivateDnsName]"  --output=text```

## Useful Links

* Testing terraform - https://www.contino.io/insights/top-3-terraform-testing-strategies-for-ultra-reliable-infrastructure-as-code

* ConcourseCI - https://concourse.ci/flight-school.html

* DPE Concourse - http://concourse.platform-engineering.com:8080/teams/team11/

* Kitchen Setup - https://newcontext-oss.github.io/kitchen-terraform/tutorials/docker_provider.html

* Complete VPC Setup - https://linuxacademy.com/howtoguides/posts/show/topic/13922-a-complete-aws-environment-with-terraform

* Medium post for Bastion hosts - https://medium.com/@paulskarseth/ansible-bastion-host-proxycommand-e6946c945d30