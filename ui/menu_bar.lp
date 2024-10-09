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
