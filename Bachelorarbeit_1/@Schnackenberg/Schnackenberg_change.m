function [u1,u2,u1_end,u2_end] = Schnackenberg_change(Schnackenberg,change_var,j_var,maxt,varargin)
% Gives the Solution of Schnackenberg with different solutions along an
% Variable specified in change_var 

%% Handling with optionale parameter 
defaultmaxt = Schnackenberg.maxt;
defaultLin = false;
input = inputParser;
addOptional(input,'maxt',defaultmaxt);
addParameter(input,'Linear',defaultlin);
parse(input,maxt,varargin{:});

k_var = length(j_var);
P = [Schnackenberg.a,Schnackenberg.b,Schnackenberg.d,Schnackenberg.g,Schnackenberg.noise];
t = linspace(0,maxt,100);
x = linspace(0,1,100);

u1 = zeros(length(t),length(x),k_var);
u2 = zeros(length(t),length(x),k_var);
u1_end = zeros(length(x),k_var);
u2_end = zeros(length(x),k_var);
%%Solution
for i_var  =  1:k_var
    temp = j_var(i_var);
    
    switch change_var
        case 'a'
            P(1) = temp;
        case 'b'
            P(2) = temp;
        case 'd'
            P(3) = temp;
        case 'g'
            P(4) = temp;
        case 'noise'
            P(5) = temp;
    end
    
    rng(Schnackenberg.rng_seed);
    if input.Results.Linear
        sol = pdepe(0,@Schnack_linPDEfun,@Schnack_linICfun,@Schnack_BCfun,x,t,[],P);
    else
        sol = pdepe(0,@Schnack_PDEfun,@Schnack_ICfun,@Schnack_BCfun,x,t,[],P);
    end
    u1(:,:,i_var) = sol(:,:,1);
    u2(:,:,i_var) = sol(:,:,2);
    u1_end(:,i_var) = sol(end,:,1);
    u2_end(:,i_var) = sol(end,:,2);
end
