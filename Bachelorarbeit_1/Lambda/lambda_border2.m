function [z1,z2] = lambda_border2(A,d,g)
% [z1,z2] = landa_border2(A,d,k)
% The function Lambda depending on d,k
d_ = d.^-1;
g = g';
z1 = g/2.*d_.*(A(2,2)+d*A(1,1)+sqrt((A(2,2)+d*A(1,1)).^2-4*d*det(A)));
z2 = g/2.*d_.*(A(2,2)+d*A(1,1)-sqrt((A(2,2)+d*A(1,1)).^2-4*d*det(A)));

