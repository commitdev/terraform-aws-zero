# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with the owners of this repository before making a change.

## Pull Request Process

1. Update the README.md of the module with details of changes to the interface. Ideally use the pre-commit hook to automatically update the variables/outputs of each module.
2. Once all outstanding comments and checklist items have been addressed, your contribution will be merged! Merged PRs will be included in the next release. The maintainers take care of updating the CHANGELOG as they tag new releases.

## Checklists for contributions

- [ ] Add a [changelog prefix](#pull-requests) to your PR or Commits (at leats one of your commit groups)
- [ ] Validation actions are passing
- [ ] README.md has been updated after any changes to variables and outputs. See https://github.com/commitdev/terraform-aws-zero/#doc-generation

## Pull Requests

To be able to generate a changelog, Pull Requests or Commit messages must have one of the following prefixes:

- `feat:` for new features
- `fix:` for bug fixes
- `improvement:` for enhancements
- `docs:` for documentation and examples
- `refactor:` for code refactoring
- `ci:` for CI purpose
- `chore:` for chores

The `chore` prefix is skipped during changelog generation. It can be used for a `chore: update changelog` commit message by example.

