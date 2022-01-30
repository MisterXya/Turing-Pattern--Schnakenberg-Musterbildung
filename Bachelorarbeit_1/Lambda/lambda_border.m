function [g1,g2] = lambda_border(A,d,k)
% [g1,g2] = landaborder(A,d,k)
% The Lambda function rearrenged to gamma = f(Lambda,d)
k = k';
g1 = 2*k.*d.*(A(2,2)+d*A(1,1)+sqrt((A(2,2)+d*A(1,1)).^2-4*d*det(A))).^-1;
g2 = 2*k.*d.*(A(2,2)+d*A(1,1)-sqrt((A(2,2)+d*A(1,1)).^2-4*d*det(A))).^-1;
