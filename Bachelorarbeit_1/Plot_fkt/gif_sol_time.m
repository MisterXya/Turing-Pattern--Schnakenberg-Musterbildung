function gif_sol_time(fkt,tspan,varargin)
% Draws an solution as gif in time. Showing the Max and Mins.
% 
% gif_sol_time(fkt,tspan) draws the solution (fkt) as an gif in time. 
% gif_sol_time(fkt,tspan,'save_name',text) Saves as gif with filename 'text'
% gif_sol_time(fkt,tspan,'pct_numbers',N) N picture will be use for the gif
% gif_sol_time(fkt,tspan,'waitingtime',t) t seconds waiting time between two pictures
% gif_sol_time(fkt,tspan,'prom',prom) MinProminence in islocalmax.

%% Handeling with optional paramaters and arguments
% Default setting
default_save_name = NaN;
default_pct_numbers = size(tspan,2);
default_waitingtime = 0;
default_prom = 0;

input = inputParser;
addParameter(input,'save_name',default_save_name)
addParameter(input,'pct_numbers',default_pct_numbers);
addParameter(input,'waitingtime',default_waitingtime);
addParameter(input,'prom',default_prom);
parse(input,varargin{:});
%% Definition of Variables
t_show = floor(linspace(1,size(tspan,2),input.Results.pct_numbers));
xspan = linspace(0,1,size(fkt,2));

% Calculation of Max and Mins per time
fkt_max = islocalmax(fkt,2,'MinProminence',input.Results.prom);
fkt_min = islocalmin(fkt,2,'MinProminence',input.Results.prom);

%% Draw
% Set up for saving
gif_fig_u1 = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = input.Results.save_name;
for i_g = 1:input.Results.pct_numbers
    t = t_show(i_g);
    plot(xspan,real(fkt(t,:)))
    hold on
    plot(xspan(fkt_max(t,:)),real(fkt(t,fkt_max(t,:))),'ro')
    plot(xspan(fkt_min(t,:)),real(fkt(t,fkt_min(t,:))),'bo')
    hold off
    
    drawnow
    pause(input.Results.waitingtime);
    
    % Capture the plot as an image if required for saving
    if ~isnan(input.Results.save_name)
        frame = getframe(gif_fig_u1);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        % Write to the GIF File
        if i_g == 1
            imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
        else
            imwrite(imind,cm,filename,'gif','WriteMode','append');
        end
    end
end