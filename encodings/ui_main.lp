%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Semester Definition and Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the range of semesters based on the constant 'n'
semester(I) :- _clinguin_const(n,N), I = 1..N.

% Define possible values for the number of semesters
values(3..8).

% Determine the season for each semester
semester_season(I, "<i class='fa fa-snowflake'></i>") :- semester(I), empty(int(m(s), s(I))).
semester_season(I, "<i class='fa fa-sun'></i>") :- semester(I), empty(int(m(w), s(I))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Root Window Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the root window element and set its layout to column
elem(root_window, window, root).
attr(root_window, flex_direction, column).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Layout Container
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main container holding the left, center, and right sections
elem(main_container, container, root_window).
attr(main_container, class, ("d-flex"; "flex-column"; "flex-lg-row"; "justify-content-between"; "align-items-start"; "m-2")).
attr(main_container, child_layout, flex).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Center Section Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Center container holding the semester display and controls
elem(center_section, container, main_container).
attr(center_section, order, 2).
attr(center_section, class, ("col-12"; "col-md-12"; "col-lg-8"; "pt-3"; "mb-3"; "mb-lg-0"; "d-flex"; "justify-content-center")).
attr(center_section, child_layout, flex).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Container for Semester Count and Update Control
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Container for displaying the current number of semesters and providing an update option
    elem(semester_control_container, container, center_section).
    attr(semester_control_container, order, 4).
    attr(semester_control_container, flex_direction, column).
    attr(semester_control_container, class, ("m-2")).
    attr(semester_control_container, class, "align-self-center").

    % Label displaying the current number of semesters
    elem(semester_count_label, label, semester_control_container).
    attr(semester_count_label, label, @concat("Current number of semesters: ", N)) :- _clinguin_const(n, N).
    attr(semester_count_label, order, 1).
    attr(semester_count_label, class, ("fw-bold"; "p-2"; "m-2")).

    % Dropdown menu for selecting the number of semesters
    elem(semester_dropdown, dropdown_menu, semester_control_container).
    attr(semester_dropdown, order, 2).
    attr(semester_dropdown, selected, "Change").
    attr(semester_dropdown, class, ("btn-sm"; "btn-secondary"; "p-2"; "m-2")).

    % Dropdown menu items representing possible semester values
    elem(semester_option(V), dropdown_menu_item, semester_dropdown) :- values(V).
    attr(semester_option(V), label, V) :- values(V).
    when(semester_option(V), click, call, set_constant("n", V)) :- values(V).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Container for Semester Display
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Container for displaying the list of semesters
    elem(semester_display_container, container, center_section).
    attr(semester_display_container, order, 2).
    attr(semester_display_container, class, ("d-flex"; "flex-wrap"; "flex-row"; "justify-content-center"; "align-items-start"; "w-100")).

    % Individual semester containers within the semester display
    elem(semester_container(I), container, semester_display_container) :- semester(I).
    attr(semester_container(I), order, I) :- semester(I).
    attr(semester_container(I), class, ("border-opacity-50"; "fw-bold"; "p-3"; "m-2"; "rounded"; "border"; "border-secondary"; "border-2"; "bg-light")) :- semester(I).

    % Header for each semester container
    elem(semester_header_container(I), container, semester_container(I)) :- semester(I).
    attr(semester_header_container(I), order, 1) :- semester(I).
    attr(semester_header_container(I), class, ("bg-secondary";"text-light";"fw-bold";"p-2";"m-1"; "rounded")) :- semester(I).

    % Label for each semester header
    elem(semester_label(I), label, semester_header_container(I)) :- semester(I).
    attr(semester_label(I), label, @concat(Season, " Semester ",I)) :- semester(I), semester_season(I, Season).
    attr(semester_label(I), order, 1) :- semester(I).

    % Dropdown menu for assigning modules to a semester
    elem(assign_module_dropdown(I), dropdown_menu, semester_header_container(I)) :- semester(I).
    attr(assign_module_dropdown(I), order, 2) :- semester(I).
    attr(assign_module_dropdown(I), selected, "Assign module") :- semester(I).
    attr(assign_module_dropdown(I), class, ("btn-sm";"btn-outline-light"; "m-2")) :- semester(I).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Dropdown Menu Items for Module Assignment
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Include modules in the dropdown menu
    elem(assign_module_option(I,E), dropdown_menu_item, assign_module_dropdown(I)) :- _any(in(E,s(I))), not _all(in(E,s(I))).
    attr(assign_module_option(I,E), label, @concat(E, " (", C, " ECTS)")) :- _any(in(E,s(I))), not _all(in(E,s(I))), map(c, E, C).
    when(assign_module_option(I,E), click, call, add_assumption(in(E,s(I)))) :- _any(in(E,s(I))), not _all(in(E,s(I))).

    % Container for modules within each semester
    elem(semester_modules_container(I), container, semester_container(I)) :- semester(I).
    attr(semester_modules_container(I), class, ("bg-wight")) :- semester(I).
    attr(semester_modules_container(I), order, 2) :- semester(I).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Module Display within Semesters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Define when a module should be shown within a semester
    shown_module(E,I) :- _all(in(E,s(I))).
    shown_module(E,I) :- _clinguin_assume(in(E,s(I)), true), _clinguin_browsing.

    % Container for each module displayed within a semester
    elem(displayed_module(I,E), container, semester_modules_container(I)) :- shown_module(E,I).
    attr(displayed_module(I,E), height, C*12) :- shown_module(E,I), map(c,E,C).
	attr(displayed_module(I,E), width, 200) :- shown_module(E,I).
	attr(displayed_module(I,E), class, ("border"; "border-secondary";
                                        "d-flex";"flex-row";"justify-content-between";"align-items-center";
                                        "p-3";"m-2"; "rounded"; "border-2"; "border-opacity-50"; "bg-white")) :- shown_module(E,I).
	% class for inferred modules
	attr(displayed_module(I,E), class, "border-info") :- _all(in(E,s(I))), not _clinguin_assume(in(E,s(I)), true).

	elem(displayed_module_l(I,E), container, displayed_module(I,E)) :- shown_module(E,I).
    attr(displayed_module_l(I,E), class, "text-wrap") :- shown_module(E,I).
	attr(displayed_module_l(I,E), fontSize, ("12px")) :- shown_module(E,I).

	elem(displayed_module_b(I,E), container, displayed_module(I,E)) :- shown_module(E,I).
	attr(displayed_module_b(I,E), class, ("align-items-end"; "ms-auto")) :- shown_module(E,I).

    % Label for each displayed module
    elem(module_label(I,E), label, displayed_module_l(I,E)) :- shown_module(E,I).
    attr(module_label(I,E), label, @concat(E,": ",EN)) :- shown_module(E,I), module_program(_, EN, E, _, _).
    attr(module_label(I,E), class, ("text-black")) :- _clinguin_assume(in(E,s(I)), true).
	attr(module_label(I,E), class, ("text-muted")) :- _all(in(E,s(I))), not _clinguin_assume(in(E,s(I)), true).
	when(module_label(I,E), click, update, (module_info_modal(E), visibility, shown)) :- shown_module(E,I).

    % Button for removing a module from a semester
    elem(remove_module_button(I,E), button, displayed_module_b(I,E)) :- _clinguin_assume(in(E,s(I)), true).
	attr(remove_module_button(I,E), icon, "fa-times") :- _clinguin_assume(in(E,s(I)), true).
	attr(remove_module_button(I,E), class, ("p-2"; "ms-auto"; "border-0"; "bg-transparent"; "text-secondary"; "small")) :- _clinguin_assume(in(E,s(I)), true).
    when(remove_module_button(I,E), click, call, remove_assumption(in(E,s(I)))) :- _clinguin_assume(in(E,s(I)), true).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Display of Total Credits for Each Semester
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Container for displaying total credits under each semester
    elem(semester_credits_container(I), container, semester_container(I)) :- semester(I).
    attr(semester_credits_container(I), order, 3) :- semester(I).
    attr(semester_credits_container(I), class, ("bg-light"; "p-2"; "mt-2"; "rounded"; "text-center"; "fw-bold"; "mt-auto")) :- semester(I).

    % Label for displaying total credits under each semester
    elem(semester_credits_label(I), label, semester_credits_container(I)) :- semester(I).
    attr(semester_credits_label(I), label, @concat(SC, " ECTS")) :-
        semester(I),
        SC = #sum{ C,E : map(c,E,C), shown_module(E,I) }.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Display of Total Credits at the Top of the Page
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Container for displaying the total credits across all semesters
    elem(total_credits_display_container, container, center_section).
    attr(total_credits_display_container, order, 1).
    attr(total_credits_display_container, class, ("bg-secondary"; "text-white"; "p-3"; "rounded"; "m-2"; "align-self-center")).

    % Label for displaying the total credits
    elem(total_credits_label, label, total_credits_display_container).
    attr(total_credits_label, label, @concat("Total credits: ", TC)) :-
        TC = #sum{ C,E : map(c,E,C), shown_module(E,_) }.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Right Section Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Right container holding the subset modules and progress bars
elem(right_section, container, main_container).
attr(right_section, order, 3).
attr(right_section, class, ("col-12"; "col-md-12"; "col-lg-2"; "ml-lg-auto"; "mb-lg-0"; "p-3"; "d-flex"; "flex-row"; "flex-wrap"; "flex-lg-column")).
attr(right_section, child_layout, flex).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Containers for Module Subsets
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Identify all subsets of modules
	subset(E,S) :- map(l, S, _); map(u, S, _), in(E, S).

	% Create containers for each subset of modules
	elem(subset_container(S), container, right_section) :- subset(E,S).
	attr(subset_container(S), class, ("border-opacity-50";"fw-bold";"p-2";"rounded"; "border"; "border-secondary"; "border-2"; "col-12"; "col-sm-12"; "col-md-12"; "d-flex"; "flex-column")) :- subset(E,S).
	attr(subset_container(S), flex_direction, column) :- subset(E,S).
	attr(subset_container(S), order, 2) :- subset(E,S).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Labels for Module Subsets
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Label container for each subset of modules
	elem(subset_label_container(S), container, subset_container(S)):-subset(E,S).
	attr(subset_label_container(S), order, 1):-subset(E,S).
	attr(subset_label_container(S), class, ("bg-secondary";"text-light";"fw-bold";"p-2";"mt-2";"mb-2";"rounded")):-subset(E,S).

	% Label text for each subset
	elem(subset_label(S), label, subset_label_container(S)):-subset(E,S).
	attr(subset_label(S), label, @concat("Modules ", S)):-subset(E,S), S != m.
	attr(subset_label(S), label, "All Modules"):-subset(E,m), S == m.
	attr(subset_label(S), order, 1):-subset(E,S).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Display Modules in Subsets
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Container for displaying modules within each subset
	elem(subset_modules_container(S), container, subset_container(S)) :- subset(E,S).
	attr(subset_modules_container(S), order, 2):- subset(E,S).
	attr(subset_modules_container(S), class, ("d-flex"; "flex-wrap"; "pt-2")):- subset(E,S).
	attr(subset_modules_container(S), flex_direction, row) :- subset(E,S).

	% Module is visibly selected if it is shown in any semester
	module_visibly_selected(E) :- shown_module(E, I), semester(I).

	% Button for each module in a subset
	elem(subset_module_button(E,S), button, subset_modules_container(S)) :- in(E,S), subset(E,S).
	attr(subset_module_button(E,S), label, E) :- in(E,S), subset(E,S).
	attr(subset_module_button(E,S), class, ("btn-sm"; "m-1")) :- in(E,S), subset(E,S).
	attr(subset_module_button(E,S), class, "btn-secondary") :- in(E,S), subset(E,S), module_visibly_selected(E).
	attr(subset_module_button(E,S), class, "btn-outline-secondary") :- in(E,S), subset(E,S), not module_visibly_selected(E).
	when(subset_module_button(E,S), click, update, (module_info_modal(E), visibility, shown)) :- in(E,S), subset(E,S), not module_visibly_selected(E).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Display Progress Bars for Credits in Each Subset
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Calculate the total credits for visibly selected modules within each subset
	subset_total_credits(S, TotalCredits) :-
		subset(_, S),
		TotalCredits = #sum { C, E : module_visibly_selected(E), in(E, S), map(c, E, C) }.

	% Calculate the remaining credits required for each subset
	remaining_credits(S, Remaining, TotalCredits) :-
		map(l, S, LowerBound),
		subset_total_credits(S, TotalCredits),
		Remaining = LowerBound - TotalCredits.

	% Calculate the percentage of credits completed for each subset
	progress_percentage(S, Percentage) :-
		map(l, S, LowerBound),
		subset_total_credits(S, TotalCredits),
		LowerBound > 0,
		Percentage = (TotalCredits * 100) / LowerBound.

	% Container for the progress bar showing percentage of completed credits
	elem(progress_bar_container(S), container, subset_container(S)) :- subset(_, S).
	attr(progress_bar_container(S), order, 4) :- subset(_, S).
	attr(progress_bar_container(S), class, ("m-1"; "pt-3"; "mt-auto")) :- subset(_, S).

	% Progress bar indicating the percentage of credits completed
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modals with module info
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Modal for displaying module information
elem(module_info_modal(E), modal, root_window) :- in(E,_).
attr(module_info_modal(E), title, @concat(E, ": ", EN)) :- in(E,_), module_program(_, EN, E, _, _).
attr(module_info_modal(E), size, "lg") :- in(E,_), module_program(_, EN, E, _, _).

% Container for the modal content
elem(module_info_container(E), container, module_info_modal(E)) :- in(E,_).
attr(module_info_container(E), child_layout, flex) :- in(E,_).
attr(module_info_container(E), flex_direction, column) :- in(E,_).
attr(module_info_container(E), class, ("justify-content-start"; "align-items-start")) :- in(E,_).

% Container for the module info text
elem(module_info_text_container(E), container, module_info_container(E)) :- in(E, m).
attr(module_info_text_container(E), order, 1) :- in(E, m).
attr(module_info_text_container(E), class, ("mt-1"; "d-flex"; "flex-row"; "justify-content-center")) :- in(E, m).

% Module info text (details like semester, program, credits, etc.)
elem(module_info_text(E), label, module_info_text_container(E)) :- in(E,_).
attr(module_info_text(E), label, @concat(
    Season, "<b> Semester:</b> ", I,
    "<br><b>Study Program:</b> ", PN,
    "<br><b>Credits:</b> ", C
)) :-
    in(E,s(I)),
    module_program(_, _, E, C, P),
    program(P, PN, _, _),
    semester_season(I, Season).

% Container for the reassignment controls
elem(module_reassign_container(E), container, module_info_container(E)) :- in(E, m).
attr(module_reassign_container(E), order, 2) :- in(E, m).
attr(module_reassign_container(E), class, ("mt-3"; "d-flex"; "flex-row"; "justify-content-center")) :- in(E, m).

% Dropdown menu for reassignment to another semester
elem(module_reassign_dropdown(E), dropdown_menu, module_reassign_container(E)) :- in(E, m).
attr(module_reassign_dropdown(E), selected, "Reassign to Semester") :- in(E, m).
attr(module_reassign_dropdown(E), class, ("btn-sm";"btn-outline-secondary"; "text-black")) :- in(E, m).

% Dropdown menu options for each available semester
elem(module_reassign_option(E,I), dropdown_menu_item, module_reassign_dropdown(E)) :- in(E, m), semester(I).
attr(module_reassign_option(E,I), label, @concat("Semester ", I)) :- in(E, m), semester(I).

% Make the current semester clickable and green for selected modules
attr(module_reassign_option(E,I), class, ("text-success"; "fw-bold")) :-
    in(E,_), semester(I), _clinguin_assume(in(E,s(I)), true).
when(module_reassign_option(E,I), click, call, (remove_assumption(in(E,s(I))), update)) :-
    in(E, m), _clinguin_assume(in(E,s(I)), true).

% Disable all other semesters when module is selected
attr(module_reassign_option(E,I), class, "disabled") :-
    in(E,_), semester(I), not _clinguin_assume(in(E,s(I)), true), _clinguin_assume(in(E,s(_)), true).

% After assumption is removed, enable semesters that satisfy _any(assignable(s(I)))
attr(module_reassign_option(E,I), class, ("text-primary"; "fw-bold")) :-
    in(E,_), semester(I), not _clinguin_assume(in(E,s(_)), true), _any(assignable(s(I))).

% Disable semesters that do not satisfy _any(assignable(s(I))) after removal
attr(module_reassign_option(E,I), class, "disabled") :-
    in(E,_), semester(I), not _clinguin_assume(in(E,s(_)), true), not _any(assignable(s(I))).

% Action to add assumption for reassignment to a new semester after removal
when(module_reassign_option(E,I), click, call, (add_assumption(in(E,s(I))), update)) :-
    in(E, m), semester(I), not _clinguin_assume(in(E,s(_)), true), _any(assignable(s(I))).


% program("{program_abbr}","{details["program_full_name"]}","{program_degree}","{program_code}","{program_version}").
% module_program("{module["id"]}","{module["title"]}","{module["abbreviation"]}","{module["credits"]}","{program_abbr}").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Menu Bar Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Configuration for the main menu bar at the top of the window
elem(menu_bar, menu_bar, root_window).
attr(menu_bar, title, "Study Regulations").
attr(menu_bar, icon, "fa-graduation-cap").

% Button to clear all assumptions
elem(menu_bar_clear, button, menu_bar).
attr(menu_bar_clear, label, "Clear").
attr(menu_bar_clear, icon, "fa-trash").
attr(menu_bar_clear, class, ("btn-sm"; "btn-outline-secondary")).
when(menu_bar_clear, click, call, clear_assumptions).

% Button to move to the next solution
elem(menu_bar_next, button, menu_bar).
attr(menu_bar_next, label, "Next").
attr(menu_bar_next, icon, "fa-forward-step").
attr(menu_bar_next, class, ("btn-sm"; "btn-outline-secondary")).
when(menu_bar_next, click, call, next_solution).

% Button to select the current solution
elem(menu_bar_select, button, menu_bar).
attr(menu_bar_select, label, "Select").
attr(menu_bar_select, icon, "fa-hand-pointer").
attr(menu_bar_select, class, ("btn-sm"; "btn-outline-secondary")).
when(menu_bar_select, click, call, select).

% Button to download the ASP model
elem(menu_bar_download_asp, button, menu_bar).
attr(menu_bar_download_asp, label, "Download ASP Model").
attr(menu_bar_download_asp, icon, "fa-download").
attr(menu_bar_download_asp, class, ("btn-sm"; "btn-outline-secondary")).
when(menu_bar_download_asp, click, call, download("#show in.", "asp_study_plan.lp")).

% Add borders to all containers (for debugging):
% attr(E,class,("border-1";"border";"border-dark")):- elem(E, container, _).