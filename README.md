# terraform-statuscake-monitoring-suite

This README outlines the details of collaborating on this terraform
configuration. A short introduction of this repo could easily go here.

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
