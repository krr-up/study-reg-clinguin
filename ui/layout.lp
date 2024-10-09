

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Layout Container
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main container for left, center, and right sections
elem(main_container, container, root_window).
attr(main_container, class, ("d-flex"; "flex-column"; "flex-lg-row"; "justify-content-between"; "align-items-start"; "m-2")).
attr(main_container, child_layout, flex).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Center Section Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Center container for semester display and controls
elem(center_section, container, main_container).
attr(center_section, order, 2).
attr(center_section, class, ("col-12"; "col-md-12"; "col-lg-8"; "pt-3"; "mb-3"; "mb-lg-0"; "d-flex"; "justify-content-center")).
attr(center_section, child_layout, flex).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Right Section Configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Right container for subsets and progress bars
elem(right_section, container, main_container).
attr(right_section, order, 3).
attr(right_section, class, ("col-12"; "col-md-12"; "col-lg-2"; "ml-lg-auto"; "mb-lg-0"; "p-3"; "d-flex"; "flex-row"; "flex-wrap"; "flex-lg-column")).
attr(right_section, child_layout, flex).


