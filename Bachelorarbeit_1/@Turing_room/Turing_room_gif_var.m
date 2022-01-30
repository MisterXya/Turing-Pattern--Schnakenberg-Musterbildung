function Turing_room_gif_var(Obj,var,point,varargin)
% Zeichnet die (1.) Lösungen entlang einer Variablen
% Turing_room_gif_var(Sol_Schnack,var,number) zeichnet die erste Lösungen
% als Bilder Slider in ein Live Script.
% Var kann dabei die Werte  'd' or 'g' annehmen. point wird der Index
% angeben, wenn erwünscht kann dieser negative Werte haben, dann wir von
% hinten gezählt
% Turing_room_gif_var(Sol_Schnack,var,number,2) zeichnet die zweite
% Variable
% Turing_room_gif_var([...],'point_art',value) Statt den Index wird der
% ungefähre Wert der Variabel in Point eingetragen

%% Handeling with optional paramaters and arguments
% Default setting
default_save_name = NaN;
default_solution = 1;
default_point_art = 'index';
input = inputParser;
addOptional(input,'solution',default_solution)
addParameter(input,'point_art',default_point_art)
addParameter(input,'save_name',default_save_name)
parse(input,varargin{:});
%% Definition of Variables
switch var
    case 'd'
        if strcmp(input.Results.point_art,'value')
            point = find(abs(Obj.j_d-point) == min(abs(Obj.j_d-point)));
        end
        switch input.Results.solution
            case 1
                if point < 0
                    fct = Obj.u1(:,:,end+1+point);
                else
                    fct = Obj.u1(:,:,point);
                end
            case 2
                if point < 0
                    fct = Obj.u2(:,:,end+1+point);
                else
                    fct = Obj.u2(:,:,point);
                end
        end
        k_var = Obj.k_g;
    case 'g'
        if strcmp(input.Results.point_art,'value')
            point = find(abs(Obj.j_g-point) == min(abs(Obj.j_g-point)));
        end
        switch input.Results.solution
            case 1
                if point < 0
                    fct = Obj.u1(:,end+1+point,:);
                else
                    fct = Obj.u1(:,point,:);
                end
            case 2
                if point < 0
                    fct = Obj.u2(:,end+1+point,:);
                else
                    fct = Obj.u2(:,point,:);
                end
        end
        k_var = Obj.k_d;
    otherwise
        error('var must be g or d');
end

% Calculation of Max and Mins per time
fct_max = islocalmax(fct,1,'MinProminence',0);
fct_min = islocalmin(fct,1,'MinProminence',0);

%% Draw
% Set up for saving
gif_fig_u1 = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = input.Results.save_name;
for i_var = 1:k_var
    plot(Obj.xspan,real(fct(:,i_var)))
    hold on
    plot(Obj.xspan(fct_max(:,i_var)),real(fct(fct_max(:,i_var),i_var)),'ro')
    plot(Obj.xspan(fct_min(:,i_var)),real(fct(fct_min(:,i_var),i_var)),'bo')
    hold off
    
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