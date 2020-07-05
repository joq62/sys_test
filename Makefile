all:
	rm -rf ebin/* src/*~ test_ebin/* test_src/*~;
	cp */src/*.app ebin;
	erlc -o ebin */src/*.erl;
	erl -pa ebin -sname sys
test:
	rm -rf ebin/* src/*~ test_ebin/* test_src/*~;
	cp adder_service/src/*.app ebin;
	cp divi_service/src/*.app ebin;
	erlc -o ebin adder_service/src/*.erl;
	erlc -o ebin divi_service/src/*.erl;
	erlc -o test_ebin test_src/*.erl;
	erl -pa ebin -pa test_ebin -s sys_test test -sname sys_test
