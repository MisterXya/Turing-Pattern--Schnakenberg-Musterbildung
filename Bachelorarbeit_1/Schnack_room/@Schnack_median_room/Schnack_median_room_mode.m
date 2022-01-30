function Obj = Schnack_median_room_mode(Obj,j_prom,varargin)

defaultj_prom = logspace(-16,-1,7);
defaultmax_mode = false;
default_Maximal_mode = false;

input = inputParser;
addOptional(input,'j_prom',defaultj_prom)
addParameter(input,'max_mode',defaultmax_mode);
addParameter(input,'Maximal_mode',default_Maximal_mode)
parse(input,j_prom,varargin{:});

mode = zeros(Obj.k_g,Obj.k_d,Obj.k);
roundProm = zeros(Obj.k_g,Obj.k_d,Obj.k);
Mode_case = zeros(Obj.k_g,Obj.k_d,Obj.k);
mode_variance = zeros(Obj.k_g,Obj.k_d);

tempSchnack = Obj;
if input.Results.max_mode == true
    for i = 1:Obj.k
        tempSchnack.u1 = Obj.median_sol(:,:,:,i);
        [mode(:,:,i), roundProm(:,:,i), Mode_case(:,:,i)] = max_mode(tempSchnack,input.Results.j_prom);
    end    
else
    for i = 1:Obj.k
        tempSchnack.u1 = Obj.median_sol(:,:,:,i);
        [mode(:,:,i), roundProm(:,:,i), Mode_case(:,:,i)] = mode_test(tempSchnack,'MinProminence',1e-16);
    end
end
if input.Results.Maximal_mode
    temp_mode = max(mode,[],3);
else
    temp_mode = round(median(mode,3));
end
edge = [-0.5:max(temp_mode]];
for i_g = 1:size(mode,1)
    for i_d = 1:size(mode,2)
        temp_variance = histcounts(mode(i_g,i_d,:),edge);
        temp_variance(1) = temp_variance(1)+temp_variance(2);
        mode_variance(i_g,i_d) = temp_variance(temp_mode(i_g,i_d)+1);
    end
end

Obj.roundProm = round(median(roundProm,3),2,'significant');
Obj.mode_case = median(Mode_case,3);
Obj.u1_mode = temp_mode;
Obj.mode_variance = mode_variance;