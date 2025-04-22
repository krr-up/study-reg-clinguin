%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Structure and Header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elem(exam_info_column(E), container, module_info_section(E)) :- 
    examination(_,_,_,_,E,_).
attr(exam_info_column(E), class, ("flex-grow-1"; "w-50")) :- 
    examination(_,_,_,_,E,_).
attr(exam_info_column(E), order, 2) :- 
    examination(_,_,_,_,E,_).

elem(exam_header(E), container, exam_info_column(E)) :- 
    examination(_,_,_,_,E,_).
attr(exam_header(E), class, ("mb-3"; "p-3"; "bg-white"; "rounded"; "shadow-sm")) :- 
    examination(_,_,_,_,E,_).
attr(exam_header(E), order, 1) :- 
    examination(_,_,_,_,E,_).

elem(exam_header_label(E), label, exam_header(E)) :- 
    examination(_,_,_,_,E,_).
attr(exam_header_label(E), label, "<strong>Examination Tasks</strong>") :- 
    examination(_,_,_,_,E,_).
attr(exam_header_label(E), class, ("h5"; "mb-0")) :- 
    examination(_,_,_,_,E,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Examination List
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elem(exam_list(E), container, exam_info_column(E)) :- 
    examination(_,_,_,_,E,_).
attr(exam_list(E), class, ("list-group"; "shadow-sm")) :- 
    examination(_,_,_,_,E,_).
attr(exam_list(E), order, 2) :- 
    examination(_,_,_,_,E,_).

% Individual exam items
elem(exam_item(E,ExamID), container, exam_list(E)) :- 
    examination(ExamID,_,_,_,E,_).
attr(exam_item(E,ExamID), class, ("list-group-item"; "d-flex"; "flex-column"; "justify-content-between"; "align-items-center"; "py-3")) :- 
    examination(ExamID,_,_,_,E,_).

% Individual examination items
elem(exam_item(E, ExamID), container, exam_list(E)) :- 
    examination(ExamID, Form, Title, Type, E, _).
attr(exam_item(E, ExamID), class, ("list-group-item"; "d-flex"; "justify-content-between"; "align-items-center"; "py-3")) :-
    examination(ExamID, _, _, _, E, _).
attr(exam_item(E, ExamID), order, ExamID) :- 
    examination(ExamID, _, _, _, E, _).

% Examination title and form
elem(exam_title(E, ExamID), label, exam_item(E, ExamID)) :- 
    examination(ExamID, Form, Title, _, E, _).
attr(exam_title(E, ExamID), label, @concat(Title)) :- 
    examination(ExamID, Form, Title, _, E, _).
attr(exam_title(E, ExamID), class, ("text-wrap"; "p-2"; "fw-bold")) :- 
    examination(ExamID, Form, Title, _, E, _).
attr(exam_title(E, ExamID), order, 1) :- 
    examination(ExamID, _, _, _, E, _).

% Examination type badge
elem(exam_type(E, ExamID), label, exam_item(E, ExamID)) :- 
    examination(ExamID, _, _, Type, E, _).
attr(exam_type(E, ExamID), label, Form) :- 
    examination(ExamID, Form, _, _, E, _).
attr(exam_type(E, ExamID), class, ("badge"; "rounded-pill"; "bg-primary"; "m-2")) :- 
    examination(ExamID, _, _, Type, E, _).
attr(exam_type(E, ExamID), class, "bg-success") :- 
    examination(ExamID, _, _, "PL", E, _).
attr(exam_type(E, ExamID), class, "bg-warning") :- 
    examination(ExamID, _, _, "PNL", E, _).
attr(exam_type(E, ExamID), class, "bg-info") :- 
    examination(ExamID, _, _, "SL", E, _).
attr(exam_type(E, ExamID), order, 2) :- 
    examination(ExamID, _, _, _, E, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exam Task Assignment Logic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main dropdown structure 
elem(exam_dropdown(E, ExamID), dropdown_menu, exam_item(E, ExamID)) :-
    examination(ExamID, _, _, _, E, _).
attr(exam_dropdown(E, ExamID), order, 3) :-
    examination(ExamID, _, _, _, E, _).

% Basic styling
attr(exam_dropdown(E, ExamID), class, ("m-2"; "border")) :-
    examination(ExamID, _, _, _, E, _).

% Module not assigned - disable exam assignment
attr(exam_dropdown(E, ExamID), selected, "Module must be assigned first") :-
    examination(ExamID, _, _, _, E, _),
    not shown_module(E,_).
attr(exam_dropdown(E, ExamID), class, ("btn"; "btn-sm"; "btn-secondary"; "disabled"; "text-wrap")) :-
    examination(ExamID, _, _, _, E, _),
    not shown_module(E,_).

% Default state when exam is unassigned but module is assigned
attr(exam_dropdown(E, ExamID), selected, "Assign exam to semester") :-
    examination(ExamID, _, _, _, E, _),
    shown_module(E,_),
    not _clinguin_assume(in(ExamID, e(_)), true).
attr(exam_dropdown(E, ExamID), class, ("btn"; "btn-sm"; "btn-outline-secondary"; "text-wrap")) :-
    examination(ExamID, _, _, _, E, _),
    shown_module(E,_),
    not _clinguin_assume(in(ExamID, e(_)), true).

% Exam assigned state
attr(exam_dropdown(E, ExamID), selected, @concat("Exam in Semester ", I)) :-
    examination(ExamID, _, _, _, E, _),
    _clinguin_assume(in(ExamID, e(I)), true).
attr(exam_dropdown(E, ExamID), class, ("btn"; "btn-sm"; "btn-secondary"; "text-wrap")) :-
    examination(ExamID, _, _, _, E, _),
    _clinguin_assume(in(ExamID, e(_)), true).

% Unassign option
elem(remove_exam_semester(E, ExamID), dropdown_menu_item, exam_dropdown(E, ExamID)) :-
    examination(ExamID, _, _, _, E, _),
    shown_module(E,_),
    _clinguin_assume(in(ExamID, e(_)), true).
attr(remove_exam_semester(E, ExamID), label, "Unassign exam") :-
    examination(ExamID, _, _, _, E, _),
    _clinguin_assume(in(ExamID, e(_)), true).
attr(remove_exam_semester(E, ExamID), icon, "fa-ban") :-
    examination(ExamID, _, _, _, E, _),
    _clinguin_assume(in(ExamID, e(_)), true).
attr(remove_exam_semester(E, ExamID), class, ("text-danger"; "text-opacity-75")) :-
    examination(ExamID, _, _, _, E, _),
    _clinguin_assume(in(ExamID, e(_)), true).
when(remove_exam_semester(E, ExamID), click, call, remove_assumption(in(ExamID, e(I)))) :-
    examination(ExamID, _, _, _, E, _),
    _clinguin_assume(in(ExamID, e(I)), true).

% Show semester options only if module is assigned
elem(exam_semester_option(E, ExamID, I), dropdown_menu_item, exam_dropdown(E, ExamID)) :-
    examination(ExamID, _, _, _, E, _),
    shown_module(E,_),
    semester(I),
    _any_opt(in(ExamID, e(I))).

% Currently assigned semester
attr(exam_semester_option(E, ExamID, I), label, @concat("Semester ", I, " ★")) :-
    examination(ExamID, _, _, _, E, _),
    semester(I),
    _clinguin_assume(in(ExamID, e(I)), true).

% Available semesters
attr(exam_semester_option(E, ExamID, I), label, @concat("Semester ", I)) :-
    examination(ExamID, _, _, _, E, _),
    semester(I),
    not _clinguin_assume(in(ExamID, e(I)), true).

% Style available semesters
attr(exam_semester_option(E, ExamID, I), class, "text-success") :-
    examination(ExamID, _, _, _, E, _),
    semester(I),
    _any_opt(in(ExamID, e(I))),
    not _clinguin_assume(in(ExamID, e(I)), true).

attr(exam_semester_option(E, ExamID, I), icon, "fa-face-smile") :-
    examination(ExamID, _, _, _, E, _),
    semester(I),
    _any_opt(in(ExamID, e(I))),
    not _clinguin_assume(in(ExamID, e(I)), true).

% Style assigned semester
attr(exam_semester_option(E, ExamID, I), class, ("text-secondary"; "disabled")) :-
    examination(ExamID, _, _, _, E, _),
    semester(I),
    _clinguin_assume(in(ExamID, e(I)), true).

% Semester order
attr(exam_semester_option(E, ExamID, I), order, I) :-
    examination(ExamID, _, _, _, E, _),
    semester(I).

% Click handler - only if module is assigned
when(exam_semester_option(E, ExamID, I), click, call, add_assumption(in(ExamID, e(I)))) :-
    examination(ExamID, _, _, _, E, _),
    shown_module(E,_),
    semester(I),
    _any_opt(in(ExamID, e(I))),
    not _clinguin_assume(in(ExamID, e(I)), true).