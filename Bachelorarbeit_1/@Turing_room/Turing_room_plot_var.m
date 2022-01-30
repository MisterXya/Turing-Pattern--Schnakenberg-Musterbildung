function Turing_room_plot_var(Obj,point,varargin)
% Plottet eine bestimmte Lösung
% Turing_room_plot_var(Obj,point) Plottet die Lösung. Point gibt den Index
% von g/d Punkt, Bzw bei negativen Index den Invertierten Index. Es gibt
% die optionalen Argumente solution,showEx,title,showlables und axis.
%% Handling with optionale parameter 
defaultEx = true;
defaultsol = 1;
defaulttitle = 'Title_holder';
defaultlabels = true;
defaultaxis = [-inf inf -inf inf];
input = inputParser;
addParameter(input,'Solution',defaultsol);
addParameter(input,'showEx',defaultEx)
addParameter(input,'title',defaulttitle)
addParameter(input,'showlables',defaultlabels)
addParameter(input,'axis',defaultaxis)
parse(input,varargin{:});

switch input.Results.Solution
    case 1
        sol = Obj.u1;
    case 2
        sol = Obj.u2;
end
if point(1)<0
    point(1) = Obj.k_g+point(1)+1;
end
if point(2)<0
    point(2) = Obj.k_d+point(2)+1;
end

plot_sol = sol(:,point(1),point(2));
max_sol = islocalmax(plot_sol);
min_sol = islocalmin(plot_sol);

if strcmp(input.Results.title,defaulttitle)
    gamma = round(Obj.j_g(point(1)),2,'significant');
    d = round(Obj.j_d(point(2)),2,'significant');
    plot_title = sprintf('\\gamma = %d und d = %d',gamma,d);
else
    plot_title = input.Results.title;
end
hold on

title(plot_title);
yline(Obj.equilibrium(input.Results.Solution))

plot(Obj.xspan,plot_sol)

if input.Results.showEx
    plot(Obj.xspan(max_sol),plot_sol(max_sol),'ro')
    plot(Obj.xspan(min_sol),plot_sol(min_sol),'bo')
end
if input.Results.showlables == false
    set(gca,'YTickLabel',[]);
    set(gca,'XTickLabel',[]);
    set(gca, 'box', 'off')
    axis(input.Results.axis)
end
axis(input.Results.axis)
hold off