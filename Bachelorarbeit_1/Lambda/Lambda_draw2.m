function Lambda_draw2(Obj,d,j_g)
%Lambda_draw(Sol_matrix,g,d)
%Shows for each g in j_g the Wavenumbers and their Eigenvalues which are positiv Eigenvalue.

%Definition of varibles

A = Obj.A;
k_g = size(j_g,2);
k_wv =100; 

%Reservations for variables
lambda_1 = zeros(k_wv,k_g);
j_wv = zeros(k_wv,k_g);

%%Calculation

[ld_bd1, ld_bd2] =  lambda_border2(A,d,j_g);

for i_g = 1:k_g
    g = j_g(i_g);
    %Wavenumbers room
    j_wv(:,i_g) = linspace(ld_bd1(i_g),ld_bd2(i_g),k_wv); %Wavenumber room
    for i_k = 1:k_wv
        wv = j_wv(i_k,i_g);
        A_ = [g*A(1,1)-wv g*A(1,2); g*A(2,1) g*A(2,2)-d*wv];
        temp = eig(A_);
        lambda_1(i_k,i_g) = temp(1);
        D_k(i_k,i_g) = d*wv^2-g*(d*A(1,1)+A(2,2))*wv+g^2*det(A);
        %Testfunktion für Pattern Formation Paper
    end

end

%Plotting
plot(j_wv,lambda_1);
hold on
yline(0);
xlabel('Wavelength \lambda_k')
ylabel('Real(\lambda)')
legend('10',45,80,'115','150','Location', 'NorthWest');
