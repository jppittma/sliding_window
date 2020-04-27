function tests = sliding_window_tests

tests = functiontests(localfunctions);

function testA(testCase)
series = 1:10;
verifyLength(testCase, single_rect(series,3,3), 3);

function testB(testCase)
	series=1:9;
	verifyEqual(testCase,single_rect(series, 3, 0), [4 5 6]);

function testC(testCase)
	series=1:10;
	verifyEqual(testCase,single_rect(series, 3, 0), [4 5 6]);

function testD(testCase)
	series=0:10;
	verifyEqual(testCase,single_rect(series, 4, 0), [4 5 6 7]);
