run_tests :
	mkdir -p ./test_tmp
	cp helm/opa-app/rules/* ./test_tmp/
	cp test/* ./test_tmp/
	export TEST_ENV=hello
	cd ./test_tmp && opa test -v .

clean:
	rm -r test_tmp