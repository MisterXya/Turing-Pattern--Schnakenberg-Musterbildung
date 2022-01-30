function u0 = Schnack_linICfun(~,P)
%u0 = noise*rand(size(u0)): 0 as starting point and equilbrium
noise = P(5);
u0 = [0;0];
%u0 = noise*rand(size(u0));
u0 = noise*rand(size(u0))-0.5;
