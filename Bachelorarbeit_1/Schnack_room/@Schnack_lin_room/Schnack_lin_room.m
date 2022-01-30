classdef Schnack_lin_room < Schnack_room
    methods
        function obj = Schnack_lin_room(a,b,j_g,j_d,noise)
            obj@Schnack_room(a,b,j_g,j_d,noise);
            obj.equilibrium = [0 0];
        end

        function Obj = Turing_room_mode(Obj,varargin)
            %Uses mode_test to calculate the mode. For more information look at
            %mode_test
            %% Handling with optionale parameter
            defaultprom = 0;
            defaultsol = 1;
            input = inputParser;
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
            Obj.roundProm = round(log10(maxProm),1,'significant');
            Obj.mode_case = Mode_case;
        end
        function Obj = Turing_room_max_mode(Obj,j_prom,varargin)
            %Returns the maximal Mode, if there is an smaller mode
            defaultSolution = 1;
            input = inputParser;
            addParameter(input,'Solution', defaultSolution);
            parse(input,varargin{:});
            
            [mode,maxProm,mode_case] = max_mode(Obj,j_prom,'Solution',input.Results.Solution);
            
            switch input.Results.Solution
                case 1
                    Obj.u1_mode = mode;
                case 2
                    Obj.u2_mode = mode;
            end
            
            Obj.roundProm = round(log10(maxProm),1,'significant');
            Obj.mode_case = mode_case;
        end
        function Obj = Schnack_lin_room_solver(Obj)
            P = [Obj.a,Obj.b,0,0,Obj.noise]; %d,g will be filled later
            temp_u1 = zeros(Obj.x_k,Obj.k_g,Obj.k_d);
            temp_u2 = zeros(Obj.x_k,Obj.k_g,Obj.k_d);
            %% Calculation
            for i_d = 1:Obj.k_d
                P(3) = Obj.j_d(i_d);
                for i_g = 1:Obj.k_g
                    P(4) = Obj.j_g(i_g);
                    sol = pdepe(0,@Schnack_linPDEfun,@Schnack_linICfun,@Schnack_BCfun,Obj.xspan,Obj.tspan,[],P);
                    temp_u1(:,i_g,i_d) = sol(end,:,1);
                    temp_u2(:,i_g,i_d) = sol(end,:,2);
                end
            end
            Obj.u1 = temp_u1;
            Obj.u2 = temp_u2;
        end
    end
end
