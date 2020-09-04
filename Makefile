.PHONY: changelog release

SEMTAG=tools/semtag

CHANGELOG_FILE=CHANGELOG.md
TAG_QUERY=v11.0.0..

SCOPE ?= "patch" # Options are major, minor, patch

changelog:
	git-chglog -o $(CHANGELOG_FILE) --next-tag `$(SEMTAG) final -s $(SCOPE) -o -f` $(TAG_QUERY)

release:
	$(SEMTAG) final -s $(SCOPE)
