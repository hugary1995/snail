Point(1) = {0, 0, 0, 1};
Point(2) = {0, 0.499, 0, 1};
Point(3) = {0.5, 0.5, 0, 1};
Point(4) = {0, 0.501, 0, 1};
Point(5) = {0, 1, 0, 1};
Point(6) = {0.5, 1, 0, 1};
Point(7) = {2, 1, 0, 1};
Point(8) = {2, 0.5, 0, 1};
Point(9) = {2, 0, 0, 1};
Point(10) = {0.5, 0, 0, 1};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 5};
Line(5) = {5, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Line(8) = {8, 9};
Line(9) = {9, 10};
Line(10) = {10, 1};
Line(11) = {3, 6};
Line(12) = {3, 8};
Line(13) = {3, 10};

Line Loop(1) = {1, 2, 13, 10};
Line Loop(2) = {3, 4, 5, -11};
Line Loop(3) = {11, 6, 7, -12};
Line Loop(4) = {-13, 12, 8, 9};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};

Transfinite Line {10, 2, 3, 5} = 11;
Transfinite Line {1, 13, 8} = 11;
Transfinite Line {4, 11, 7} = 11;
Transfinite Line {9, 12, 6} = 31;
Transfinite Surface {1:4};
Recombine Surface {1:4};

Physical Surface("all") = {1, 2, 3, 4};
Physical Line("left_upper") = {4};
Physical Line("left_lower") = {1};
Physical Line("right") = {7, 8};
Physical Line("top") = {5, 6};
Physical Line("bottom") = {9, 10};
