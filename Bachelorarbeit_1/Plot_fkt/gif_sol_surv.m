function gif_sol_surv(fkt,tspan,varargin)
% Draws an solution as gif for an vector.
% 
% gif_sol_time(fkt,tspan) draws the solution (fkt) as an gif in time. 
% gif_sol_time(fkt,tspan,'save_name',text) Saves as gif with filename 'text'
% gif_sol_time(fkt,j_t,'change_t',true) If t is variable vector, it needs
% to specify and tspan is j_t. 
%% Handeling with optional paramaters and arguments
% Default setting
default_save_name = NaN;
default_change_t = false;

input = inputParser;
addParameter(input,'save_name',default_save_name)
addParameter(input,'change_t',default_change_t)
parse(input,varargin{:});
%% Definition of Variables
xspan = linspace(0,1,size(fkt,2));
%% Draw
% Set up for saving
gif_fig_u1 = figure;
filename = input.Results.save_name;

for i_g = 1:size(fkt,3)
    switch input.Results.change_t
        case false
            tspan_temp = tspan;
        case true
            tspan_temp = 0:0.01:tspan(i_g);
    end
    surf(xspan,tspan_temp,fkt(1:size(tspan_temp,2),:,i_g));
    drawnow
    
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