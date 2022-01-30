classdef Schnack_median_room < Schnack_room
    %Schnack_median_room is the subclass from Schnack_room.
    properties
    mode_variance
    median_sol
    k;
    end
    methods
        function obj = Schnack_median_room(a,b,j_g,j_d,noise,k)
            obj@Schnack_room(a,b,j_g,j_d,noise)
            obj.k = k;
            obj.mode_variance = zeros(obj.k_g,obj.k_d);
            obj.median_sol = zeros(obj.x_k,obj.k_g,obj.k_d,k);
        end
        function Obj = Schnack_median_room_solver(Obj)
            for i = 1:Obj.k
                Obj.median_sol(:,:,:,i) = schnack_solver(Obj);
            end
        end
        Obj = Schnack_median_room_mode(Obj,varargin);
    end
end
