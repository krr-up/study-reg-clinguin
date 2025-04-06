% Main file that includes all the UI components

% Include semester-related logic
#include "semesters.lp".

% Include layout-related logic
#include "layout.lp".

% Include module-related logic
#include "modules.lp".

% Include subset display and progress bar logic
#include "subsets.lp".

% Include modals for module info
#include "modals.lp".

% Include the main menu bar logic
#include "menu_bar.lp".

#include "exams.lp".

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Root Window Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(root_window, window, root).
attr(root_window, flex_direction, column).

%when(root_window, load, update, (module_info_modal(E), visibility, shown)) :- _clinguin_context(modal_opened,E).

%* 
elem(instances, dropdown_menu, root_window).

elem(instance(N), dropdown_menu_item, instances) :- _clinguin_instance(N).
attr(instance(N), label, N) :- _clinguin_instance(N).
when(instance(N), click, call, set_instance(N)) :- _clinguin_instance(N). *%