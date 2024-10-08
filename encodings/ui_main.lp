%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Semester Definition and Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the range of semesters based on 'n'
semester(I) :- _clinguin_const(n,N), I = 1..N.

% Possible values for the number of semesters
values(3..8).

% Determine the season for each semester
semester_season(I, "<i class='fa fa-snowflake'></i>") :- semester(I), empty(int(m(s), s(I))).
semester_season(I, "<i class='fa fa-sun'></i>") :- semester(I), empty(int(m(w), s(I))).

when(root_window, load, update, (module_info_modal(E), visibility, shown)) :- _clinguin_context(modal_opened,E).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Root Window Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set root window layout to column
elem(root_window, window, root).
attr(root_window, flex_direction, column).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Layout Container
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main container for left, center, and right sections
elem(main_container, container, root_window).
attr(main_container, class, ("d-flex"; "flex-column"; "flex-lg-row"; "justify-content-between"; "align-items-start"; "m-2")).
attr(main_container, child_layout, flex).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Center Section Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Center container for semester display and controls
elem(center_section, container, main_container).
attr(center_section, order, 2).
attr(center_section, class, ("col-12"; "col-md-12"; "col-lg-8"; "pt-3"; "mb-3"; "mb-lg-0"; "d-flex"; "justify-content-center")).
attr(center_section, child_layout, flex).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Container for Semester Count and Update Control
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Display current number of semesters with update option
    elem(semester_control_container, container, center_section).
    attr(semester_control_container, order, 4).
    attr(semester_control_container, flex_direction, column).
    attr(semester_control_container, class, ("m-2")).
    attr(semester_control_container, class, "align-self-center").

    % Label showing current number of semesters
    elem(semester_count_label, label, semester_control_container).
    attr(semester_count_label, label, @concat("Current number of semesters: ", N)) :- _clinguin_const(n, N).
    attr(semester_count_label, order, 1).
    attr(semester_count_label, class, ("fw-bold"; "p-2"; "m-2")).

    % Dropdown menu to select the number of semesters
    elem(semester_dropdown, dropdown_menu, semester_control_container).
    attr(semester_dropdown, order, 2).
    attr(semester_dropdown, selected, "Change").
    attr(semester_dropdown, class, ("btn-sm"; "btn-secondary"; "p-2"; "m-2")).

    % Dropdown options for selecting semesters
    elem(semester_option(V), dropdown_menu_item, semester_dropdown) :- values(V).
    attr(semester_option(V), label, V) :- values(V).
    when(semester_option(V), click, call, set_constant("n", V)) :- values(V).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Container for Semester Display
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Display list of semesters
    elem(semester_display_container, container, center_section).
    attr(semester_display_container, order, 2).
    attr(semester_display_container, class, ("d-flex"; "flex-wrap"; "flex-row"; "justify-content-center"; "align-items-start"; "w-100")).

    % Individual semester containers
    elem(semester_container(I), container, semester_display_container) :- semester(I).
    attr(semester_container(I), order, I) :- semester(I).
    attr(semester_container(I), class, ("border-opacity-50"; "fw-bold"; "p-3"; "m-2"; "rounded"; "border"; "border-2"; "bg-light")) :- semester(I).
    attr(semester_container(I), class, ("border-warning")) :- semester(I), empty(int(m(s), s(I))).
    attr(semester_container(I), class, ("border-primary")) :- semester(I), empty(int(m(w), s(I))).

    % Header for each semester
    elem(semester_header_container(I), container, semester_container(I)) :- semester(I).
    attr(semester_header_container(I), order, 1) :- semester(I).
    attr(semester_header_container(I), class, ("text-dark";"fw-bold";"p-2";"m-1"; "rounded")) :- semester(I).

    % Label for semester headers
    elem(semester_label(I), label, semester_header_container(I)) :- semester(I).
    attr(semester_label(I), label, @concat(Season, " Semester ",I)) :- semester(I), semester_season(I, Season).
    attr(semester_label(I), order, 1) :- semester(I).

    % Dropdown for assigning modules to a semester
    elem(assign_module_dropdown(I), dropdown_menu, semester_header_container(I)) :- semester(I).
    attr(assign_module_dropdown(I), order, 2) :- semester(I).
    attr(assign_module_dropdown(I), selected, "Assign module") :- semester(I).
    attr(assign_module_dropdown(I), class, ("btn-sm";"btn-outline-dark"; "m-2")) :- semester(I).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Dropdown Menu Items for Module Assignment
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Dropdown menu items to assign modules
    module_addable_to_semester(E,I) :- in(E,_),semester(I), not _all(in(E,s(I))).
    elem(assign_module_option(I,E), dropdown_menu_item, assign_module_dropdown(I)) :- module_addable_to_semester(E, I).
    attr(assign_module_option(I,E), label, @concat(E, " (", C, " ECTS)")) :- module_addable_to_semester(E, I), map(c, E, C).
    attr(assign_module_option(I,E), class, "disabled") :- module_addable_to_semester(E,I), not _any(in(E,s(I))).
    attr(assign_module_option(I,E), class, "opacity-50") :- module_addable_to_semester(E,I), not _any(in(E,s(I))).

    attr(assign_module_option(I,E), class, "text-success") :- module_addable_to_semester(E, I), user_preference(include(_),E).
    attr(assign_module_option(I,E), class, "text-danger") :- module_addable_to_semester(E, I), user_preference(exclude(_),E).
    attr(assign_module_option(I,E), icon, ("fa-solid";"fa-thumbs-up")) :- module_addable_to_semester(E, I), user_preference(include(hard),E).
    attr(assign_module_option(I,E), icon, ("fa-regular";"fa-thumbs-up")) :- module_addable_to_semester(E, I), user_preference(include(soft),E).
    attr(assign_module_option(I,E), icon, ("fa-regular";"fa-thumbs-down")) :- module_addable_to_semester(E, I), user_preference(exclude(soft),E).
    attr(assign_module_option(I,E), icon, ("fa-solif";"fa-thumbs-down")) :- module_addable_to_semester(E, I), user_preference(exclude(hard),E).

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

    % Container for displayed modules
    elem(displayed_module(I,E), container, semester_modules_container(I)) :- shown_module(E,I).
    attr(displayed_module(I,E), height, C*12) :- shown_module(E,I), map(c,E,C).
    attr(displayed_module(I,E), width, 200) :- shown_module(E,I).
    attr(displayed_module(I,E), class, ("border"; "border-secondary"; "d-flex";"flex-row";"justify-content-between";"align-items-center"; "p-3";"m-2"; "rounded"; "border-2"; "border-opacity-50"; "bg-white")) :- shown_module(E,I).
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

    % Button to remove a module from a semester
    elem(remove_module_button(I,E), button, displayed_module_b(I,E)) :- _clinguin_assume(in(E,s(I)), true).
    attr(remove_module_button(I,E), icon, "fa-times") :- _clinguin_assume(in(E,s(I)), true).
    attr(remove_module_button(I,E), class, ("p-2"; "ms-auto"; "border-0"; "bg-transparent"; "text-secondary"; "small")) :- _clinguin_assume(in(E,s(I)), true).
    when(remove_module_button(I,E), click, call, remove_assumption(in(E,s(I)))) :- _clinguin_assume(in(E,s(I)), true).

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Display of Total Credits for Each Semester
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Container for total credits under each semester
    elem(semester_credits_container(I), container, semester_container(I)) :- semester(I).
    attr(semester_credits_container(I), order, 3) :- semester(I).
    attr(semester_credits_container(I), class, ("bg-light"; "p-2"; "mt-2"; "rounded"; "text-center"; "fw-bold"; "mt-auto")) :- semester(I).

    % Label to display total credits for a semester
    elem(semester_credits_label(I), label, semester_credits_container(I)) :- semester(I).
    attr(semester_credits_label(I), label, @concat(SC, " ECTS")) :-
        semester(I),
        SC = #sum{ C,E : map(c,E,C), shown_module(E,I) }.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Display of Total Credits at the Top of the Page
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Container to display total credits across all semesters
    elem(total_credits_display_container, container, center_section).
    attr(total_credits_display_container, order, 1).
    attr(total_credits_display_container, class, ("bg-secondary"; "text-white"; "p-3"; "rounded"; "m-2"; "align-self-center")).

    % Label to display total credits
    elem(total_credits_label, label, total_credits_display_container).
    attr(total_credits_label, label, @concat("Total credits: ", TC)) :-
        TC = #sum{ C,E : map(c,E,C), shown_module(E,_) }.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Right Section Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Right container for subsets and progress bars
