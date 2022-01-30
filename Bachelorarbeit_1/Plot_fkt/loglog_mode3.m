function loglog_mode3(Obj,varargin)
%% Handeling with optional paramaters RNG and display and optional argument noise
% Default setting
defaultshow = 1;
default_raster = 0;
input = inputParser;
addParameter(input,'show_raster',default_raster)
addParameter(input,'show',defaultshow);
parse(input,varargin{:});

sizeP = [0.1 0.15 2];

sizeProm = sizeP(2)*round(Obj.roundProm);
sizeProm(sizeProm < sizeP(1)) = sizeP(1);
sizeProm(sizeProm > sizeP(3)) = sizeP(3);
Linewidth_amp = [sizeP(1):sizeP(2):sizeP(3) sizeP(3)];

switch input.Results.show
    case 1
       temp_mode = Obj.u1_mode;
    case 2 
        temp_mode = Obj.u2_mode;
end
k = max(temp_mode,[],'all');

color_code = distinguishable_colors(k+1,{'w','k'}); %Setting the Colorcode for each mode
j_d = Obj.j_d;
j_d_= repmat(j_d,Obj.k_g,1);
j_g_= repmat(Obj.j_g',1,Obj.k_d);
j_d_1 = Obj.predmode{3};
%Show the first variable if requested

figure('Name', 'mode selection');
hold on
set(gca, 'XScale', 'log')
xlabel('d')
ylabel('\gamma')
axis([j_d(1) j_d(end) Obj.j_g(1) Obj.j_g(end)])

%Obj.mode_case 1
for i_size = 1:length(Linewidth_amp)
    for i = 0:k
        temp_log = Obj.u1_mode == i & Linewidth_amp(i_size)-sizeProm < 1e-3;
        loglog(j_d_(temp_log),j_g_(temp_log),'*','color',color_code(i+1,:),'LineWidth',Linewidth_amp(i_size),'DisplayName',sprintf('Mode:%d',i))
    end
end

if input.Results.show_raster == 1
    Turing_room_wv_plot(Obj,k)
end
if input.Results.show_raster == 2
    loglog(j_d_1,Obj.predmode{1},'k')
    loglog(j_d_1,Obj.predmode{2},'k')
end
legend(legendUnq())
hold off