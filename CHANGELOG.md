
<a name="v0.1.0"></a>
## [v0.1.0](https://github.com/commitdev/terraform-aws-zero/compare/v0.0.3...v0.1.0) (2020-09-22)

### Bug Fixes

* Environment check was looking for the wrong string when enabling backups ([#9](https://github.com/commitdev/terraform-aws-zero/issues/9))

### Enhancements

* Allow adding SubjectAltNames for certificate ([#7](https://github.com/commitdev/terraform-aws-zero/issues/7))
* Allow adding domain aliases for s3 hosting module ([#7](https://github.com/commitdev/terraform-aws-zero/issues/7))

### BREAKING CHANGES

* The certificate module now only accepts a single domain at a time, since we can iterate over module calls with TF 1.13
* The s3_hosting module now only accepts a single domain at a time, since we can iterate over module calls with TF 1.13


<a name="v0.0.3"></a>
## [v0.0.3](https://github.com/commitdev/terraform-aws-zero/compare/v0.0.2...v0.0.3) (2020-09-11)

### New Features

* Add support for signed url downloads ([#4](https://github.com/commitdev/terraform-aws-zero/issues/4))


<a name="v0.0.2"></a>
## [v0.0.2](https://github.com/commitdev/terraform-aws-zero/compare/v0.0.1...v0.0.2) (2020-09-04)

### Enhancements

* Auto changelog management, add documentation and contribution guidelines ([#3](https://github.com/commitdev/terraform-aws-zero/issues/3))


<a name="v0.0.1"></a>
## v0.0.1 (2020-08-31)

### Bug Fixes

* incorrect database variable reference

### Pull Requests

* Merge pull request [#60](https://github.com/commitdev/terraform-aws-zero/issues/60) from commitdev/terraform013
* Merge pull request [#50](https://github.com/commitdev/terraform-aws-zero/issues/50) from commitdev/remove-policy-naming-conflicts

