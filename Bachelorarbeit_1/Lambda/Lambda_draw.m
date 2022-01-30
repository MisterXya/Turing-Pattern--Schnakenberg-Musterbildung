function Lambda_draw(Obj,j_d,g)
%Landa_draw(Obj,g,d)
%Shows for five different d in j_d the Wavenumbers and their Eigenvalues.
%The second graphs shows the roots of the first function depending on d.

%%Definiton varibles & reservations

%Standard values for j_d & g 
if nargin < 2
    j_d = linspace(0,10,100)+Obj.d_c; 
    g = 5;
end

%Definition of varibles
A = Obj.A;
k_wv = 100;
k_d = size(j_d,2);

%Reservations for variabls
landa_1 = zeros(k_wv,1);
[ld_bd1, ld_bd2] =  lambda_border2(A,j_d,g);

%%Calculation 
landa_mid = g*(2*j_d).^-1.*(j_d.*A(1,1)+A(2,2));
j_wv = linspace(ld_bd1(end),ld_bd2(end),k_wv); %Wavenumber room. We use the biggest roots for that.

for i_ld = 1:k_d
    d = j_d(i_ld);
    for i_wv = 1:k_wv
        wv = j_wv(i_wv);
        A_ = [g*A(1,1)-wv g*A(1,2); g*A(2,1) g*A(2,2)-d*wv];
        temp = eig(A_);
        landa_1(i_wv,i_ld) = temp(1);
    end

end

%%Plots
%1. Plot
figure('Name','Eigenvalue of \lambda_k');
%Selecting of the shown d's
if k_d > 5
    k_show = 5;
    j_show = floor(linspace(1,k_d,k_show));
else
    j_show = 1:k_d;
end
%Plotting
plot(j_wv,landa_1(:,j_show));
hold on
yline(0);
xlabel('Wavelength \lambda_k')
ylabel('Real(\lambda)')
%2. Plot

figure('Name','\lambda roots relation to d')
plot(j_d,ld_bd1);
hold on 
plot (j_d,ld_bd2)
plot(j_d,landa_mid)
yline(g*A(1,1))
xline(Obj.d_c,'--')
hold off
xlabel('d')
ylabel('Wavelength \lambda_k')
legend('\Lambda_+','\Lambda_-','\Lambda_mid','\gamma*a_{11}')