%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : test module sys
%%% Debugging 
%%%    trace log: in and out signals all or specific
%%%    State changes
%%%    Exceptions 
%%% Events
%%%
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(sys_test). 
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").
%% --------------------------------------------------------------------

%% External exports
-export([]).



%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
cases_test()->
    clean_start_test(),
    init_sys_divi_service_test(),
    ok_test(),
    badrpc_test(),
    error_test(),
    clean_stop_test(),
    ok.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

clean_start_test()->
    ok.

init_sys_divi_service_test()->

    ok.

ok_test()->
    application:stop(divi_service),
    ?assertEqual(ok,application:start(divi_service)),
    sys:log(divi_service,true),
    divi_service:divi(420,10),
    ?assertMatch({ok,[{in,{'$gen_call',{_Pid,_},{divi,420,10}}},
		      {out,42.0,{_Pid,_},{state}}
		     ]},sys:log(divi_service,get)),
    ok.

badrpc_test()->
    application:stop(divi_service),
    ?assertEqual(ok,application:start(divi_service)),
    sys:log(divi_service,true),
    divi_service:divi(420,0),
    ?assertMatch({ok,[{in,{'$gen_call',{_Pid,_Ref},{divi,420,0}}},
		      {out,{badrpc,_},{_Pid,_Ref},{state}}]},sys:log(divi_service,get)),

    ok.
error_test()->
    application:stop(divi_service),
    ?assertEqual(ok,application:start(divi_service)),
    sys:log(divi_service,true),
    divi_service:divi_1(420,0),
    ?assertMatch({ok,[{in,{'$gen_call',{_Pid,_},{divi_1,420,0}}},
		      {out,{error,_Err},{_Pid,_},{state}}
		     ]},sys:log(divi_service,get)),
    ok.
    
divi_2_test_cc()->
    divi_service:divi(320,10,{?MODULE,?LINE}),    
     ?assertMatch({ok,[{in,{'$gen_call',
                      {_Pid,_Ref},
                      {divi,320,10}}},
		      {out,32.0,
		       {_Pid,_Ref},
		       {state}},
		      _]},sys:log(divi_service,get)),
    ok.

clean_stop_test()->
    ?assertEqual(ok,application:stop(divi_service)),
     timer:sleep(1000),
     init:stop(),
    ok.

%% --------------------------------------------------------------------
%% Function:support functions
%% Description: Stop eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
