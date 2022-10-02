# terraform-statuscake-monitoring-suite ![terraform](https://github.com/StatusCakeDev/terraform-statuscake-monitoring-suite/workflows/terraform/badge.svg?event=push)

This repository implements a Terraform module to create a complete StatusCake
monitoring suite for a specific website URL.

It supports createing:

 - An HTTP uptime check
 - A Pagespeed check
 - An SSL check

## Prerequisites

You will need the following things properly installed on your computer.

* [Terraform](https://www.terraform.io/downloads.html) (1.0+)

## Installation

### Documentation

Full, comprehensive documentation is available on the [Terraform
website](https://registry.terraform.io/providers/StatusCakeDev/statuscake/latest/docs)

## Examples

Examples of how to use these modules can be found in the [examples](/examples)
directory.

## Usage

The most basic usage of this module is to create a suite of checks for a single
website URL.

```teraform
module "monitoring_suite" {
  source  = "StatusCakeDev/monitoring-suite/statuscake"
  version = "0.1.0"

  check_name  = "Google"
  website_url = "https://www.google.com"
}
```

## License

This project is licensed under the [Mozilla Public License](LICENSE.md).
