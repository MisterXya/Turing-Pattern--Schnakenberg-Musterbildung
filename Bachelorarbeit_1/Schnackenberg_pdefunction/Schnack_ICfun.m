function u0 = Schnack_ICfun(x,P)
% u0 = Schnack_IC_fun(x,P(5) = noise): Starting point at equilibrium (u0 =
% [a+b;b/(a+b)^2]) with noise 
noise = P(5);
%Anfangspunkt
a = P(1);
b = P(2);
u0 = [a+b;b/(a+b)^2];

u0 = u0.*((1-noise) + 2*noise*rand(size(u0,2)));
