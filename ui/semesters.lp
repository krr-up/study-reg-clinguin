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

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Center Section Configuration - Semester Control
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
    % Semester Display
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Display list of semesters
    elem(semester_display_container, container, center_section).
    attr(semester_display_container, order, 2).
    attr(semester_display_container, class, ("d-flex"; "flex-wrap"; "flex-row"; "justify-content-center"; "align-items-start"; "w-100")).

    % Individual semester containers
    elem(semester_container(I), container, semester_display_container) :- semester(I).
    attr(semester_container(I), order, I) :- semester(I).
    attr(semester_container(I), class, ("border-opacity-50"; "fw-bold"; "p-3"; "m-2"; "rounded"; "border"; "border-2"; "bg-light")) :- semester(I).
    attr(semester_container(I), class, ("border-warning")) :- semester(I), empty(int(m(w), s(I))).
    attr(semester_container(I), class, ("border-primary")) :- semester(I), empty(int(m(s), s(I))).

    % Header for each semester
    elem(semester_header_container(I), container, semester_container(I)) :- semester(I).
    attr(semester_header_container(I), order, 1) :- semester(I).
    attr(semester_header_container(I), class, ("text-dark";"fw-bold";"p-2";"m-1"; "rounded")) :- semester(I).

    % Label for semester headers
    elem(semester_label(I), label, semester_header_container(I)) :- semester(I).
    attr(semester_label(I), label, @concat(Season, " Semester ",I)) :- semester(I), semester_season(I, Season).
    attr(semester_label(I), order, 1) :- semester(I).
