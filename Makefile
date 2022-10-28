# make                  Prepare dist/ folder (all markdown & assets)
# make clean            Delete all generated files

SOURCES := $(shell find src -type f -name '*.md')
TARGETS := $(patsubst src/%.md,dist/%.html,$(SOURCES))

.PHONY: all
all: dist/.nojekyll $(TARGETS)

.PHONY: clean
clean:
	rm -rf dist

dist/.nojekyll: $(wildcard public/*) public/.nojekyll
	rm -vrf dist && mkdir -p dist && cp -vr public/.nojekyll public/* dist

# how to build a .html file from each .md
dist/%.html: src/%.md template.html5 Makefile tools/build.sh
	tools/build.sh "$<" "$@"
