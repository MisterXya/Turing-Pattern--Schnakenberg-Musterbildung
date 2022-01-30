function [u1, u2, tspan] = Schnackenberg_solv(Obj,varargin)
% Calculate and plot for an the Schnackenberg PDE for the State Obj with pdepe
% [u1, u2] = Schnack_spec(Obj)  Calculate the solution and plot it
% There are optional Parameters: Plot_display,maxt and noise:
% [u1, u2] = Schnack_spec(Obj,'noise',noise)  You can change the starting noise
% [u1, u2, tspan] = Schackenberg_solv(Obj,varargin) change the maxt
% Schnack_spec[a,b,d,g,'Plot_display',0] Plot_display can be in four
% different states 0 ,1 ,2 ,[1,2], the standard state is [1,2] and
% choosen variable will be display or none if 0 or anything else.

%% Handeling with optional paramaters and arguments
% Default setting
defaultdisplay = [1,2];
defaultnoise = Obj.noise;
defaultmaxt = Obj.maxt;

input = inputParser;
addOptional(input,'noise',defaultnoise);
addOptional(input,'maxt',defaultmaxt);
addParameter(input,'Plot_display',defaultdisplay);
parse(input,varargin{:});

%% Definition of Variable
P = [Obj.a,Obj.b,Obj.d,Obj.g,input.Results.noise];
display = input.Results.Plot_display; %Which Plots wil be shown

maxt = input.Results.maxt;
tspan = 0:0.01:maxt;

%% Solution
rng(Obj.rng_seed);
sol = pdepe(0,@Schnack_PDEfun,@Schnack_ICfun,@Schnack_BCfun,Obj.xspan,tspan,[],P);
u1 = sol(:,:,1);
u2 = sol(:,:,2);

%% Display

if any(display == 1)
    % Plot first solution
    figure('name',sprintf('first Solution for g:%d d:%d',P(3),P(4)));
    surf(Obj.xspan,tspan,u1,'edgecolor','none');
    xlabel('Distance x','fontsize',20,'fontweight','b','fontname','arial')
    ylabel('Time t','fontsize',20,'fontweight','b','fontname','arial')
    zlabel('Species u','fontsize',20,'fontweight','b','fontname','arial')
    axis([0 1 0 maxt min(min(u1))  max(max(u1))])
    set(gcf(), 'Renderer', 'painters')
    set(gca,'FontSize',18,'fontweight','b','fontname','arial')
end
if any(display ==2)
    % Plot second solution
    figure('name',sprintf('second Solution for g:%d d:%d',P(3),P(4)));
    surf(Obj.xspan,tspan,u2,'edgecolor','none');
    xlabel('Distance x','fontsize',20,'fontweight','b','fontname','arial')
    ylabel('Time t','fontsize',20,'fontweight','b','fontname','arial')
    zlabel('Species u','fontsize',20,'fontweight','b','fontname','arial')
    axis([0 1 0 maxt min(min(u2))  max(max(u2))])
    set(gcf(), 'Renderer', 'painters')
end