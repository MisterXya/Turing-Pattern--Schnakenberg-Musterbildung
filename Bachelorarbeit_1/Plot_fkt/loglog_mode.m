function loglog_mode(Obj,varargin)
% Draws with loglog the modes an Schnackenberg_jgd
% loglog_mode(Obj,'show_raster', 0)
% Optional Parameters are show_raster to show an raster over the Modes.
% 1 represent the all modes which are possible 
% 2 represent the raster for the linear predicted mode.
% loglog_mode(Obj,'show',2) You can see the second variable

%% Handeling with optional paramaters showraster
% Default setting
defaultshow = 1;
default_raster = 0;
defaultshowSchnack = false;
input = inputParser;
addParameter(input,'show_raster',default_raster)
addParameter(input,'show',defaultshow);
addParameter(input,'showSchnack',defaultshowSchnack);
parse(input,varargin{:});

switch input.Results.show
    case 1
       temp_mode = Obj.u1_mode;
    case 2 
        temp_mode = Obj.u2_mode;
end
k = min(max(temp_mode,[],'all'),9);

color = distinguishable_colors(k+1,{'w','k'}); %Setting the Colorcode for each mode
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
if input.Results.showSchnack
    loglog(j_d_(Obj.schnack_mode),j_g_(Obj.schnack_mode),'s','MarkerFaceColor',[0.9 0.9 0.9],'MarkerEdgeColor','w','MarkerSize',10);
end
for i = 0:k
    loglog(j_d_(temp_mode == i),j_g_(temp_mode == i),'o','color',color(i+1,:),'DisplayName',sprintf('Mode:%d',i))
end

%%Drawing the raster
if input.Results.show_raster == 1
    Turing_room_wv_plot(Obj,k)
end
if input.Results.show_raster == 2
    loglog(j_d_1,Obj.predmode{1},'k','LineWidth',1)
    loglog(j_d_1,Obj.predmode{2},'k','LineWidth',1)
end
legend(legendUnq())
hold off
end
