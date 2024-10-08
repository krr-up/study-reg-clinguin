use_preferences.
% Define modules based on 'in' predicate from cogsys.lp
module(E) :- in(E, m).

% Define preference options
preference(include(hard), "Include").
preference(exclude(hard), "Exclude").
preference(include(soft), "Try to include").
preference(exclude(soft), "Try to exclude").

% External predicates to set preferences for modules
#external user_preference(P, E) : module(E), preference(P,_). [false]

% Hard constraint: Required modules must be included
:- user_preference(include(hard), E), not in(E, s(_)).
:- user_preference(exclude(hard), E), in(E, s(_)).
:~ user_preference(include(soft), E), not in(E, s(_)).[1@1,E]
:~ user_preference(exclude(soft), E), in(E, s(_)).[1@1,E]
%:- not in(am11, s(1)).

% Test preferences for example
% user_preference(include, am11).
% user_preference(exclude, am12).
%* preference(excluded, fm1).
preference(preferred, am11).
preference(not_preferred, pm1). *%
