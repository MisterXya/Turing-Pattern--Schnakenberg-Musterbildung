classdef (Abstract) Turing_room
%     Turing_room ist Abstrakte Klasse des g/d Turing Raumes. Sämtliche
%     Funktionen(außer die Solver betrachtet standardmäßig die erste Lösung.
%     Mit dem optionalen Argument fct(...,'Solution',2) wird die zweite Lösung:
%     betrachtet.
    properties
        A %Jacobi-Matrix
        j_g, %Gamma-Werte
        j_d, %d-Werte
        noise %Störungsparameter
        u1 %Erste Lösungen des Systems (Berechnet jeweilige Solver)
        u2 %Zweite Lösungen des Systems (Berechnet jeweilige Solver)
        u1_mode %Die Modi 1) Lösungen |Turing_room_mode/max_mode berechnet
        u2_mode %Die Modi 2) Lösungen |Turing_room_mode/max_mode berechnet
        mode_case %Permutation der (1.)Lösung.
        roundProm %Gerundete Frequenz der Lsg.
        tmax = 1; %Ende des Zeitintervall
        predmode = [{0} {0} {0}]; %Erwartetbarer Modus (siehe Turing Predmode)
    end
    properties (Dependent)
        d_c %d_c Das für Entstehung von Turing Muster minimale d
        k_g %Anzahl der gammas
        k_d %Anzahl der deltas
        tspan
    end
    properties (Abstract)
        equilibrium; %Gleichgewichtspunkt
    end
    properties(Constant)
        t_k = 100; %Anzahl der zeitlichen Punkte
        x_k = 100; %Anzahl der räumlichen Punkte
        xspan = linspace(0,1,100); %Räumliche Lösungsintervalls
    end
    
    methods
        function Obj = Turing_room(A,j_g,j_d,noise)
            Obj.A = A;
            Obj.j_g = j_g;
            Obj.j_d = j_d;
            Obj.noise = noise;
            Obj.u1 = zeros(Obj.x_k,Obj.k_g,Obj.k_d);
            Obj.u2 = zeros(Obj.x_k,Obj.k_g,Obj.k_d);
            Obj.u1_mode = zeros(Obj.k_g,Obj.k_d);
            Obj.u2_mode = zeros(Obj.k_g,Obj.k_d);
            Obj.mode_case = zeros(Obj.k_g,Obj.k_d);
            Obj.roundProm = zeros(Obj.k_g,Obj.k_d);
        end
        function tspan = get.tspan(Obj)
            tspan = linspace(0,Obj.tmax,Obj.t_k);
        end
        function d_c = get.d_c(Obj)
            d_c = 1/(1/Obj.A(2,2)^2*(2*det(Obj.A)-Obj.A(2,2)*Obj.A(1,1))...
                -sqrt((1/Obj.A(2,2)^2*(2*det(Obj.A)-Obj.A(2,2)*Obj.A(1,1)))^2-(Obj.A(1,1)/Obj.A(2,2))^2));
        end
        function k_g = get.k_g(obj)
            k_g = length(obj.j_g);
        end
        function k_d = get.k_d(obj)
            k_d = length(obj.j_d);
        end
        Obj = Turing_room_predmode(Obj,k,varargin);
        [ld_bd1,ld_bd2] = Turing_room_waveborder(Obj,k_wv,show);
        Turing_room_wv_plot(Obj,k_wv);
        Turing_room_wv_plot2(Obj,k_wv);
        Turing_room_gif_var(Obj,var,point,varargin)
    end
    methods (Abstract)
        Obj = Turing_room_mode(Obj,varargin);
        Obj = Turing_room_max_mode(Obj,j_prom,varargin)
    end
end

