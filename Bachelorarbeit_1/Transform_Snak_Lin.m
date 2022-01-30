function A = Transform_Snak_Lin(a,b)
A(1,1) = -1+2*b/(a+b);
A(1,2) = 2*(a+b)^2;
A(2,1) = -b/(a+b);
A(2,2) = -2*(a+b)^2;