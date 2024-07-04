% Define the main window
elem(w, window, root).
attr(w, title, "Label Display").

elem(n_display, label, w).
attr(n_display, order, 1).
attr(n_display, label, @concat("Current n: ", N)) :- current_n(N).

% Generate label elements
elem(label(X), label, w) :- labels(X).
attr(label(X), order, 4) :- labels(X).
attr(label(X), label, @concat("Label ", X)) :- labels(X).


%Add a button to update n
elem(update_button, button, w).
attr(update_button, order, 3).
attr(update_button, label, "Update n").

% Define the action for the button
when(update_button, click, call, update_constant("n", _context_value(new_n_value))).


% Add a text field for input
elem(input_field, textfield, w).
attr(input_field, order, 2).
attr(input_field, placeholder, "Enter a new value for n").

% Update context when input changes
when(input_field, input, context, (new_n_value, _value)).