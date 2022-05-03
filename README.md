# Demo setup

## Keep control on your cloud resources

|                                                                                                     |                                                                                                                                                                                                                                              |
| :-------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ![Labs](https://learn.hashicorp.com/_next/static/images/color-c0fe8380afabc1c58f5601c1662a2e2d.svg) | This demo shows you how to automate your architecture implementation in a **Cloud DevOps** approach with [Terraform](https://www.terraform.io/). _Deploy on classical AWS IaaS, use fully managed services, and deploy everywhere you want._ |
| **terraform**                                                                                       | Terraform >= 1.1.7 (an alias tf is create for terraform cli)                                                                                                                                                                                 |
| **aws**                                                                                             | aws cli v2 (WARNING : you are responsible of your access key, don't forget to deactivate or suppress it in your aws account !)                                                                                                               |

## First check

> PLease check that everything is alright. Open a terminal in your sandbox and test environment

Open a terminal and check terraform cli

```bash
sandbox@sse-sandbox-457lgm:/sandbox$ terraform version
Terraform v1.1.9
on linux_amd64
```

Check aws cli

```bash
sandbox@sse-sandbox-457lgm:/sandbox$ aws --version
aws-cli/2.6.1 Python/3.9.11 Linux/5.13.0-40-generic exe/x86_64.debian.10 prompt/off
```

You need to configure your AWS access key. **Don't forget to delete or deactivate your access key in IAM, once you have finished this demo !**

```bash
sandbox@sse-sandbox-457lgm:/sandbox$ aws configure
AWS Access Key ID [None]: XXXXXXXXXXXXXX
AWS Secret Access Key [None]: XXXxxxxxxxxxxxxxxxxxXXXxxxxxxxxxXXxxxxxxx
Default region name [None]: eu-north-1
Default output format [None]:
```

Generate html page from Readme.md

```bash
sandbox@sse-sandbox-457lgm:/sandbox$ node md2html.js
```

## Terraform backend

All terraform state files are stored and shared in a dedicated S3 bucket. Create if needed your own bucket.

```bash
aws s3api create-bucket --bucket a-tfstate-rch --create-bucket-configuration LocationConstraint=eu-north-1 --region eu-north-1
aws s3api put-bucket-tagging --bucket a-tfstate-rch --tagging 'TagSet=[{Key=Owner,Value=raphael.chir@couchbase.com},{Key=Name,Value=terraform state set}]'
```

Refer your bucket in your terraform backend configuration.
**Specify a key for your project !**

```bash
terraform {
  backend "s3" {
    region  = "eu-north-1"
    key     = "myproject-tfstate"
    bucket  = "a-tfstate-rch"
  }
}
```

## SSH Keys

We need to generate key pair in order to ssh into instances. Create a .ssh folder in tf-playground.
[SSH Academy](https://www.ssh.com/academy/ssh/keygen#creating-an-ssh-key-pair-for-user-authentication)

Choosing an Algorithm and Key Size
SSH supports several public key algorithms for authentication keys. These include:

**rsa** - an old algorithm based on the difficulty of factoring large numbers. A key size of at least 2048 bits is recommended for RSA; 4096 bits is better. RSA is getting old and significant advances are being made in factoring. Choosing a different algorithm may be advisable. It is quite possible the RSA algorithm will become practically breakable in the foreseeable future. All SSH clients support this algorithm.

**dsa** - an old US government Digital Signature Algorithm. It is based on the difficulty of computing discrete logarithms. A key size of 1024 would normally be used with it. DSA in its original form is no longer recommended.

**ecdsa** - a new Digital Signature Algorithm standarized by the US government, using elliptic curves. This is probably a good algorithm for current applications. Only three key sizes are supported: 256, 384, and 521 (sic!) bits. We would recommend always using it with 521 bits, since the keys are still small and probably more secure than the smaller keys (even though they should be safe as well). Most SSH clients now support this algorithm.

**ed25519** - this is a new algorithm added in OpenSSH. Support for it in clients is not yet universal. Thus its use in general purpose applications may not yet be advisable.

The algorithm is selected using the -t option and key size using the -b option. The following commands illustrate:

```bash
ssh-keygen -t rsa -b 4096
ssh-keygen -t dsa
ssh-keygen -t ecdsa -b 521
ssh-keygen -t ed25519
```
