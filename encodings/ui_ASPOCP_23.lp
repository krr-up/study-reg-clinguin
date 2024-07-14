semester(I) :- _clinguin_const(n,N), I = 1..N.

% Root Window Configuration
elem(w, window, root).
attr(w, flex_direction, column).

% Container for 'n' value input and update button
elem(n_input_container, container, w).
attr(n_input_container, order, 1).
attr(n_input_container, flex_direction, row).
attr(n_input_container, class, ("m-2")).
attr(n_input_container, class, "align-self-center").

    % Textfield for inputting new n value
    elem(n_input, textfield, n_input_container).
    attr(n_input, order, 1).
    attr(n_input, placeholder, "Enter new n value").
    attr(n_input, width, "200px"). % Properly sized textfield
    attr(n_input, class, ("form-control"; "m-1")).
    when(n_input, input, context, (new_n_value, _value)).

    % Button to update n
    elem(update_n_button, button, n_input_container).
    attr(update_n_button, order, 2).
    attr(update_n_button, label, "Update n").
    attr(update_n_button, width, "150px"). % Properly sized button
    attr(update_n_button, class, ("btn"; "btn-secondary"; "m-1")).
    when(update_n_button, click, call, update_constant("n", _context_value(new_n_value,int))).

% Container for semesters
elem(semester_container, container, w).
attr(semester_container, order, 2).
attr(semester_container, flex_direction, row).
attr(semester_container, class, "align-self-center").

elem(s(I), container, semester_container) :- semester(I).
attr(s(I), order, I) :- semester(I).
attr(s(I), class, ("border-opacity-50";"fw-bold";"p-3";"m-2"; "rounded"; "border"; "border-secondary"; "border-2")):-semester(I).


    elem(s_t(I), container, s(I)):-semester(I).
    attr(s_t(I), order, 1):-semester(I).
    attr(s_t(I), class, ("bg-secondary";"text-light";"fw-bold";"p-2";"m-1"; "rounded")):-semester(I).


        elem(s_l(I), label, s_t(I)):-semester(I).
        attr(s_l(I), label, @concat("Semester ",I)):-semester(I).
        attr(s_l(I), order, 1):-semester(I).

        elem(s_dd(I), dropdown_menu, s_t(I)):-semester(I).
        attr(s_dd(I), order, 2):-semester(I).
        attr(s_dd(I), selected, "Assign module"):-semester(I).
        attr(s_dd(I), class, ("btn-sm";"btn-outline-light"; "m-2")):-semester(I).

            elem(s_ddi(I,E), dropdown_menu_item, s_dd(I)):-_any(in(E,s(I))), not _all(in(E,s(I))).
            attr(s_ddi(I,E), label, E):-_any(in(E,s(I))), not _all(in(E,s(I))).
            when(s_ddi(I,E), click, call, add_assumption(in(E,s(I)))):-_any(in(E,s(I))), not _all(in(E,s(I))).

    elem(s_modules(I), container, s(I)):-semester(I).
    attr(s_modules(I), class, ("bg-white")):-semester(I).
    attr(s_modules(I), order, 2):-semester(I).

        shown_module(E,I):-_all(in(E,s(I))).
        shown_module(E,I):-in(E,s(I)),_clinguin_browsing.

        elem(s_module(I,E), container, s_modules(I)):-shown_module(E,I).
        attr(s_module(I,E), height, C*10):-shown_module(E,I), map(c,E,C).
        attr(s_module(I,E), class, ("border"; "border-secondary";
                                    "d-flex";"flex-row";"justify-content-between";"align-items-center";
                                    "p-3";"m-2"; "rounded"; "border-2"; "border-opacity-50")):-shown_module(E,I).

            elem(s_module_l(I,E), label, s_module(I,E)):-shown_module(E,I).
            attr(s_module_l(I,E), label, E):-shown_module(E,I).

            elem(s_module_b(I,E), button, s_module(I,E)):-_clinguin_assume(in(E,s(I))).
            attr(s_module_b(I,E), icon, "fa-times"):-_clinguin_assume(in(E,s(I))).
            attr(s_module_b(I,E), class, ("btn-sm";"btn-outline")):-_clinguin_assume(in(E,s(I))).
            when(s_module_b(I,E), click, call, remove_assumption(in(E,s(I)))):-_clinguin_assume(in(E,s(I))).


elem(menu_bar, menu_bar, w).
attr(menu_bar, title, "Study Regulations").
attr(menu_bar, icon, "fa-graduation-cap").

elem(menu_bar_next, button, menu_bar).
attr(menu_bar_next, label, "Next").
attr(menu_bar_next, icon, "fa-forward-step").
attr(menu_bar_next, class, ("btn-sm";"btn-outline-secondary")).
when(menu_bar_next, click, call, next_solution).


