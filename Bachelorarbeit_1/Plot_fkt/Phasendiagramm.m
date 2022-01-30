function Phasendiagramm(Obj,point)

x = 0.2:0.001:1.4;
u11 = (2*x).^-1+sqrt((2.*x).^-2-Obj.a*x.^-1);
u12 = (2*x).^-1-sqrt((2.*x).^-2-Obj.a*x.^-1);
u22 = sqrt(Obj.b*x.^-1);
dist_color = distinguishable_colors(size(point,1),{'k','w','b'});
hold on

plot(Obj.equilibrium(2),Obj.equilibrium(1),'r*','DisplayName','Gleichgewichtspunkt')
plot(x,u11,'b--','DisplayName',"u(t,x)' = 0");
plot(x,u22,'k--','DisplayName',"v(t,x)' = 0");
plot(x,u12,'b--');
ylabel('v(t,x)')
xlabel('u(t,x)')

for i_point = 1:size(point,1)
    if point(i_point,1)<0
        point(i_point,1) = Obj.k_g+point(i_point,1)+1;
    end
    if point(i_point,2)<0
        point(i_point,2) = Obj.k_d+point(i_point,2)+1;
    end
    
    sol1 = Obj.u1(:,point(i_point,1),point(i_point,2));
    sol2 = Obj.u2(:,point(i_point,1),point(i_point,2));

    gamma = round(Obj.j_g(point(i_point,1)),2,'significant');
    d = round(Obj.j_d(point(i_point,2)),2,'significant');
    plot_title = sprintf('\\gamma = %d und d = %d',gamma,d);
    plot(sol2,sol1,'color',dist_color(i_point,:),'DisplayName',plot_title)
end
legend(legendUnq())
hold off