elem(right_section, container, main_container).
attr(right_section, order, 3).
attr(right_section, class, ("col-12"; "col-md-12"; "col-lg-2"; "ml-lg-auto"; "mb-lg-0"; "p-3"; "d-flex"; "flex-row"; "flex-wrap"; "flex-lg-column")).
attr(right_section, child_layout, flex).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Containers for Module Subsets
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Subsets of modules
	subset(E,S) :- map(l, S, _); map(u, S, _), in(E, S).

	% Containers for subsets of modules
	elem(subset_container(S), container, right_section) :- subset(E,S).
	attr(subset_container(S), class, ("border-opacity-50";"fw-bold";"p-2";"rounded"; "border"; "border-secondary"; "border-2"; "col-12"; "col-sm-12"; "col-md-12"; "d-flex"; "flex-column")) :- subset(E,S).
	attr(subset_container(S), flex_direction, column) :- subset(E,S).
	attr(subset_container(S), order, 2) :- subset(E,S).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Labels for Module Subsets
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Label container for subsets
	elem(subset_label_container(S), container, subset_container(S)):-subset(E,S).
	attr(subset_label_container(S), order, 1):-subset(E,S).
	attr(subset_label_container(S), class, ("bg-secondary";"text-light";"fw-bold";"p-2";"mt-2";"mb-2";"rounded")):-subset(E,S).

	% Label text for subsets
	elem(subset_label(S), label, subset_label_container(S)):-subset(E,S).
	attr(subset_label(S), label, @concat("Modules ", S)):-subset(E,S), S != m.
	attr(subset_label(S), label, "All Modules"):-subset(E,m), S == m.
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
	attr(subset_module_button(E,S), label, E) :- in(E,S), subset(E,S).
	attr(subset_module_button(E,S), class, ("btn-sm"; "m-1")) :- in(E,S), subset(E,S).
	attr(subset_module_button(E,S), class, "btn-secondary") :- in(E,S), subset(E,S), module_visibly_selected(E).
	attr(subset_module_button(E,S), class, "btn-outline-secondary") :- in(E,S), subset(E,S), not module_visibly_selected(E).
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modals with module info
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Modal for module information
elem(module_info_modal(E), modal, root_window) :- in(E,_).
attr(module_info_modal(E), title, @concat(E, ": ", EN)) :- in(E,_), module_program(_, EN, E, _, _).
attr(module_info_modal(E), size, "lg") :- in(E,_), module_program(_, EN, E, _, _).

	% Main container for modal content
	elem(module_info_container(E), container, module_info_modal(E)) :- in(E,_).
	attr(module_info_container(E), class, ("p-4"; "bg-light"; "rounded")) :- in(E,_).

		% Header section
		elem(module_header(E), container, module_info_container(E)) :- in(E,_).
		attr(module_header(E), class, ("mb-4"; "pb-3"; "border-bottom")) :- in(E,_).
		attr(module_header(E), order, 1) :- in(E,_).

			% Module title
			elem(module_title(E), label, module_header(E)) :- module_program(_, EN, E, _, _).
			attr(module_title(E), label, EN) :- module_program(_, EN, E, _, _).
			attr(module_title(E), class, ("h4"; "fw-bold"; "mb-2")) :- module_program(_, _, E, _, _).
			attr(module_title(E), order, 1) :- module_program(_, _, E, _, _).

			% Module ID
			elem(module_id(E), label, module_header(E)) :- module_program(MID, _, E, _, _).
			attr(module_id(E), label, @concat("Module ID: ", MID)) :- module_program(MID, _, E, _, _).
			attr(module_id(E), class, ("text-muted"; "ms-2")) :- module_program(_, _, E, _, _).
			attr(module_id(E), order, 2) :- module_program(_, _, E, _, _).

		% Main info section
		elem(module_info_section(E), container, module_info_container(E)) :- in(E,_).
		attr(module_info_section(E), class, ("d-flex"; "flex-column"; "flex-md-row"; "gap-4")) :- in(E,_).
		attr(module_info_section(E), order, 2) :- in(E,_).

			% Left column: Basic info
			elem(basic_info_column(E), container, module_info_section(E)) :- in(E,_).
			attr(basic_info_column(E), class, ("flex-grow-1"; "w-100")) :- in(E,_), not examination(_, _, _, _, E, _).
			attr(basic_info_column(E), class, ("flex-grow-1"; "w-50")) :- in(E,_), examination(_, _, _, _, E, _).
			attr(basic_info_column(E), order, 1) :- in(E,_).

				% Basic Info Header
				elem(basic_info_header(E), container, basic_info_column(E)) :- in(E,_).
				attr(basic_info_header(E), class, ("mb-3"; "p-3"; "bg-white"; "rounded"; "shadow-sm")) :- in(E,_).
				attr(basic_info_header(E), order, 1) :- in(E,_).

					elem(basic_info_label(E), label, basic_info_header(E)) :- in(E,_).
					attr(basic_info_label(E), label, "<strong>Basic Information</strong>") :- in(E,_).
					attr(basic_info_label(E), class, ("h5"; "mb-0")) :- in(E,_).

				% Program info
				elem(program_info(E), container, basic_info_column(E)) :- module_program(_, _, E, _, P), program(P, PN, D, V).
				attr(program_info(E), class, ("mb-3"; "p-3"; "bg-white"; "rounded"; "shadow-sm")) :- module_program(_, _, E, _, _).
				attr(program_info(E), order, 2) :- module_program(_, _, E, _, _).

					elem(program_label(E), label, program_info(E)) :- module_program(_, _, E, _, P), program(P, PN, D, V).
					attr(program_label(E), label, @concat("<div class='mb-2'><strong>Program:</strong> ", PN, " (", P, ")</div>",
														"<div class='mb-2'><strong>Degree:</strong> ", D, "</div>",
														"<div><strong>Version:</strong> ", V, "</div>")) :-
						module_program(_, _, E, _, P), program(P, PN, D, V).

				% Credits
				elem(credits_info(E), container, basic_info_column(E)) :- module_program(_, _, E, C, _).
				attr(credits_info(E), class, ("mb-3"; "p-3"; "bg-white"; "rounded"; "shadow-sm")) :- module_program(_, _, E, _, _).
				attr(credits_info(E), order, 3) :- module_program(_, _, E, _, _).

					elem(credits_label(E), label, credits_info(E)) :- module_program(_, _, E, C, _).
					attr(credits_label(E), label, @concat("<strong>Credits:</strong> ", C)) :- module_program(_, _, E, C, _).

				% Semester assignment (if assigned)
				elem(semester_info(E), container, basic_info_column(E)) :- in(E, s(I)), semester_season(I, Season).
				attr(semester_info(E), class, ("mb-3"; "p-3"; "bg-white"; "rounded"; "shadow-sm")) :- in(E, s(_)).
				attr(semester_info(E), order, 4) :- in(E, s(_)).

					elem(semester_label(E), label, semester_info(E)) :- in(E, s(I)), semester_season(I, Season).
					attr(semester_label(E), label, @concat("<strong>Assigned to:</strong> ", Season, " Semester ", I)) :-
						in(E, s(I)), semester_season(I, Season).

			% Right column: Examinations (only if examinations exist)
			elem(exam_info_column(E), container, module_info_section(E)) :- examination(_, _, _, _, E, _).
			attr(exam_info_column(E), class, ("flex-grow-1"; "w-50")) :- examination(_, _, _, _, E, _).
			attr(exam_info_column(E), order, 2) :- examination(_, _, _, _, E, _).

				% Examinations header
				elem(exam_header(E), container, exam_info_column(E)) :- examination(_, _, _, _, E, _).
				attr(exam_header(E), class, ("mb-3"; "p-3"; "bg-white"; "rounded"; "shadow-sm")) :- examination(_, _, _, _, E, _).
				attr(exam_header(E), order, 1) :- examination(_, _, _, _, E, _).

					elem(exam_header_label(E), label, exam_header(E)) :- examination(_, _, _, _, E, _).
					attr(exam_header_label(E), label, "<strong>Examinations</strong>") :- examination(_, _, _, _, E, _).
					attr(exam_header_label(E), class, ("h5"; "mb-0")) :- examination(_, _, _, _, E, _).

				% List of examinations
				elem(exam_list(E), container, exam_info_column(E)) :- examination(_, _, _, _, E, _).
				attr(exam_list(E), class, ("list-group"; "shadow-sm")) :- examination(_, _, _, _, E, _).
				attr(exam_list(E), order, 2) :- examination(_, _, _, _, E, _).

					% Individual examination items
					elem(exam_item(E, ExamID), container, exam_list(E)) :- examination(ExamID, Form, Title, Type, E, _).
					attr(exam_item(E, ExamID), class, ("list-group-item"; "d-flex"; "justify-content-between"; "align-items-center"; "py-3")) :-
						examination(ExamID, _, _, _, E, _).
					attr(exam_item(E, ExamID), order, ExamID) :- examination(ExamID, _, _, _, E, _).

						% Examination title and form
						elem(exam_title(E, ExamID), label, exam_item(E, ExamID)) :- examination(ExamID, Form, Title, _, E, _).
						attr(exam_title(E, ExamID), label, @concat(Title, " (", Form, ")")) :- examination(ExamID, Form, Title, _, E, _).
						attr(exam_title(E, ExamID), class, ("text-wrap"; "pe-2")) :- examination(ExamID, Form, Title, _, E, _).
						attr(exam_title(E, ExamID), order, 1) :- examination(ExamID, _, _, _, E, _).

						% Examination type badge
						elem(exam_type(E, ExamID), label, exam_item(E, ExamID)) :- examination(ExamID, _, _, Type, E, _).
						attr(exam_type(E, ExamID), label, Type) :- examination(ExamID, _, _, Type, E, _).
						attr(exam_type(E, ExamID), class, ("badge"; "rounded-pill"; "bg-primary"; "ms-2")) :- examination(ExamID, _, _, Type, E, _).
						attr(exam_type(E, ExamID), class, "bg-success") :- examination(ExamID, _, _, "PL", E, _).
						attr(exam_type(E, ExamID), class, "bg-warning") :- examination(ExamID, _, _, "PNL", E, _).
						attr(exam_type(E, ExamID), class, "bg-info") :- examination(ExamID, _, _, "SL", E, _).
						attr(exam_type(E, ExamID), order, 2) :- examination(ExamID, _, _, _, E, _).

			% Action section
            elem(bottom_section(E), container, module_info_container(E)) :- in(E,_).
			attr(bottom_section(E), class, ("mt-4"; "pt-3";"d-flex";"flex-column")) :- in(E,_).
			attr(bottom_section(E), order, 3) :- in(E,_).

                elem(action_section(E), container, bottom_section(E)) :- in(E,_).
                attr(action_section(E), class, ("mt-4"; "pt-3";"d-flex";"flex-row";"justify-content-between")) :- in(E,_).
                attr(action_section(E), order, 1) :- in(E,_).

                %Preference container
				elem(pref_container(E), container, action_section(E)) :- in(E,_),use_preferences.
				attr(pref_container(E), class, ("d-flex";"flex-column")) :- in(E,_),use_preferences.

				elem(pref_container(E,P), checkbox, pref_container(E)) :- in(E,_), preference(P,M).
				attr(pref_container(E,P), label, M) :- in(E,_), preference(P,M).
				attr(pref_container(E,P), checked, true) :- in(E,_), user_preference(P,E).
				when(pref_container(E,P), click, call, set_external(user_preference(P,E),false)) :- in(E,_), preference(P,M), user_preference(P,E).
				when(pref_container(E,P), click, call, set_external(user_preference(P,E),true)) :- in(E,_), preference(P,M), not user_preference(P,E).
				when(pref_container(E,P), click, context, (modal_opened,E)) :- in(E,_), preference(P,M).

				attr(pref_container(E,P), disabled, true) :- in(E,_), user_preference(P',E), preference(P,_), P'!=P.
				attr(pref_container(E,include(hard;soft)), disabled, true) :- in(E,_), not _any(in(E,s(_))),use_preferences.
				attr(pref_container(E,exclude(hard;soft)), disabled, true) :- in(E,_), _all(in(E,s(_))),use_preferences.




				% Button container
				elem(button_container(E), container, action_section(E)) :- in(E,_).
				attr(button_container(E), class, ("d-flex"; "justify-content-between"; "align-items-center"; "mb-3")) :- in(E,_).
				attr(button_container(E), order, 1) :- in(E,_).

					% Dropdown for assigning unassigned modules to a semester
					elem(assign_semester_dropdown(E), dropdown_menu, button_container(E)) :- not _all(in(E, s(_))), module_program(_, _, E, _, _).
					attr(assign_semester_dropdown(E), selected, "Assign to semester") :- not _all(in(E, s(_))), module_program(_, _, E, _, _).
					attr(assign_semester_dropdown(E), class, ("btn"; "btn-outline-primary")) :- not _all(in(E, s(_))), module_program(_, _, E, _, _).

						% Dropdown options to assign a module to a semester
						elem(assign_semester_option(E, I), dropdown_menu_item, assign_semester_dropdown(E)) :-
							module_program(_, _, E, _, _), semester(I), not _all(in(E, s(_))).
						attr(assign_semester_option(E, I), label, @concat("Semester ", I)) :-
							module_program(_, _, E, _, _), semester(I), not _all(in(E, s(_))).
						attr(assign_semester_option(E, I), class, "text-success") :-
							module_program(_, _, E, _, _), semester(I), _any_opt(in(E, s(I))).
						attr(assign_semester_option(E, I), class, "text-warning") :-
							module_program(_, _, E, _, _), semester(I), _any(in(E, s(I))), not _any_opt(in(E, s(I))).
						attr(assign_semester_option(E, I), class, ("text-muted"; "disabled")) :-
							module_program(_, _, E, _, _), semester(I), not _any(in(E, s(I))).
						attr(assign_semester_option(E, I), order, I) :-
							module_program(_, _, E, _, _), semester(I), not _all(in(E, s(_))).
						when(assign_semester_option(E, I), click, call, add_assumption(in(E, s(I)))) :-
							module_program(_, _, E, _, _), semester(I), _any(in(E, s(I))), not _all(in(E, s(_))).

					% Button to unassign a module from a semester
					elem(unassign_module_button(E), button, button_container(E)) :- _clinguin_assume(in(E, s(I)), true).
					attr(unassign_module_button(E), label, "Unassign Module") :- _clinguin_assume(in(E, s(I)), true).
					attr(unassign_module_button(E), icon, "fa-times") :- _clinguin_assume(in(E, s(I)), true).
					attr(unassign_module_button(E), class, ("btn"; "btn-outline-danger")) :- _clinguin_assume(in(E, s(I)), true).
					when(unassign_module_button(E), click, call, remove_assumption(in(E, s(I)))) :- _clinguin_assume(in(E, s(I)), true).

				% Examination Legend
				elem(exam_legend(E), container, bottom_section(E)) :- in(E,_).
				attr(exam_legend(E), class, ("mt-3"; "p-3"; "border-top"; "bg-light")) :- in(E,_).
				attr(exam_legend(E), order, 2) :- in(E,_).

					% Header
					elem(exam_legend_header(E), label, exam_legend(E)) :- in(E,_).
					attr(exam_legend_header(E), label, "Examination Types:") :- in(E,_).
					attr(exam_legend_header(E), class, ("fw-bold"; "mb-2"; "d-block"; "small")) :- in(E,_).
					attr(exam_legend_header(E), order, 1) :- in(E,_).

					% Legend container
					elem(exam_legend_content(E), container, exam_legend(E)) :- in(E,_).
					attr(exam_legend_content(E), class, ("d-flex"; "flex-row"; "gap-2"; "align-items-center")) :- in(E,_).
					attr(exam_legend_content(E), order, 2) :- in(E,_).

						% PL badge
						elem(exam_legend_pl_badge(E), label, exam_legend_content(E)) :- in(E,_).
						attr(exam_legend_pl_badge(E), label, "PL") :- in(E,_).
						attr(exam_legend_pl_badge(E), class, ("badge"; "rounded-pill"; "bg-success"; "small"; "px-2"; "py-1")) :- in(E,_).

						% PL text
						elem(exam_legend_pl_text(E), label, exam_legend_content(E)) :- in(E,_).
						attr(exam_legend_pl_text(E), label, "Primary Examination (graded)") :- in(E,_).
						attr(exam_legend_pl_text(E), class, ("small"; "me-2")) :- in(E,_).

						% PNL badge
						elem(exam_legend_pnl_badge(E), label, exam_legend_content(E)) :- in(E,_).
						attr(exam_legend_pnl_badge(E), label, "PNL") :- in(E,_).
						attr(exam_legend_pnl_badge(E), class, ("badge"; "rounded-pill"; "bg-warning"; "small"; "px-2"; "py-1")) :- in(E,_).

						% PNL text
						elem(exam_legend_pnl_text(E), label, exam_legend_content(E)) :- in(E,_).
						attr(exam_legend_pnl_text(E), label, "Secondary Examination") :- in(E,_).
						attr(exam_legend_pnl_text(E), class, ("small"; "me-2")) :- in(E,_).

						% SL badge
						elem(exam_legend_sl_badge(E), label, exam_legend_content(E)) :- in(E,_).
						attr(exam_legend_sl_badge(E), label, "SL") :- in(E,_).
						attr(exam_legend_sl_badge(E), class, ("badge"; "rounded-pill"; "bg-info"; "small"; "px-2"; "py-1")) :- in(E,_).

						% SL text
						elem(exam_legend_sl_text(E), label, exam_legend_content(E)) :- in(E,_).
						attr(exam_legend_sl_text(E), label, "Ungraded Academic Achievement") :- in(E,_).
						attr(exam_legend_sl_text(E), class, ("small")) :- in(E,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Menu Bar Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main menu bar configuration
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
when(menu_bar_next, click, call, next_solution(optN)).

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
