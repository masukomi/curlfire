SHELL := /usr/bin/env bash

.PHONY: test
test: ## Run tests
test: test-cookiefire test-curlfire

.PHONY: test-cookiefire
test-cookiefire:
	@diff <(HOME=$$PWD/test/home/linux ./cookiefire) test/gold/cookiefile.txt && echo Linux default: ok
	@diff <(HOME=$$PWD/test/home/linux ./cookiefire default-release) \
		test/gold/cookiefile.txt && echo Linux custom profile: ok
	@diff <(HOME=$$PWD/test/home/mac ./cookiefire) test/gold/cookiefile.txt && echo Mac default: ok
	@diff <(HOME=$$PWD/test/home/mac ./cookiefire default-release) \
		test/gold/cookiefile.txt && echo Mac custom profile: ok
	@diff <(./cookiefire <test/home/linux/.mozilla/firefox/def456.default/cookies.sqlite) \
		test/gold/cookiefile.txt && echo stdin: ok

.PHONY: test-curlfire
test-curlfire:
	@[[ "$$(HOME=test/home/linux PATH="test/bin:$$PATH" ./curlfire)" \
		=~ ^test/bin/curl\ -b\ test/home/linux/\.cache/curlcookies\..*\ -h$$ ]] && echo no args: ok
	@[[ "$$(HOME=test/home/linux PATH="test/bin:$$PATH" ./curlfire http://example.com)" \
		=~ ^test/bin/curl\ -b\ test/home/linux/\.cache/curlcookies\..*\ http://example.com$$ ]] && echo args: ok
	@[ -z "$$(find test/home -type f | grep .cache)" ] && echo cleanup: ok

.PHONY: help
help: ## Show this help text
	$(info usage: make [target])
	$(info )
	$(info Available targets:)
	@awk -F ':.*?## *' '/^[^\t].+?:.*?##/ \
         {printf "  %-24s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
