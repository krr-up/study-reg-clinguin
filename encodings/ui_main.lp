% Main file that includes all the UI components

% Include semester-related logic
#include "ui/semesters.lp".

% Include layout-related logic
#include "ui/layout.lp".

% Include module-related logic
#include "ui/modules.lp".

% Include subset display and progress bar logic
#include "ui/subsets.lp".

% Include modals for module info
#include "ui/modals.lp".

% Include the main menu bar logic
#include "ui/menu_bar.lp".


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Root Window Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(root_window, window, root).
attr(root_window, flex_direction, column).

when(root_window, load, update, (module_info_modal(E), visibility, shown)) :- _clinguin_context(modal_opened,E).
