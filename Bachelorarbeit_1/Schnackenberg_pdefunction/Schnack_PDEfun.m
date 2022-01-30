function [c,f,s] = Schnack_PDEfun(~,~,u,dudx,P)
%Defintion of f,d,s function for pdepe.
%So the PDE looks like: c*dudt = dudx*f+s
a = P(1);
b = P(2);
d = P(3);
g = P(4);
c = [1;1];
f = [1;d].*dudx;
s = [g*(a-u(1)+u(1)^2*u(2));g*(b-u(1)^2*u(2))];