function [u1,u2] =  Sol_Schnack_linsolv(Sol_Schnack,varargin)
% Solves for the grid of g and d the linearisation of Schnackenberg with pdepe and
% safes for each grid point g/d the last temporal solution of the PDE.
% With the optinal parameter 'rng_seed_set', false you will deactivate the seed
% setting of Sol_Schnack_linsolv. In the standard Setting it uses the
% rng_seed of the class.

%% Handeling with optional paramaters RNG and display and optional argument noise
% Default setting
defaultrng_seed_set = true;

input = inputParser;
addParameter(input,'rng_seed_set',defaultrng_seed_set,@islogical);
parse(input,varargin{:});

%% Definiton and reservation of the Variables
xspan = Sol_Schnack.xspan;
tspan = Sol_Schnack.tspan;
P = [Sol_Schnack.a,Sol_Schnack.b,0,0,Sol_Schnack.noise]; %d,g will be filled later

u1 = zeros(Sol_Schnack.x_k,Sol_Schnack.k_g,Sol_Schnack.k_d);
u2 = zeros(Sol_Schnack.x_k,Sol_Schnack.k_g,Sol_Schnack.k_d);

%% Calculation

for i_d = 1:Sol_Schnack.k_d
    P(3) = Sol_Schnack.j_d(i_d);
    for i_g = 1:Sol_Schnack.k_g
        P(4) = Sol_Schnack.j_g(i_g);
        %Setting the Rng seed if required
        if input.Results.rng_seed_set
            rng(Sol_Schnack.rng_seed);
        end
        sol = pdepe(0,@Schnack_linPDEfun,@Schnack_linICfun,@Schnack_BCfun,xspan,tspan,[],P);
        u1(:,i_g,i_d) = sol(end,:,1);
        u2(:,i_g,i_d) = sol(end,:,2);
    end
end
end