%instance(0..1).

elem(w, window, root).

elem(dropdown_menu, dropdown_menu, w).
attr(dropdown_menu, label, "Select Instance").

elem(inst(I), dropdown_menu_item, dropdown_menu) :- _clinguin_instance(I).
attr(inst(I), label, I) :- _clinguin_instance(I).
when(inst(I), click, call, set_instance(I)) :- _clinguin_instance(I).

elem(selected_instance(I), label, w) :- i(I).
attr(selected_instance(I), label, I) :- i(I).
