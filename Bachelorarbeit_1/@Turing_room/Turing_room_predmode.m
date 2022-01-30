function Obj = Turing_room_predmode(Obj,k,varargin)
%Turing_room_predmode gibt den wechsel, wann die Moden sich die dominate wechselt.
%Dabei gibt Turing_room_predmode(Obj,k) zeichnet die Bereiche auf in
%welcher der jeweilige Modus dominiert. k gibt die Anzahl der betrachten
%Modi an. j_d und j_g wurden hierfür stark verfeinert. Mit der Parameter
%Show wird es direkt angezeigt
defaultshow = false;
input = inputParser;
addParameter(input,'show',defaultshow);
parse(input,varargin{:});


j_d_ = linspace(Obj.d_c, Obj.d_c+0.1,100);
j_d = logspace(log10(j_d_(end)),log10(Obj.j_d(end)),500);
j_g = linspace(Obj.j_g(1),Obj.j_g(end),500);
j_d = [j_d_(1:end-1) j_d];
j_wv = (1:k+1).^2*pi^2;
%reservieren für variabel

mode_change1 = NaN(k+1,length(j_d)); %untere Grenze der Dominanz
mode_change2 = NaN(k,length(j_d)); %obere Grenze der Dominanz

for i_d = 1:length(j_d)
    d = j_d(i_d);
    i = 1;
    i_g = 1;
    ew1_check = false;
    while i_g <= length(j_g) && i <= k
        %Zwei Werte von lambda_k und die dazugehörige Matrizen
        A_ = j_g(i_g)*Obj.A-[j_wv(i) 0;0 d*j_wv(i)];
        A_2 = j_g(i_g)*Obj.A-[j_wv(i+1) 0;0 d*j_wv(i+1)];
        ew1 = eig(A_);
        ew2 = eig(A_2);
        ew1 = ew1(1); %Es interessiert uns nur der erste EW
        ew2 = ew2(1);
        
        if real(ew1) > 0 %Überprüft ob ew1 postiv ist
            if ew1_check == false %Wenn Ew1_check false ist, dann ist es die Unteregrenze von EW1
                mode_change1(i,i_d) = j_g(i_g);
            end
            ew1_check = true; %Checkt ob Ew vorher postiv war.
            if real(ew2) > real(ew1)
                mode_change2(i,i_d) = j_g(i_g); %Speichert erste nichtdominanter Punkt von i ab
                mode_change1(i+1,i_d) = j_g(i_g); %Speichert den ersten dominanter Punkt von i+1 ab
                i=i+1; %Nächster Modus wird geschaut wie langer er dominant ist
                ew1_check = true;
            end
        else
            if ew1_check == true %Ew1 war positiv, somit ist nun EW1 nicht mehr dominant
                mode_change2(i,i_d) = j_g(i_g);
                i= i+1;
                ew1_check = false;
            end
        end
        i_g = i_g+1;
    end
end
Obj.predmode{1} = mode_change1;
Obj.predmode{2} = mode_change2;
Obj.predmode{3} = j_d;
if input.Results.show == true
    hold on
    set(gca, 'XScale', 'log')
    axis([j_d(1) j_d(end) j_g(1) j_g(end)])
    loglog(j_d,Obj.predmode{2},'k')
    loglog(j_d,Obj.predmode{1},'k')
    xlabel('d')
    ylabel('\gamma')
    hold off
end