.PHONY: all setup deps compile gen test clean publish

## Targets
##=========================================================================

all: setup deps compile

setup:
	mise install

deps:
	mix deps.get

compile: deps
	mix compile

gen: deps
	mix uof.schemas.gen
	mix format

test: gen compile
	mix test

clean:
	mix clean
	rm -rf priv/xsd lib/uof/schemas/api lib/uof/schemas/feed lib/uof/schemas/xml

publish: deps
	mix local.hex --force
	mix hex.publish --yes
