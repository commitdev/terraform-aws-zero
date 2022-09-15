
<a name="v0.6.6"></a>
## [v0.6.6](https://github.com/commitdev/terraform-aws-zero/compare/v0.6.5...v0.6.6) (2022-09-15)

### Enhancements

* Allow to create VPC with custom CIDR ([#75](https://github.com/commitdev/terraform-aws-zero/issues/75))


<a name="v0.6.5"></a>
## [v0.6.5](https://github.com/commitdev/terraform-aws-zero/compare/v0.6.4...v0.6.5) (2022-06-13)

### New Features

* output security group id from the database module ([#74](https://github.com/commitdev/terraform-aws-zero/issues/74))


<a name="v0.6.4"></a>
## [v0.6.4](https://github.com/commitdev/terraform-aws-zero/compare/v0.6.3...v0.6.4) (2022-06-10)

### New Features

* add support for creating RDS replica DBs. Warning: increases the required AWS provider version to 4.9. Otherwise, should be backwards compatible. ([#73](https://github.com/commitdev/terraform-aws-zero/issues/73))


<a name="v0.6.3"></a>
## [v0.6.3](https://github.com/commitdev/terraform-aws-zero/compare/v0.6.2...v0.6.3) (2022-05-17)

### New Features

* make db version configurable. Adds some required fields to the module ([#72](https://github.com/commitdev/terraform-aws-zero/issues/72))


<a name="v0.6.2"></a>
## [v0.6.2](https://github.com/commitdev/terraform-aws-zero/compare/v0.6.1...v0.6.2) (2022-05-16)

### New Features

* allow rds parameters to be passed in to the db module


<a name="v0.6.1"></a>
## [v0.6.1](https://github.com/commitdev/terraform-aws-zero/compare/v0.6.0...v0.6.1) (2022-01-28)

### Bug Fixes

* user-auth when external-secrets enabled ([#70](https://github.com/commitdev/terraform-aws-zero/issues/70))


<a name="v0.6.0"></a>
## [v0.6.0](https://github.com/commitdev/terraform-aws-zero/compare/v0.5.6...v0.6.0) (2021-12-16)

### Refactoring

* Move k8s auth out of infra terraform ([#69](https://github.com/commitdev/terraform-aws-zero/issues/69))

### breaking change


This change moves away from creating the aws-auth configmap in the same terraform state where we are creating the cluster. All k8s operations have been moved to the kubernetes terraform in the aws-eks-stack repo.


<a name="v0.5.6"></a>
## [v0.5.6](https://github.com/commitdev/terraform-aws-zero/compare/v0.5.5...v0.5.6) (2021-11-15)

### Bug Fixes

* Fixed quotes in type

### New Features

* Add support for supplying description when creating secrets ([#68](https://github.com/commitdev/terraform-aws-zero/issues/68))


<a name="v0.5.5"></a>
## [v0.5.5](https://github.com/commitdev/terraform-aws-zero/compare/v0.5.4...v0.5.5) (2021-09-20)

### Enhancements

* user-auth add var for ory images tags ([#65](https://github.com/commitdev/terraform-aws-zero/issues/65))


<a name="v0.5.4"></a>
## [v0.5.4](https://github.com/commitdev/terraform-aws-zero/compare/v0.5.3...v0.5.4) (2021-09-17)

### Bug Fixes

* add user-auth verification form url ([#64](https://github.com/commitdev/terraform-aws-zero/issues/64))


<a name="v0.5.3"></a>
## [v0.5.3](https://github.com/commitdev/terraform-aws-zero/compare/v0.5.2...v0.5.3) (2021-09-10)

### Enhancements

* support user-auth local dev kratos ([#62](https://github.com/commitdev/terraform-aws-zero/issues/62))


<a name="v0.5.2"></a>
## [v0.5.2](https://github.com/commitdev/terraform-aws-zero/compare/v0.5.1...v0.5.2) (2021-08-23)

### Bug Fixes

* typo in user_auth oathkeeper config ([#61](https://github.com/commitdev/terraform-aws-zero/issues/61))


<a name="v0.5.1"></a>
## [v0.5.1](https://github.com/commitdev/terraform-aws-zero/compare/v0.5.0...v0.5.1) (2021-08-19)

### Bug Fixes

* eks: Remove unnecessary locals and references
* Remove prefix delegation env var code from eks module, it will need to be done in the eks stack kubernetes terraform instead
* Compatibility fix as a band-aid for cases where someone created their cluster before this module made a change to the cluster role name


<a name="v0.5.0"></a>
## [v0.5.0](https://github.com/commitdev/terraform-aws-zero/compare/v0.4.8...v0.5.0) (2021-08-16)

### Enhancements

* Added support for EKS prefix delegation, allowing nodes to have many more IPs (17 -> 110), also change how the eks module accepts node group parameters. ([#59](https://github.com/commitdev/terraform-aws-zero/issues/59))

### breaking change


Switched back to using the worker security group instead of the "cluster primary" security group - we were only using it because we weren't creating a custom launch template and with this change we will be. If you are trying to upgrade, this map require tmeporarily adding a security group rule to allow your old node groups to access the db, bringing up new node groups with the new configuration, then removing your old node groups.

* docs: Clarified node group config


<a name="v0.4.8"></a>
## [v0.4.8](https://github.com/commitdev/terraform-aws-zero/compare/v0.4.7...v0.4.8) (2021-08-06)

### Bug Fixes

* user_auth oathkeeper ingress misconfigured ([#58](https://github.com/commitdev/terraform-aws-zero/issues/58))


<a name="v0.4.7"></a>
## [v0.4.7](https://github.com/commitdev/terraform-aws-zero/compare/v0.4.6...v0.4.7) (2021-08-05)

### Enhancements

* user-auth allow customizing UI url ([#57](https://github.com/commitdev/terraform-aws-zero/issues/57))


<a name="v0.4.6"></a>
## [v0.4.6](https://github.com/commitdev/terraform-aws-zero/compare/v0.4.5...v0.4.6) (2021-08-04)

### Enhancements

* allow overriding default config ([#56](https://github.com/commitdev/terraform-aws-zero/issues/56))


<a name="v0.4.5"></a>
## [v0.4.5](https://github.com/commitdev/terraform-aws-zero/compare/v0.4.4...v0.4.5) (2021-07-20)


<a name="v0.4.4"></a>
## [v0.4.4](https://github.com/commitdev/terraform-aws-zero/compare/v0.4.3...v0.4.4) (2021-07-05)

### New Features

* Add support for eks addons for vpc cni, kube-proxy, coredns ([#54](https://github.com/commitdev/terraform-aws-zero/issues/54))


<a name="v0.4.3"></a>
## [v0.4.3](https://github.com/commitdev/terraform-aws-zero/compare/v0.4.2...v0.4.3) (2021-06-29)

### Bug Fixes

* Remove unnecessary field in eks module that was causing trouble during upgrade


<a name="v0.4.2"></a>
## [v0.4.2](https://github.com/commitdev/terraform-aws-zero/compare/v0.4.1...v0.4.2) (2021-06-29)

### Enhancements

* Bump nginx ingress default version


<a name="v0.4.1"></a>
## [v0.4.1](https://github.com/commitdev/terraform-aws-zero/compare/v0.4.0...v0.4.1) (2021-06-29)

### Bug Fixes

* Comparison in user_access module was not working correctly ([#53](https://github.com/commitdev/terraform-aws-zero/issues/53))


<a name="v0.4.0"></a>
## [v0.4.0](https://github.com/commitdev/terraform-aws-zero/compare/v0.3.9...v0.4.0) (2021-06-28)

### Enhancements

* Bumped upstream version of eks module and changed variables to support better handling of node group changes, also added missing provider requirements. ([#52](https://github.com/commitdev/terraform-aws-zero/issues/52))

### BREAKING CHANGE


The change to the EKS module had its own breaking change that will require a bit of state management, you can read about it here: https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/upgrades.md#upgrade-module-to-v1700-for-managed-node-groups . Also, this change may require some state management since it changes the name of the node group. You should be able to upgrade gracefully by importing the previous group into the state and removing the old one. Feel free to ask in the community channel at slack.getzero.dev if you have any questions.

* fix: Bump validation workflow to tf 1.0


<a name="v0.3.9"></a>
## [v0.3.9](https://github.com/commitdev/terraform-aws-zero/compare/v0.3.8...v0.3.9) (2021-06-07)

### Enhancements

* Allow subnet group to be supplied when using the database module ([#51](https://github.com/commitdev/terraform-aws-zero/issues/51))


<a name="v0.3.8"></a>
## [v0.3.8](https://github.com/commitdev/terraform-aws-zero/compare/v0.3.7...v0.3.8) (2021-05-27)

### Enhancements

* user_access module now supports passing in aws account ids to set up trust policies so users in different accounts can assume the roles we create ([#50](https://github.com/commitdev/terraform-aws-zero/issues/50))


<a name="v0.3.7"></a>
## [v0.3.7](https://github.com/commitdev/terraform-aws-zero/compare/v0.3.6...v0.3.7) (2021-05-19)


<a name="v0.3.6"></a>
## [v0.3.6](https://github.com/commitdev/terraform-aws-zero/compare/v0.3.5...v0.3.6) (2021-05-18)

### New Features

* Added support for using external-secrets with kratos ([#48](https://github.com/commitdev/terraform-aws-zero/issues/48))


<a name="v0.3.5"></a>
## [v0.3.5](https://github.com/commitdev/terraform-aws-zero/compare/v0.3.4...v0.3.5) (2021-05-18)

### New Features

* S3_hosting create CF but use existing bucket ([#47](https://github.com/commitdev/terraform-aws-zero/issues/47))


<a name="v0.3.4"></a>
## [v0.3.4](https://github.com/commitdev/terraform-aws-zero/compare/v0.3.3...v0.3.4) (2021-04-27)

### Bug Fixes

* auth wrong target for cookie session ([#46](https://github.com/commitdev/terraform-aws-zero/issues/46))


<a name="v0.3.3"></a>
## [v0.3.3](https://github.com/commitdev/terraform-aws-zero/compare/v0.3.2...v0.3.3) (2021-04-23)

### Bug Fixes

* Switched back to using ELB instead of NLB due to various issues. Also added the ability to modify proxy protocol and traffic policy settings and return the nginx request id to the front end. ([#45](https://github.com/commitdev/terraform-aws-zero/issues/45))


<a name="v0.3.2"></a>
## [v0.3.2](https://github.com/commitdev/terraform-aws-zero/compare/v0.3.1...v0.3.2) (2021-04-19)

### Bug Fixes

* auth endpoints targeting wrong svc name


<a name="v0.3.1"></a>
## [v0.3.1](https://github.com/commitdev/terraform-aws-zero/compare/v0.3.0...v0.3.1) (2021-04-15)

### Bug Fixes

* Pin the terraform version in the validation gha workflow because of issues with submodules when using TF 0.15
* Return the EKS primary security group now for us to use in other modules, also connect the primary and additional security groups (only used for migration, as the additional security group won't be used anymore)


<a name="v0.3.0"></a>
## [v0.3.0](https://github.com/commitdev/terraform-aws-zero/compare/v0.2.1...v0.3.0) (2021-04-13)

### Breaking

* Switch EKS module to using managed node groups instead of worker groups ([#42](https://github.com/commitdev/terraform-aws-zero/issues/42))


<a name="v0.2.1"></a>
## [v0.2.1](https://github.com/commitdev/terraform-aws-zero/compare/v0.2.0...v0.2.1) (2021-03-31)

### Bug Fixes

* Oops, somehow this change got lost. Set ingress traffic policy to local to preserve source ip.


<a name="v0.2.0"></a>
## [v0.2.0](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.21...v0.2.0) (2021-03-30)

### Enhancements

* Added pod anti affinity to nginx ingress
* Moved nginx ingress creation from aws-eks module and converted to a helm chart. Also switched to using NLB instead of ELB.


<a name="v0.1.21"></a>
## [v0.1.21](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.20...v0.1.21) (2021-03-23)

### Enhancements

* customizable helm resource name


<a name="v0.1.20"></a>
## [v0.1.20](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.19...v0.1.20) (2021-03-22)

### Documentation

* logging - Updated docs

### Bug Fixes

* logging - Add an option to change the value for requiring https in elasticsearch, default it to false


<a name="v0.1.19"></a>
## [v0.1.19](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.18...v0.1.19) (2021-03-18)

### Enhancements

* optionally create user-auth namespace


<a name="v0.1.18"></a>
## [v0.1.18](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.17...v0.1.18) (2021-03-05)

### New Features

* User auth with ORY Oathkeeper and Kratos


<a name="v0.1.17"></a>
## [v0.1.17](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.16...v0.1.17) (2021-02-25)

### New Features

* accept lambda configuration


<a name="v0.1.16"></a>
## [v0.1.16](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.15...v0.1.16) (2021-02-12)


<a name="v0.1.15"></a>
## [v0.1.15](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.14...v0.1.15) (2021-02-02)


<a name="v0.1.14"></a>
## [v0.1.14](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.13...v0.1.14) (2021-01-29)


<a name="v0.1.13"></a>
## [v0.1.13](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.12...v0.1.13) (2020-11-30)

### Enhancements

* remove sendgrid mail. domain prefix

### Bug Fixes

* Dependency was missing between users and groups for group membership, causing membership addition to fail


<a name="v0.1.12"></a>
## [v0.1.12](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.11...v0.1.12) (2020-10-21)


<a name="v0.1.11"></a>
## [v0.1.11](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.10...v0.1.11) (2020-10-13)


<a name="v0.1.10"></a>
## [v0.1.10](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.9...v0.1.10) (2020-10-13)


<a name="v0.1.9"></a>
## [v0.1.9](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.8...v0.1.9) (2020-10-09)


<a name="v0.1.8"></a>
## [v0.1.8](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.7...v0.1.8) (2020-10-06)


<a name="v0.1.7"></a>
## [v0.1.7](https://github.com/commitdev/terraform-aws-zero/compare/v0.1.6...v0.1.7) (2020-10-06)


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


<a name="v0.1.0"></a>
## [v0.1.0](https://github.com/commitdev/terraform-aws-zero/compare/v0.0.3...v0.1.0) (2020-09-23)

### Bug Fixes

* Bump external module versions in database and logging modules to allow support for AWS provider version 3 ([#13](https://github.com/commitdev/terraform-aws-zero/issues/13))
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

