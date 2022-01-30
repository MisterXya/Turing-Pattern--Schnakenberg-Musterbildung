function Turing_room_wv_plot2(Obj,k_wv)
%This function shows the borders of specifics modes
j_wv = (k_wv.^2*pi^2); %Modes room

j_d = logspace(log10(Obj.j_d(1)),log10(Obj.j_d(end)),1000);
[ld_bd1, ld_bd2]=  lambda_border(Obj.A,j_d,j_wv);

figure;
hold on
set(gca, 'XScale', 'log')
loglog(j_d,real(ld_bd1),'k');
loglog(j_d,real(ld_bd2),'k');
xline(real(Obj.d_c),'--')
axis([0 j_d(end) 0 Obj.j_g(end)]);
ylabel('\gamma')
xlabel('d')
hold off