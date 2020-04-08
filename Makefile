copy_folders:
	mkdir -p ./test_tmp
	cp helm/opa-app/rules/* ./test_tmp/
	cp test/* ./test_tmp/

run_tests : copy_folders
	cd ./test_tmp && opa test -v .

run_coverage : copy_folders
	cd ./test_tmp && ../coverage.sh

clean:
	rm -r test_tmp