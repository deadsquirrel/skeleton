PACKAGE := skeleton

# this rule lists those rules that ignores dependencies
.PHONY: clean

# this would be our default rule
all: ebin ebin/$(PACKAGE).app $(PACKAGE)

clean:
	rm -rf ebin
	rm -f *.dump

ebin/$(PACKAGE).app: src/$(PACKAGE).app.src
	cp src/$(PACKAGE).app.src ebin/$(PACKAGE).app

ebin:
	mkdir -p ebin

$(PACKAGE): src/$(PACKAGE).erl src/$(PACKAGE)_app.erl src/$(PACKAGE)_sup.erl
	erlc -o ebin src/$(PACKAGE).erl
	erlc -o ebin src/$(PACKAGE)_app.erl
	erlc -o ebin src/$(PACKAGE)_sup.erl

shell: all
	erl -pa ebin -config $(PACKAGE).config -eval "application:ensure_all_started(skeleton)."
