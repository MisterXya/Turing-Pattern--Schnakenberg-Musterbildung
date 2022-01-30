function [mode,maxProm,Mode_case] = mode_test(Obj,varargin)
% This function detect the numbers of extremas for each solution. For this
% we use the functions islocal with condition FlatSelection center.
% Addinaly it can return if two neigbors solution has different numbers of extremas.
% 
% [mode]= Mode_test(fkt) returns the numbers of extremas for each solution 
% [mode,maxProm], also returns the biggest Prominence.  
% [~ ,~, mode_change] = Mode_test(fkt) returns a logical array whose elements whose
% elemets are true when a change of numbers locals Extremas between the
% solution and the next solution.
% Mode_test(fkt,'MinProminence',P) specifies the condition MinProminence
% in islocalmax:
% "TF = islocalmax(...,'MinProminence',P) returns only those local maxima
% whose prominence is at least P.[...]"

%% Handling with optinale parameter MinProminence
defaultprom = 0;
default_Mono_mode = true;
default_Solution = 1;
input = inputParser;
addParameter(input,'Mono_mode',default_Mono_mode)
addParameter(input,'MinProminence',defaultprom);
addParameter(input,'Solution',default_Solution);
parse(input,varargin{:});

prom = input.Results.MinProminence';

switch input.Results.Solution
    case 1
        fct = Obj.u1;
        fct_equilibrium = Obj.equilibrium(1);
    case 2
        fct = Obj.u2;
        fct_equilibrium = Obj.equilibrium(2);
end
%% Calculate the numbers of max and min
max_temp = islocalmax(fct,'MinProminence', prom,'FlatSelection', 'center');%Return the max points and the Prominence for each value
min_temp = islocalmin(fct,'MinProminence', prom,'FlatSelection', 'center');
maxProm = max(fct)-min(fct);
Mode_case = fct(1,:,:) < fct_equilibrium;

abs_max = sum(max_temp,1);
abs_min = sum(min_temp,1);

dmax = islocalmax(diff(fct),'MinProminence', prom);
dmin = islocalmin(diff(fct),'MinProminence', prom);

abs_dmax = sum(dmax,1);
abs_dmin = sum(dmin,1);
abs_dmax_log = abs_dmax ~= 0 | abs_dmin ~= 0;

Mode_case = reshape(Mode_case,size(Mode_case,2),size(Mode_case,3));
maxProm = reshape(maxProm,size(maxProm,2),size(maxProm,3));
abs_max = reshape(abs_max,size(abs_max,2),size(abs_max,3));
abs_min = reshape(abs_min,size(abs_min,2),size(abs_min,3));
abs_dmax_log = reshape(abs_dmax_log,size(abs_dmax_log,2),size(abs_dmax_log,3));

mode = abs_max+abs_min+1;
mode(mode == 1) = 0;

if input.Results.Mono_mode == true
    mode(mode == 0) = abs_dmax_log(mode==0);
end