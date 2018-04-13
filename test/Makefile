TESTS := $(wildcard *.test)

test:
	for TEST in $(TESTS); do \
		echo "running test $$TEST"; \
		./$$TEST ; \
	done
	echo tests passed
	$(MAKE) testclean

clean:	testclean
	rm *~

testclean:
	rm -f info.conf
	rm -f actual_output
