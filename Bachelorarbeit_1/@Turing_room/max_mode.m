function [mode,maxProm,mode_case,Schnack_mode] = max_mode(Obj,j_prom,varargin)
%Returns the maximal Mode, if there is an smaller mode
defaultSolution = 1;
input = inputParser;
addParameter(input,'Solution', defaultSolution);
parse(input,varargin{:});

j_d_ = repmat(Obj.j_d,Obj.k_g,1);
[min_mode,maxProm,mode_case] = mode_test(Obj,'MinProminence',j_prom(1),'Mono_mode',true,'Solution',input.Results.Solution);
mode = min_mode;

for i_prom = j_prom
    mode_temp = mode_test(Obj,'MinProminence',i_prom,'Mono_mode',false,'Solution',input.Results.Solution);
    mode(mode_temp ~=0) = mode_temp(mode_temp ~=0);
end

mode_temp2 = mode_test(Obj,'MinProminence',j_prom(end),'Solution',input.Results.Solution);
mode_temp2(mode_temp2 == 0) = 1;
mode(mode == 2 & j_d_ > 2*Obj.d_c) = mode_temp2(mode == 2 & j_d_ > 2*Obj.d_c);

%Testing if Mode one is really existing.
mode_temp = mode_test(Obj,'MinProminence',j_prom(end),'Solution',input.Results.Solution);
mode_temp(mode_temp == 0) = 1;
mode(mode == 2 & j_d_ > 2*Obj.d_c) = mode_temp(mode == 2 & j_d_ > 2*Obj.d_c); %First couples modes are to small to test.

Schnack_mode = ~(min_mode == mode);