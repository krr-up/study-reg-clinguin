	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Containers for Module Subsets
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Subsets of modules
	subset(E,S) :- map(l, S, _); map(u, S, _), in(E, S).

	% Containers for subsets of modules
	elem(subset_container(S), container, right_section) :- subset(E,S).
	attr(subset_container(S), class, ("bg-secondary";"bg-opacity-10";"fw-bold";"p-2";"m-2";"rounded"; "col-12"; "col-sm-12"; "col-md-12"; "d-flex"; "flex-column")) :- subset(E,S).
	attr(subset_container(S), flex_direction, column) :- subset(E,S).
	attr(subset_container(S), order, O) :- subset(E,S),set_name(S,_,O).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Labels for Module Subsets
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Label container for subsets
	elem(subset_label_container(S), container, subset_container(S)):-subset(E,S).
	attr(subset_label_container(S), order, 1):-subset(E,S).
	attr(subset_label_container(S), class, ("fw-bold";"p-2";"mt-2";"mb-2";"rounded")):-subset(E,S).

	% Label text for subsets
	elem(subset_label(S), label, subset_label_container(S)):-subset(E,S).
	% attr(subset_label(S), label, @concat("Modules ", S)):-subset(E,S), S != m.
	attr(subset_label(S), label, N):-subset(E,S), set_name(S,N,_).
	attr(subset_label(S), order, 1):-subset(E,S).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Display Modules in Subsets
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Display modules within each subset
	elem(subset_modules_container(S), container, subset_container(S)) :- subset(E,S).
	attr(subset_modules_container(S), order, 2):- subset(E,S).
	attr(subset_modules_container(S), class, ("d-flex"; "flex-wrap"; "pt-2")):- subset(E,S).
	attr(subset_modules_container(S), flex_direction, row) :- subset(E,S).

	% Module is visibly selected if it is in a semester
	module_visibly_selected(E) :- shown_module(E, I), semester(I).

	% Button for modules in a subset
	elem(subset_module_button(E,S), button, subset_modules_container(S)) :- in(E,S), subset(E,S).
	attr(subset_module_button(E,S), label, @concat(E,": ",EN)) :- in(E,S), subset(E,S), module_program(_, EN, E, _, _).
	attr(subset_module_button(E,S), class, ("btn-sm"; "m-1";"text-start")) :- in(E,S), subset(E,S).
	attr(subset_module_button(E,S), class, "w-100") :- in(E,S), subset(E,S).
	attr(subset_module_button(E,S), class, "btn-secondary") :- in(E,S), subset(E,S), module_visibly_selected(E).
	attr(subset_module_button(E,S), class, "btn-outline-secondary") :- in(E,S), subset(E,S), not module_visibly_selected(E).

	% Add success/danger classes based on include/exclude preferences
	% attr(subset_module_button(E,S), class, "text-success") :- in(E,S), subset(E,S), user_preference(include(_),E).
	% attr(subset_module_button(E,S), class, "text-danger") :- in(E,S), subset(E,S), user_preference(exclude(_),E).

	% Add icons for hard/soft inclusion and exclusion preferences
	attr(subset_module_button(E,S), icon, ("fa-solid"; "fa-thumbs-up")) :- in(E,S), subset(E,S), user_preference(include(hard),E).
	attr(subset_module_button(E,S), icon, ("fa-regular"; "fa-thumbs-up")) :- in(E,S), subset(E,S), user_preference(include(soft),E).
	attr(subset_module_button(E,S), icon, ("fa-regular"; "fa-thumbs-down")) :- in(E,S), subset(E,S), user_preference(exclude(soft),E).
	attr(subset_module_button(E,S), icon, ("fa-solid"; "fa-thumbs-down")) :- in(E,S), subset(E,S), user_preference(exclude(hard),E).

	when(subset_module_button(E,S), click, update, (module_info_modal(E), visibility, shown)) :- in(E,S), subset(E,S).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Display Progress Bars for Credits in Each Subset
	%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Total credits for selected modules in each subset
	subset_total_credits(S, TotalCredits) :-
		subset(_, S),
		TotalCredits = #sum { C, E : module_visibly_selected(E), in(E, S), map(c, E, C) }.

	% Remaining credits for each subset
	remaining_credits(S, Remaining, TotalCredits) :-
		map(l, S, LowerBound),
		subset_total_credits(S, TotalCredits),
		Remaining = LowerBound - TotalCredits.

	% Progress percentage of completed credits for each subset
	progress_percentage(S, Percentage) :-
		map(l, S, LowerBound),
		subset_total_credits(S, TotalCredits),
		LowerBound > 0,
		Percentage = (TotalCredits * 100) / LowerBound.

	% Container for progress bar showing credits completed
	elem(progress_bar_container(S), container, subset_container(S)) :- subset(_, S).
	attr(progress_bar_container(S), order, 4) :- subset(_, S).
	attr(progress_bar_container(S), class, ("m-1"; "pt-3"; "mt-auto")) :- subset(_, S).

	% Progress bar indicating credit completion percentage
	elem(subset_progress_bar(S), progress_bar, progress_bar_container(S)) :- subset(_, S).
	attr(subset_progress_bar(S), value, P) :- progress_percentage(S, P).
	attr(subset_progress_bar(S), class, ("progress-bar-striped"; "progress-bar-animated"; "rounded")) :- subset(_, S).
	attr(subset_progress_bar(S), out_label, @concat(Remaining, " ECTS")) :-
		remaining_credits(S, Remaining, _), Remaining > 0.
	attr(subset_progress_bar(S), label, @concat(TotalCredits, " ECTS")) :-
		remaining_credits(S, _, TotalCredits).
	attr(subset_progress_bar(S), height, 30) :- progress_percentage(S, P).
	attr(subset_progress_bar(S), class, "bg-success") :- progress_percentage(S, P), P >= 100.
	attr(subset_progress_bar(S), class, "bg-warning") :- progress_percentage(S, P), P >= 50, P < 100.
	attr(subset_progress_bar(S), class, "bg-danger") :- progress_percentage(S, P), P < 50.
