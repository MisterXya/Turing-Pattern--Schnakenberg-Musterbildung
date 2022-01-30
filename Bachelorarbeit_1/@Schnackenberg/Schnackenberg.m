classdef Schnackenberg
    % Safes an State for an Schnackenberg PDE
    % S = Schnackenberg(a,b,g,d) and has additionaly noise maxt and
    % rng_seed as propertie
    % methods are: Schnackenberg_solv, Schnackenberg_lin_solv to solve the
    % PDE 
    % With Schnackenberg_change you can solve the PDE for vector of one variable (a,b,g,d,noise)
    % and solve it each time
    % For changing both g and d use the Class Sol_Schnack.
    properties
        a, b, g ,d,noise
        maxt = 1;
        rng_seed = rng;
    end
    properties (Dependent)
        A
        d_c %d_c ist the theoterical Minimum for d so that A,d can creat a turing pattern.
        tspan
    end
    properties(Constant)
        x_k = 100;
        xspan = linspace(0,1,100);
    end

    methods
        function Obj = Schnackenberg(a,b,d,g,noise)
            Obj.a = a;
            Obj.b = b;
            Obj.g = g;
            Obj.d = d;
            if nargin < 5
                Obj.noise = 1e-3;
            else
                Obj.noise = noise;
            end
        end
        function A = get.A(Obj)
            A(1,1) = -1+2*Obj.b/(Obj.a+Obj.b);
            A(1,2) = 2*(Obj.a+Obj.b)^2;
            A(2,1) = -Obj.b/(Obj.a+Obj.b);
            A(2,2) = -2*(Obj.a+Obj.b)^2;
        end
        function d_c = get.d_c(Obj)
            d_c = 1/(1/Obj.A(2,2)^2*(2*det(Obj.A)-Obj.A(2,2)*Obj.A(1,1))-sqrt((1/Obj.A(2,2)^2*(2*det(Obj.A)-Obj.A(2,2)*Obj.A(1,1)))^2-(Obj.A(1,1)/Obj.A(2,2))^2));
        end
        function tspan = get.tspan(Obj)
            tspan = 0:0.1:Obj.maxt;
        end 
        [u1,u2,u1_end,u2_end] = Schnackenberg_change(Schnackenberg,change_var,j_var,maxt,varargin);
        [u1, u2, tspan] = Schnackenberg_solv(Obj,varargin);
        [u1,u2,u1_end,u2_end] = Schnackenberg_t_change(Obj,j_t,noise)
    end
end
