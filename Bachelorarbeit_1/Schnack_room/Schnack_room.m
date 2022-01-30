classdef Schnack_room < Turing_room
    %Schnack_room is the subclass for Turing_room.
    properties
        a;
        b;
        equilibrium;
        schnack_mode;
    end
    methods
        function obj = Schnack_room(a,b,j_g,j_d,noise)
            A = Transform_Snak_Lin(a,b);
            obj@Turing_room(A,j_g,j_d,noise);
            obj.a = a;
            obj.b = b;
            obj.equilibrium = [obj.a+obj.b obj.b/(obj.a+obj.b)^2];
            obj.schnack_mode = zeros(obj.k_g,obj.k_d);
        end
        function Schnack_lin = create_Schnack_lin(obj)
            Schnack_lin = Schnack_lin_room(obj.a,obj.b,obj.j_g,obj.j_d,obj.noise);
            Schnack_lin.predmode = obj.predmode;
        end
        function Schnack_median = create_Schnack_median(obj,k)
            Schnack_median = Schnack_median_room(obj.a,obj.b,obj.j_g,obj.j_d,obj.noise,k);
            Schnack_median.predmode = obj.predmode;
        end
        function CopySchnack = create_Schnack_noise(obj,noise)
            CopySchnack = obj;
            CopySchnack.noise = noise;
        end
        function Obj = Turing_room_mode(Obj,varargin)
            %Uses mode_test to calculate the mode. For more information look at
            %mode_test
            %% Handling with optionale parameter
            defaultprom = 0;
            input = inputParser;
            defaultsol = 1;
            addParameter(input,'MinProminence',defaultprom);
            addParameter(input,'Solution',defaultsol);
            parse(input,varargin{:});
            
            [mode,maxProm,Mode_case] = mode_test(Obj,...
                'MinProminence',input.Results.MinProminence,'Solution',input.Results.Solution);
            switch input.Results.Solution
                case 1
                    Obj.u1_mode = mode;
                case 2
                    Obj.u2_mode = mode;
            end
            Obj.roundProm = round(maxProm,2,'significant');
            Obj.roundProm = maxProm;
            Obj.mode_case = Mode_case;
        end
        function Obj = Turing_room_max_mode(Obj,j_prom,varargin)
            %Returns the maximal Mode, if there is an smaller mode
            defaultSolution = 1;
            input = inputParser;
            addParameter(input,'Solution', defaultSolution);
            parse(input,varargin{:});
            
            [mode,maxProm,Obj.mode_case,Obj.schnack_mode] = max_mode(Obj,j_prom,'Solution',input.Results.Solution);
            
            switch input.Results.Solution
                case 1
                    Obj.u1_mode = mode;
                case 2
                    Obj.u2_mode = mode;
            end
            Obj.roundProm = round(maxProm,2,'significant');
        end
        function Obj = Schnack_room_solver(Obj)
            [Obj.u1, Obj.u2] = schnack_solver(Obj);
        end
        function [u1,u2] = schnack_solver(Obj)
            disp('autsch')
            P = [Obj.a,Obj.b,0,0,Obj.noise]; %d,g will be filled later
            u1 = zeros(Obj.x_k,Obj.k_g,Obj.k_d);
            u2 = zeros(Obj.x_k,Obj.k_g,Obj.k_d);
            %% Calculation
            for i_d = 1:Obj.k_d
                P(3) = Obj.j_d(i_d);
                for i_g = 1:Obj.k_g
                    P(4) = Obj.j_g(i_g);
                    sol = pdepe(0,@Schnack_PDEfun,@Schnack_ICfun,@Schnack_BCfun,Obj.xspan,Obj.tspan,[],P);
                    u1(:,i_g,i_d) = sol(end,:,1);
                    u2(:,i_g,i_d) = sol(end,:,2);
                end
            end
        end
    end
end
