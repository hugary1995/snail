Point(1) = {0, 0, 0, 1};
Point(2) = {0, 5, 0, 1};
Point(3) = {0, 3, 0, 1};
Point(4) = {2, 5, 0, 1};
Point(5) = {0, 7, 0, 1};
Point(6) = {0, 10, 0, 1};
Point(7) = {10, 10, 0, 1};
Point(8) = {10, 5, 0, 1};
Point(9) = {10, 7, 0, 1};
Point(10) = {8, 5, 0, 1};
Point(11) = {10, 3, 0, 1};
Point(12) = {10, 0, 0, 1};

Line(1) = {1, 3};
Circle(2) = {3, 2, 4};
Circle(3) = {4, 2, 5};
Line(4) = {5, 6};
Line(5) = {6, 7};
Line(6) = {7, 9};
Circle(7) = {9, 8, 10};
Circle(8) = {10, 8, 11};
Line(9) = {11, 12};
Line(10) = {12, 1};

Line Loop(1) = 1:10;
Plane Surface(1) = {1};
Recombine Surface {1};

Physical Surface("sample") = {1};
Physical Line("top") = {5};
Physical Line("bottom") = {10};
