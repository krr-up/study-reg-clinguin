	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Sidebar for Module Subsets
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	elem(subset_sidebar, sidebar, root_window).
	attr(subset_sidebar, position, "end").
	attr(subset_sidebar, class, (
		"d-flex";
		"flex-column";
		"bg-light";
		"bg-opacity-100";
		"border";
		"border-1")).

	elem(sidebar_container, container, subset_sidebar).
	attr(sidebar_container, class, ("mt-5")).
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Containers for Module Subsets
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Subsets of modules
	subset(E,S) :- map(l, S, _); map(u, S, _), in(E, S).

	% Containers for subsets of modules
	elem(subset_container(S), container, sidebar_container) :- subset(E,S).
	attr(subset_container(S), class, (
		"bg-secondary";
		"bg-opacity-10";
		"fw-bold";"p-2";
		"m-2";"rounded"; 
		"col-12"; 
		"col-sm-12"; 
		"col-md-12"; 
		"d-flex"; 
		"flex-column";
		"p-sm-4";
		"p-lg-3"; 
		"border"; 
		"border-info"; 
		"border-2")) :- subset(E,S).
	attr(subset_container(S), flex_direction, column) :- subset(E,S).
	attr(subset_container(S), order, O) :- subset(E,S),set_name(S,_,O).


		% Collapse component
		elem(subset_collapse(S), collapse, subset_container(S)) :- subset(E,S).
		attr(subset_collapse(S), order, 1) :- subset(E,S).
		attr(subset_collapse(S), label, N) :- subset(E,S), set_name(S,N,_).

		% Button styling
		attr(subset_collapse(S), class, (
			"d-flex"; 
			"align-items-center"; 
			"w-100";
			"gap-2";
			"p-2";           
			"border-0";      
			"bg-transparent";
			"text-dark";
			"fw-bold";
			"fs-5"          
		)) :- subset(E,S).


% Place modules container inside the collapse component
elem(subset_modules_container(S), container, subset_collapse(S)) :- subset(E,S).
attr(subset_modules_container(S), order, 1) :- subset(E,S).
attr(subset_modules_container(S), class, ("d-flex"; "flex-wrap"; "gap-2")) :- subset(E,S).
attr(subset_modules_container(S), flex_direction, row) :- subset(E,S).

	% Module is visibly selected if it is in a semester
	module_visibly_selected(E) :- shown_module(E, I), semester(I).

	% Button for modules in a subset
	elem(subset_module_button(E,S), button, subset_modules_container(S)) :- in(E,S), subset(E,S).
	attr(subset_module_button(E,S), label, @concat(E,": ",EN)) :- in(E,S), subset(E,S), module_program(_, EN, E, _, _).
	attr(subset_module_button(E,S), class, ("btn-sm"; "text-start"; "align-self-center"; "w-100")) :- in(E,S), subset(E,S).
	attr(subset_module_button(E,S), class, "btn-secondary") :- in(E,S), subset(E,S), module_visibly_selected(E).
	attr(subset_module_button(E,S), class, "btn-outline-secondary") :- in(E,S), subset(E,S), not module_visibly_selected(E).

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
	elem(progress_bar_container(S), container, subset_collapse(S)) :- subset(_, S).
	attr(progress_bar_container(S), order, 4) :- subset(_, S).
	attr(progress_bar_container(S), class, ("pt-3"; "mt-auto")) :- subset(_, S).

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
