function loglog_gif_mode(Obj,j_noise,varargin)

%% Handeling with optional paramaters RNG and display and optional argument noise
% Default setting
defaultshow = [1,2];

input = inputParser;
addParameter(input,'show',defaultshow);
parse(input,varargin{:});

color = distinguishable_colors(9,{'w','k'}); %Setting the Colorcode for each mode
k_noise = size(j_noise,2);
j_d = Obj.j_d;
j_d_= repmat(j_d,Obj.k_g,1);
j_g_= repmat(Obj.j_g',1,Obj.k_d);
%Show the first variable if requested
if any(input.Results.show == 1)
    figure;
    for i_noise = 1:k_noise
    [u1_mode] = Mode_test(Obj.u1,'MinProminence',j_noise(i_noise));
        hold on
        set(gca, 'XScale', 'log')
        loglog(j_d_(u1_mode == 0),j_g_(u1_mode == 0),'o','color',color(1,:),'DisplayName','Mode:0')
        loglog(j_d_(u1_mode == 1/2),j_g_(u1_mode == 1/2),'o','color',color(2,:),'DisplayName','Mode:1/2') %;Monotone Mode
        for i = 1:7
            loglog(j_d_(u1_mode == i),j_g_(u1_mode == i),'o','color',color(i+2,:),'DisplayName',sprintf('Mode:%d',i))
        end
        Sol_Schnack_wv_plot(Obj,7)
        axis([0 j_d(end) 0 Obj.j_g(end)]);
        hold off
        drawnow
    end
    legend(legendUnq())
end
%Show the second variable if requested
if any(input.Results.show == 2)
    figure;
    for i_noise = 1:k_noise
        [u2_mode] = Mode_test(Obj.u1,'MinProminence',j_noise(i_noise));
        if any(input.Results.show == 2)
            set(gca, 'XScale', 'log')
            hold on
            loglog(j_d_(u2_mode == 0),j_g_(u2_mode == 0),'o','color',color(1,:),'DisplayName','Mode:0')
            loglog(j_d_(u2_mode == 1/2),j_g_(u2_mode == 1/2),'o','color',color(2,:),'DisplayName','Mode:1/2') %;Monotone Mode
            for i = 1:7
                loglog(j_d_(u2_mode == i),j_g_(u2_mode == i),'o','color',color(i+2,:),'DisplayName',sprintf('Mode:%d',i))
            end
            hold off
        end
        axis([0 j_d(end) 0 Obj.j_g(end)])
        legend(legendUnq())
        drawnow
    end
end