%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modals with module info
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Modal for module information
elem(module_info_modal(E), modal, root_window) :- in(E,_).
attr(module_info_modal(E), title, @concat(E)) :- in(E,_), module_program(_, _, E, _, _).
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
			attr(bottom_section(E), class, ("pt-3";"d-flex";"flex-column")) :- in(E,_).
			attr(bottom_section(E), order, 3) :- in(E,_).

                elem(action_section(E), container, bottom_section(E)) :- in(E,_).
                attr(action_section(E), class, ("d-flex";"flex-row";"justify-content-between"; "p-3"; "bg-white"; "rounded"; "shadow-sm")) :- in(E,_).
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
				attr(pref_container(E,P), disabled, true) :- _all(in(E,s(I))), not _clinguin_assume(in(E,s(I)), true), preference(P,_).

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

