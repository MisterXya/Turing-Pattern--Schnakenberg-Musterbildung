function [u1,u2,u1_end,u2_end] = Schnackenberg_t_change(Obj,j_t,noise)
% Gives the Solution of Schnackenberg with different solutions along noise

%% Basics Variables
if nargin < 3
    noise = Obj.noise;
end
k_t = length(j_t);
P = [Obj.a,Obj.b,Obj.d,Obj.g,noise];
tspan = 0:0.01:j_t(end);

u1 = zeros(length(tspan),length(Obj.xspan),k_t);
u2 = zeros(length(tspan),length(Obj.xspan),k_t);
u1_end = zeros(length(Obj.xspan),k_t);
u2_end = zeros(length(Obj.xspan),k_t);

%%Solution
for i_t  =  1:k_t
   temp_tspan = 0:0.01:j_t(i_t);
    rng(Obj.rng_seed);
    sol = pdepe(0,@Schnack_PDEfun,@Schnack_ICfun,@Schnack_BCfun,Obj.xspan,temp_tspan,[],P);
    u1(1:length(temp_tspan),:,i_t) = sol(:,:,1);
    u2(1:length(temp_tspan),:,i_t) = sol(:,:,2);
    u1_end(:,i_t) = sol(length(temp_tspan),:,1);
    u2_end(:,i_t) = sol(length(temp_tspan),:,2);
end
