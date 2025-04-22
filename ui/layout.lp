%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Status Container
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elem(status_container, container, root_window).
attr(status_container, class, ("d-flex"; "flex-column"; "justify-content-center"; "align-items-center"; "m-2";"p-2")).
attr(status_container, child_layout, flex).
attr(status_container, order, 1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Layout Container
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(main_container, container, root_window).
attr(main_container, class, ("d-flex"; "flex-column"; "flex-lg-row"; "justify-content-center"; "align-items-center"; "m-2")).
attr(main_container, child_layout, flex).
attr(main_container, order, 2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Center Section Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(center_section, container, main_container).
attr(center_section, order, 1).
attr(center_section, class, ("col-12"; "col-md-12"; "col-lg-10"; "pt-3"; "mb-3"; "mb-lg-0"; "d-flex"; "justify-content-center")).
attr(center_section, child_layout, flex).
%* 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Right Section Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(right_section, container, main_container).
attr(right_section, order, 2).
attr(right_section, class, ("col-12"; "col-md-12"; "col-lg-2"; "ml-lg-auto"; "mb-lg-0"; "p-4"; "d-flex"; "flex-row"; "flex-wrap"; "flex-lg-column"; "mt-2")).
attr(right_section, child_layout, flex). *%