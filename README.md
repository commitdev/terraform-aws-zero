Terraform modules for Zero's AWS EKS Stack

[![Validation Status](https://github.com/commitdev/terraform-aws-zero/workflows/Validate%20Terraform/badge.svg)](https://github.com/commitdev/terraform-aws-zero/actions)

Included from [https://github.com/commitdev/zero-aws-eks-stack](https://github.com/commitdev/zero-aws-eks-stack)


## Contributing

Full contribution [guidelines are covered here](/.github/CONTRIBUTING.md).


## Doc generation

Code formatting and documentation for variables and outputs is generated using [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) which uses [terraform-docs](https://github.com/segmentio/terraform-docs).

Follow [these instructions](https://github.com/antonbabenko/pre-commit-terraform#how-to-install) to install pre-commit locally.

And install `terraform-docs` with `go get github.com/segmentio/terraform-docs` or `brew install terraform-docs`.


## Maintainers
Please install (via brew or whatever means) `git-chglog`.

To update the changelog, run `make changelog`
To release a new version, check out the main branch and run `make release`. The new version should be automatically detected by Terraform Registry.

By default these commands will tag or create changelogs for a new 'patch' version. To increment 'minor' or 'major' versions prefix the make command with `SCOPE=minor`.
