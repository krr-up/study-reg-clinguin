% Define modules based on 'in' predicate from cogsys.lp
module(E) :- in(E, m).

% Define preference options
preference(required; excluded; preferred; not_preferred).

% External predicates to set preferences for modules
%#external preference(P, E) : module(E), preference(P).

% Hard constraint: Required modules must be included
:- preference(required, E), not in(E, s(_)).
%:- not in(am11, s(1)).

% Test preferences for example
preference(required, am11).
%* preference(excluded, fm1).
preference(preferred, am11).
preference(not_preferred, pm1). *%