<a name="v0.1.12"></a>
## [v0.1.12](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.11...v0.1.12) (2020-10-20)

### Enhancements
* eks: enhanced to handle k8s_groups for ci-user
* user_access: enhanced to handle k8s_groups for ci-user


<a name="v0.1.11"></a>
## [v0.1.11](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.10...v0.1.11) (2020-10-13)

### Enhancements
* vpc: added public/private visibility tags to subnets


<a name="v0.1.10"></a>
## [v0.1.10](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.9...v0.1.10) (2020-10-13)

### Enhancements

* cloudtrail: remove environment as input


<a name="v0.1.9"></a>
## [v0.1.9](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.8...v0.1.9) (2020-10-09)

### Enhancements

* enable S3 encryption for s3_hosting and cloudtrail


<a name="v0.1.8"></a>
## [v0.1.8](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.7...v0.1.8) (2020-10-06)

### Enhancements

* user_access: use map instead of index for resource creation


<a name="v0.1.7"></a>
## [v0.1.7](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.6...v0.1.7) (2020-10-06)

### New Features

* add CloudTrail


<a name="v0.1.6"></a>
## [v0.1.6](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.5...v0.1.6) (2020-10-05)

### Enhancements

* s3_hosting config for CORS origin


<a name="v0.1.5"></a>
## [v0.1.5](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.4...v0.1.5) (2020-10-02)

### Enhancements

* allow specifying cf-trusted signers


<a name="v0.1.4"></a>
## [v0.1.4](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.3...v0.1.4) (2020-09-30)

### Enhancements

* Expose cf_signed_downloads var for selectively applying access controls


<a name="v0.1.3"></a>
## [v0.1.3](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.2...v0.1.3) (2020-09-29)


<a name="v0.1.2"></a>
## [v0.1.2](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.1...v0.1.2) (2020-09-24)

### New Features

* initial commit for module iam_users ([#6](https://github.com/commitdev/terraform-aws-zero/issues/6))


<a name="v0.1.1"></a>
## [v0.1.1](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.0...v0.1.1) (2020-09-24)

### Bug Fixes

* modules with count to pick index first item ([#11](https://github.com/commitdev/terraform-aws-zero/issues/11))
* Bump external module versions in database and logging modules to allow support for AWS provider version 3 ([#13](https://github.com/commitdev/terraform-aws-zero/issues/13))


<a name="v0.1.0"></a>
## [v0.1.0](https://github.com/commitdev/terraform-aws-zero/compare/v0.0.3...v0.1.0) (2020-09-23)

### Bug Fixes

* Environment check was looking for the wrong string when enabling backups ([#9](https://github.com/commitdev/terraform-aws-zero/issues/9))


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

