function loglog_median_mode(Obj,varargin)
% Draws with loglog the modes an Sol_Schnack
% loglog_mode(Obj,'show_raster', 0)
% Optional Parameters are show_raster to show an raster over the Modes.
% 1 represent the all modes which are possible
% 2 represent the raster for the linear predicted mode.
% loglog_mode(Obj,'show',2) You can see the second variable

%% Handeling with optional paramaters showraster
% Default setting
defaultshow = 1;
default_raster = 0;
input = inputParser;
addParameter(input,'show_raster',default_raster)
addParameter(input,'show',defaultshow);
parse(input,varargin{:});

marker = ['o' 's'];

switch input.Results.show
    case 1
        temp_mode = Obj.u1_mode;
    case 2
        temp_mode = Obj.u2_mode;
end
k = max(temp_mode,[],'all');

color = distinguishable_colors(k+1,{'w','k'}); %Setting the Colorcode for each mode

mode_var = 1:4;
mode_var_color = [1 1 1; 0.8 0.8 0.8; 0.6 0.6 0.6; 0.4 0.4 0.4];

j_d = Obj.j_d;
j_d_= repmat(j_d,Obj.k_g,1);
j_g_= repmat(Obj.j_g',1,Obj.k_d);
j_d_1 = Obj.predmode{3};

figure('Name', sprintf('%d mode selection',input.Results.show));
hold on
set(gca, 'XScale', 'log')
xlabel('d')
ylabel('\gamma')
axis([j_d(1) j_d(end) Obj.j_g(1) Obj.j_g(end)])
for i_mode_var = mode_var
    temp_logical = Obj.mode_variance == i_mode_var;
    loglog(j_d_(temp_logical),j_g_(temp_logical),marker(2),'MarkerFaceColor',mode_var_color(i_mode_var,:),'MarkerEdgeColor','w','MarkerSize',10);
end
for i = 0:k
    loglog(j_d_(temp_mode == i),j_g_(temp_mode == i),marker(1),'color',color(i+1,:),'DisplayName',sprintf('Mode:%d',i))
end
%Drawing the raster
if input.Results.show_raster == 1
    Turing_room_wv_plot(Obj,k)
end
if input.Results.show_raster == 2
    loglog(j_d_1,Obj.predmode{1},'k')
    loglog(j_d_1,Obj.predmode{2},'k')
end
axis([j_d(1) j_d(end) Obj.j_g(1) Obj.j_g(end)])

legend(legendUnq())
hold off
end