function loglog_mode2(Obj,varargin)
%% Handeling with optional paramaters RNG and display and optional argument noise
% Default setting
default_show = 1;
default_raster = 0;
defaultshowSchnack = false;
input = inputParser;
addParameter(input,'show_raster',default_raster)
addParameter(input,'show',default_show);
addParameter(input,'showSchnack',defaultshowSchnack);

parse(input,varargin{:});

switch input.Results.show
    case 1
       temp_mode = Obj.u1_mode;
    case 2 
        temp_mode = Obj.u2_mode;
end

k = min(10,max(temp_mode,[],'all'));

color_code = distinguishable_colors(k+1,{'w','k'}); %Setting the Colorcode for each mode

mc_set1 = [0 1/2 1];
mc_set2 = ['o','*','+'];

j_d = Obj.j_d;
j_d_= repmat(j_d,Obj.k_g,1);
j_g_= repmat(Obj.j_g',1,Obj.k_d);
j_d_1 = Obj.predmode{3};
    
figure('Name', sprintf('Solution %d :mode selection',input.Results.show));
hold on
set(gca, 'XScale', 'log')
xlabel('d')
ylabel('\gamma')
axis([j_d(1) j_d(end) Obj.j_g(1) Obj.j_g(end)])

if input.Results.showSchnack
    loglog(j_d_(Obj.schnack_mode),j_g_(Obj.schnack_mode),'s','MarkerFaceColor',[0.7 0.7 0.7],'MarkerEdgeColor','w','MarkerSize',10);
end

loglog(j_d_(temp_mode == 0),j_g_(temp_mode == 0),mc_set2(2),'color',color_code(1,:),'DisplayName','Mode:0')

for i_case = 1:length(mc_set1)
    for i = 1:k
        temp_log = temp_mode == i & Obj.mode_case == mc_set1(i_case);
        loglog(j_d_(temp_log),j_g_(temp_log),mc_set2(i_case),'color',color_code(i+1,:),'DisplayName',sprintf('Mode:%d',i))
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