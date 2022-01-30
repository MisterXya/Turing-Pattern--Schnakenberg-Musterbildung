function [ld_bd1,ld_bd2] = Turing_room_waveborder(Obj,k_wv,show)
%Diese Funktion berechnet die Turinginstabilitäts Räume für die angebenen
%Moden k_wv. Mit Show zeigt die Funktion diese direkt.

%% Defintion&Reservation of Variables
%Standard show value
if nargin == 2
    show = true;
end
xmax = Obj.xspan(end);

j_g = sqrt(2)*(((1:k_wv)).^2*pi^2)/xmax;

j_d = Obj.j_d;

%% Calculation
[ld_bd1, ld_bd2]=  landa_border(Obj.A,j_d,j_g);

%Printing if necessary
if show == true
    %erstes Bild
    figure;
    loglog(j_d,real(ld_bd1),'r');
    hold on
    loglog(j_d,real(ld_bd2),'b');
    xline(real(Obj.d_c),'--  ')
    hold off
    
    %anderes Bild
    ld_print2 = ld_bd2;
    ld_temp1 = [zeros(1,Obj.k_d);ld_bd1(1:end-1,:)];
    ld_print2(ld_bd2-ld_temp1< 0 )=  NaN;
    figure;
    loglog(j_d,real(ld_bd1),'r');
    hold on
    loglog(j_d,real(ld_print2),'b');
    xline(real(Obj.d_c),'--  ')
    hold off
end