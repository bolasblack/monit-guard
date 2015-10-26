.PHONY : watch build publish test npm clean _publish_history

BIN=`npm bin`

watch : npm clean
	@$(BIN)/gulp

build : npm clean
	@$(BIN)/gulp fe:build

publish : build
	cd public && git add -A && git commit -m "`date -R`" && git push

npm :
	@echo "Check npm package update..."
	@hash npm || (echo "Install npm first" && exit 1)
	@CHECK_FILE=package.json STATE_FOLDER=node_modules sh utils/update_manager.sh check; \
	if [ $$? -eq 1 ]; then \
		npm install \
		&& CHECK_FILE=package.json STATE_FOLDER=node_modules sh utils/update_manager.sh update \
		; \
	fi

clean :
	@echo "Start clean public files..."
	@-rm -rf public/*

# DO NOT USE IT
_publish_history :
	git checkout master
	rm -rf ./*
	git checkout history -- .
	git add -A
	git commit --amend --no-edit
