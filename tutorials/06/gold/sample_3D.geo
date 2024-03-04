Point(1) = {0, 0, 0, 1};
Point(2) = {0, 10, 0, 1};
Point(3) = {5, 10, 0, 1};
Point(4) = {5, 5, 0, 1};
Point(5) = {5, 7, 0, 1};
Point(6) = {3, 5, 0, 1};
Point(7) = {5, 3, 0, 1};
Point(8) = {5, 0, 0, 1};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 5};
Circle(4) = {5, 4, 6};
Circle(5) = {6, 4, 7};
Line(6) = {7, 8};
Line(7) = {8, 1};

Line Loop(1) = 1:7;
Plane Surface(1) = {1};

Extrude {{0, 1, 0}, {0, 0, 0}, Pi/2} {
  Surface{1};
}
Extrude {{0, 1, 0}, {0, 0, 0}, Pi/2} {
  Surface{39};
}
Extrude {{0, 1, 0}, {0, 0, 0}, Pi/2} {
  Surface{71};
}
Extrude {{0, 1, 0}, {0, 0, 0}, Pi/2} {
  Surface{103};
}

Compound Volume {1, 2, 3, 4};

Physical Volume("sample") = {1, 2, 3, 4};
Physical Surface("top") = {19, 51, 83, 115};
Physical Surface("bottom") = {38, 70, 102, 134};
