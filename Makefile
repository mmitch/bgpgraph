.PHONY: test

test:
	cd test && $(MAKE) -s test

clean:
	rm -f *~
	cd test && $(MAKE) clean
