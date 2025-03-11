%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dropdown Menu Items for Module Assignment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Dropdown for assigning modules to a semester
    elem(assign_module_dropdown(I), dropdown_menu, semester_header_container(I)) :- semester(I).
    attr(assign_module_dropdown(I), order, 2) :- semester(I).
    attr(assign_module_dropdown(I), selected, "Assign module") :- semester(I).
    attr(assign_module_dropdown(I), class, ("btn-sm";"btn-outline-dark"; "m-2")) :- semester(I).


    % Dropdown menu items to assign modules
	module_addable_to_semester(E,I) :- 
		module_program(_, _, E, _, _),
		semester(I), 
		not _all(in(E,s(I))).
	
	elem(assign_module_option(I,E), dropdown_menu_item, assign_module_dropdown(I)) :- module_addable_to_semester(E, I).
    attr(assign_module_option(I,E), label, @concat(E, " (", C, " ECTS)")) :- module_addable_to_semester(E, I), map(c, E, C).
    attr(assign_module_option(I,E), class, "disabled") :- module_addable_to_semester(E,I), not _any(in(E,s(I))).
    attr(assign_module_option(I,E), class, "opacity-50") :- module_addable_to_semester(E,I), not _any(in(E,s(I))).

    attr(assign_module_option(I,E), class, "text-success") :- module_addable_to_semester(E, I), user_preference(include(_),E).
    attr(assign_module_option(I,E), class, "text-danger") :- module_addable_to_semester(E, I), user_preference(exclude(_),E).
    attr(assign_module_option(I,E), icon, ("fa-solid";"fa-thumbs-up")) :- module_addable_to_semester(E, I), user_preference(include(hard),E).
    attr(assign_module_option(I,E), icon, ("fa-regular";"fa-thumbs-up")) :- module_addable_to_semester(E, I), user_preference(include(soft),E).
    attr(assign_module_option(I,E), icon, ("fa-regular";"fa-thumbs-down")) :- module_addable_to_semester(E, I), user_preference(exclude(soft),E).
    attr(assign_module_option(I,E), icon, ("fa-solid";"fa-thumbs-down")) :- module_addable_to_semester(E, I), user_preference(exclude(hard),E).

    when(assign_module_option(I,E), click, call, add_assumption(in(E,s(I)))) :- module_addable_to_semester(E, I).

    % Container for modules in each semester
    elem(semester_modules_container(I), container, semester_container(I)) :- semester(I).
    attr(semester_modules_container(I), class, ("bg-wight")) :- semester(I).
    attr(semester_modules_container(I), order, 2) :- semester(I).


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Module Display within Semesters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Display a module if assigned to a semester
    shown_module(E,I) :- _all(in(E,s(I))).
    shown_module(E,I) :- in(E,s(I)), _clinguin_browsing.
	shown_module(E,I) :- module_program(_, _, E, _, _), _clinguin_context(unlocked(E),s(I)).

    % Container for displayed modules
    elem(displayed_module(E), container, semester_modules_container(I)) :- shown_module(E,I).
    attr(displayed_module(E), height, C*12) :- shown_module(E,I), map(c,E,C).
    attr(displayed_module(E), width, 200) :- shown_module(E,I).
    attr(displayed_module(E), class, (
		"border"; 
		"border-secondary"; 
		"d-flex";
		"flex-row";
		"justify-content-between";
		"align-items-center"; 
		"p-3";
		"m-2"; 
		"rounded"; 
		"border-2"; 
		"border-opacity-50"; 
		"bg-white")) :- shown_module(E,I).
    attr(displayed_module(E), class, "border-info") :- _all(in(E,s(I))), not _clinguin_assume(in(E,s(I)), true).

	% Visual feedback for locked/unlocked modules
	attr(displayed_module(E), filter, "opacity(0.8)") :- shown_module(E,I), not _clinguin_context(unlocked(E),_).
	attr(displayed_module(E), "box-shadow", "0 2px 2px 2px #00000070") :- _clinguin_context(unlocked(E),_).

	% Drag and drop
	attr(displayed_module(E), draggable_as, E) :- shown_module(E,I), _clinguin_context(unlocked(E),_).
	attr(displayed_module(E), drop_target, semester_container(J)) :- semester(J), shown_module(E,I),
    _clinguin_context(unlocked(E),_),
    _any(in(E,s(J))),
    I != J.

	% Unlock button
	elem(unlock_module_button(E), button, displayed_module_b(I,E)) :- shown_module(E,I).
	attr(unlock_module_button(E), icon, "fa-lock") :- shown_module(E,I), not _clinguin_context(unlocked(E),_).
	attr(unlock_module_button(E), icon, "fa-lock-open") :- _clinguin_context(unlocked(E),_).
	attr(unlock_module_button(E), order, 1) :- shown_module(E,I).
	attr(unlock_module_button(E), class, (
		"p-2"; 
		"ms-2"; 
		"border-0"; 
		"bg-transparent"; 
		"text-secondary"; 
		"small")) :- shown_module(E,I).
	when(unlock_module_button(E), click, context, (unlocked(E),s(I))) :- 
		shown_module(E,I), 
		not _clinguin_context(unlocked(E),_).
	when(unlock_module_button(E), click, call, remove_assumption(in(E,s(I)))) :- 
		shown_module(E,I), 
		not _clinguin_context(unlocked(E),_).
	when(unlock_module_button(E), click, call, get) :- _clinguin_context(unlocked(E),_).

	% Remove lock button on inferred modules that are non draggable
	attr(unlock_module_button(E), class, "d-none") :- shown_module(E,I), not _clinguin_context(unlocked(E),_), not _clinguin_assume(in(E,s(I)), true).


	% Restore module position on any action except drop
	when(O', E, call, get) :- 
		when(O', E, call, _), 
		E != drop, 
		_clinguin_context(unlocked(M),s(I)).

	when(O', E, call, add_assumption(in(M,s(I)),true)) :- 
    when(O', E, call, _), 
    E != drop, 
    _clinguin_context(unlocked(M),s(I)),
    not _clinguin_assume(in(M,_), true).

% Modified drop handler to use source info from dragged
when(semester_container(J), drop, call, (
    remove_assumption(in(M,s(I))),
    add_assumption(in(M,s(J)), true)
)) :- 
    semester(J),
    _clinguin_context(unlocked(M), s(I)),
    I != J.

    elem(displayed_module_l(I,E), container, displayed_module(E)) :- shown_module(E,I).
    attr(displayed_module_l(I,E), class, "text-wrap") :- shown_module(E,I).
    attr(displayed_module_l(I,E), fontSize, ("12px")) :- shown_module(E,I).
	attr(displayed_module_l(I,E), order, 1) :- shown_module(E,I).

    elem(displayed_module_b(I,E), container, displayed_module(E)) :- shown_module(E,I).
    attr(displayed_module_b(I,E), class, (
		"align-items-end"; 
		"ms-auto"; 
		"d-flex"; 
		"flex-column")) :- shown_module(E,I).
	attr(displayed_module_b(I,E), order, 2) :- shown_module(E,I).

    % Label for each displayed module
    elem(module_label(I,E), label, displayed_module_l(I,E)) :- shown_module(E,I).
    attr(module_label(I,E), label, @concat(E,": ",EN)) :- shown_module(E,I), module_program(_, EN, E, _, _).
    attr(module_label(I,E), class, ("text-black")) :- _clinguin_assume(in(E,s(I)), true).
    attr(module_label(I,E), class, ("text-muted")) :- _all(in(E,s(I))), not _clinguin_assume(in(E,s(I)), true).
    when(module_label(I,E), click, update, (module_info_modal(E), visibility, shown)) :- shown_module(E,I).

    % Button to remove a module from a semester
    elem(remove_module_button(I,E), button, displayed_module_b(I,E)) :- _clinguin_assume(in(E,s(I)), true).
    attr(remove_module_button(I,E), icon, "fa-times") :- _clinguin_assume(in(E,s(I)), true).
    attr(remove_module_button(I,E), class, (
		"p-2"; 
		"ms-auto"; 
		"border-0"; 
		"bg-transparent"; 
		"text-secondary"; 
		"small")) :- _clinguin_assume(in(E,s(I)), true).
    when(remove_module_button(I,E), click, call, remove_assumption(in(E,s(I)))) :- _clinguin_assume(in(E,s(I)), true).
	attr(remove_module_button(I,E), order, 2) :- _clinguin_assume(in(E,s(I)), true).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Display of Total Credits for Each Semester
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Container for total credits under each semester
    elem(semester_credits_container(I), container, semester_container(I)) :- semester(I).
    attr(semester_credits_container(I), order, 3) :- semester(I).
    attr(semester_credits_container(I), class, (
		"p-2"; 
		"mt-2"; 
		"rounded"; 
		"text-center"; 
		"fw-bold"; 
		"mt-auto")) :- semester(I).

    % Label to display total credits for a semester
    elem(semester_credits_label(I), label, semester_credits_container(I)) :- semester(I).
    attr(semester_credits_label(I), label, @concat(SC, " ECTS")) :-
        semester(I),
        SC = #sum{ C,E : map(c,E,C), shown_module(E,I) }.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Display of Total Credits at the Top of the Page
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Container to display total credits across all semesters
    elem(total_credits_display_container, container, semester_control_container).
    attr(total_credits_display_container, order, 1).
    attr(total_credits_display_container, class, (
		"p-3"; 
		"rounded"; 
		"m-2"; 
		"align-self-center")).
    % attr(total_credits_display_container, class, ("bg-secondary"; "text-white"; "p-3"; "rounded"; "m-2"; "align-self-center";"fw-bold")).

    % Label to display total credits
    elem(total_credits_label, label, total_credits_display_container).
    attr(total_credits_label, label, @concat("<b>Assigned credits: </b>", TC, " ECTS")) :-
        TC = #sum{ C,E : map(c,E,C), shown_module(E,_) }.