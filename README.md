# Bachelorarbeit
Turing Pattern Bachelorarbeit <br>

Erstellen sämtlicher Bilder und meiner Bachelorarbeit.
Leider ist die Dokumentation auf deutsch und englisch gemixt und manchmal unvollständig.  Bei Fragen, bitte an maxifk98@hotmail.com wenden.
 Die LiveSkript sind Beispiele für die Nutzung diese Funktionen. 

# Funktionen
## @Schnackenberg

### Schnackenberg.m

classdef Schnackenberg <br>
Safes a state for a Schnackenberg PDE <br>
S = Schnackenberg(a,b,g,d) and has additionaly noise maxt and rng_seed as properties <br>
Methods are: <br>
Schnackenberg_solv and Schnackenberg_lin_solv to solve the PDE. <br>
With Schnackenberg_change you can solve the PDE for vector of one variable (a,b,g,d,noise) and solve it each time.<br>
For changing both g and d use the Class Schnack_room.
Schnackenberg_t_change Change the variable t

### Schnackenberg_change.m

function [u1,u2,u1_end,u2_end] = Schnackenberg_change(Schnackenberg,change_var,j_var,maxt,varargin) <br>
Gives the Solution of Schnackenberg with different solutions along a Variable specified in change_var 

### Schnackenberg_solv.m

function [u1, u2, tspan] = Schnackenberg_solv(Obj,varargin) <br>
Calculate and plot for an the Schnackenberg PDE for the State Obj with pdepe. <br>
[u1, u2] = Schnackenberg_solv(Obj)  Calculate the solution and plot it. <br>
There are optional Parameters: Plot_display,maxt and noise: <br>
[u1, u2] = Schnackenberg_solv(Obj,'noise',noise): You can change the starting noise. <br>

### Schnackenberg_t_change.m

function [u1,u2,u1_end,u2_end] = Schnackenberg_t_change(Obj,j_t,noise) <br>
Gives the Solution of Schnackenberg with different solutions along noise

## @Turing_room

### max_mode.m

function [mode,maxProm,mode_case,Schnack_mode] = max_mode(Obj,j_prom,varargin) <br>
Returns the maximal Mode, thats not zero.

### mode_test.m

function [mode,maxProm,Mode_case] = mode_test(Obj,varargin) <br>
This function detects the numbers of extremas for each solution. For this we use the function islocal with condition FlatSelection center. <br>
Additionally it can return if two neighbors solutions havedifferent numbers of extremas. <br>
[mode]= mode_test(fkt): Returns the number of extremas for each solution. <br>
[mode,maxProm]: Also returns the biggest Prominence.<br>
[~ ,~, Modecase] = Mode_test(fkt): postiv or negativ permutation<br>
mode_test(fkt,'MinProminence',P): Specifies the condition MinProminence in islocalmax. <br>
"TF = islocalmax(...,'MinProminence',P):
Returns only those local maxima whose prominence is 
at least P.[...]"


### Turing_room.m

classdef (Abstract) Turing_room<br>
Turing_room ist eine abstrakte Klasse des  g/d Turing Raumes. <br>
Sämtliche Funktionen(außer die Solver-Funktion) betrachten standardmäßig die erste Lösung. <br>
Mit dem optionalen Argument fct(...,'Solution',2) wird die zweite Lösung betrachtet.

properties<br>
A %Jacobi-Matrix<br>
j_g, %Gamma-Werte<br>
j_d, %d-Werte<br>
noise %Störungsparameter<br>
u1 %Erste Lösungen des Systems (Berechnet jeweilige Solver)<br>
u2 %Zweite Lösungen des Systems (Berechnet jeweilige Solver)<br>
u1_mode % Die Modi 1) Lösungen |Turing_room_mode/max_mode <br> berechnet
u2_mode %Die Modi 2) Lösungen |Turing_room_mode/max_mode berechnet
mode_case %Permutation der (1.)Lösung. <br>
roundProm %Gerundete Frequenz der Lsg. <br>
tmax = 1; %Ende des Zeitintervall <br>
predmode = [{0} {0} {0}]; %Erwartetbarer Modus (siehe Turing Predmode) 

### Turing_room_giv_var_m

function Turing_room_gif_var(Obj,var,point,varargin) Zeichnet die (1.) Lösungen entlang einer Variablen <br>
Turing_room_gif_var(Sol_Schnack,var,number) zeichnet die ersten Lösungen als Bilder Slider in ein Live Script. <br>
Var kann dabei die Werte  'd' or 'g' annehmen. point wird der Index angeben; wenn erwünscht, so kann dieser negative Werte haben, dann wir von hinten gezählt. <br>
Turing_room_gif_var(Sol_Schnack,var,number,2) zeichnet die zweite Variable.<br>
Turing_room_gif_var([...],'point_art',value):  Statt dem Index wird der ungefähre Wert der Variablen in Point eingetragen <br>


### Turing_room_plot_var.m

function Turing_room_plot_var(Obj,point,varargin)
Plottet eine bestimmte Lösung
Turing_room_plot_var(Obj,point) Plottet die Lösung. 
Point gibt den Index von g/d Punkt, bzw. bei negativem Index den Invertierten Index. 
Es gibt die optionalen Argumente  solution, showEx, title, showlables und axis.


Turing_room_predmode.m

function Obj = Turing_room_predmode(Obj,k,varargin)
% Turing_room_predmode gibt den Wechsel an - wann die Modi 
% sich die dominate wechselt.
% Turing_room_predmode(Obj,k) zeichnet die Bereiche auf in
% welchen der jeweilige Modus dominiert; k gibt die Anzahl 
% der betrachteten Modi an. 
% j_d und j_g wurden hierfür stark verfeinert. 
% Mit dem Parameter Show wird es direkt angezeigt


Turing_room_waveborder.m

function [ld_bd1,ld_bd2] = Turing_room_waveborder(Obj,k_wv,show)
% Diese Funktion berechnet die Turing-Instabilitäts-Räume 
% für die angebenen Modi k_wv. 
% Mit Show zeigt die Funktion diese direkt.


Turing_roomwv_plot.m

function Turing_room_wv_plot(Obj,k_wv)
% This function shows the borders of specifics modes


Turing_roomwv_plot2.m

function Turing_room_wv_plot2(Obj,k_wv)
% This function shows the borders of specifics modes



Bilder

g90trace_convinf.jpg
g100trace_convinf.jpg
trace2_pic.jpg
trace_pic.jpg


Daten

Amedian1.mat
Data0501.mat
Data0701.mat
Data0901.mat
Data_set14_12.mat
Datamean2.mat
Schnack_Sol.mat
Schnack_unstable_rng_seed.mat



externeFunktionen (Nicht meine Arbeit)

distinguishable_colors.m

function colors = distinguishable_colors(n_colors,bg,func)
%Source: https://de.mathworks.com/matlabcentral/fileexchange/29702-generate-maximally-perceptually-distinct-colors
% Copyright 2010-2011 by Timothy E. Holy

legendUnq.m

% Danz 180515



Lambda


lambda_border.m

function [g1,g2] = lambda_border(A,d,k)
% [g1,g2] = lambdaborder(A,d,k)
% The Lambda function is rearranged to gamma = f(Lambda,d)


lambda_border2.m

function [z1,z2] = lambda_border2(A,d,g)
% [z1,z2] = lambda_border2(A,d,k)
% The function Lambda is depending on d,k


Lambda_draw.m

function Lambda_draw(Obj,j_d,g)
% Lambda_draw(Obj,g,d)
% Shows for five different d in j_d the wavenumbers and 
% their Eigenvalues.
% The second graph shows the roots of the first function 
% depending on d.


xLambda_draw2.m

function Lambda_draw2(Obj,d,j_g)
% Shows for each g in j_g the wavenumbers and their 
% eigenvalues which are positive eigenvalues.


LiveScript

Analysen  -   Beispiele


Plot_fkt

gif_sol_surv.m

function gif_sol_surv(fkt,tspan,varargin)
% Draws a solution as gif for a vector.
% 
% gif_sol_time(fkt,tspan) draws the solution (fkt) as 
% a gif in time.
% gif_sol_time(fkt,tspan,'save_name',text) saves as gif 
% with filename 'text'
% gif_sol_time(fkt,j_t,'change_t',true) If t is a variable 
% vector, it needs to specify and tspan is j_t.


gif_sol_time.m

function gif_sol_time(fkt,tspan,varargin)
% Draws an solution as gif in time. Showing the Max and Mins.
% 
% gif_sol_time(fkt,tspan) draws the solution (fkt) as a gif 
% in time. 
% gif_sol_time(fkt,tspan,'save_name',text) saves as a gif 
% with filename 'text'.
% gif_sol_time(fkt,tspan,'pct_numbers',N) N pictures will 
% be used for the gif
% gif_sol_time(fkt,tspan,'waitingtime',t) t seconds are the
% waiting time between two pictures
% gif_sol_time(fkt,tspan,'prom',prom) MinProminence in 
% islocalmax.


loglog_gif_mode.m

function loglog_gif_mode(Obj,j_noise,varargin)



loglog_median_mode.m

function loglog_median_mode(Obj,varargin)
% Draws with loglog the modes an Sol_Schnack
% loglog_mode(Obj,'show_raster', 0)
% Optional Parameters are show_raster to show a raster 
% over the Modes.
% 1 represent the all modes which are possible
% 2 represent the raster for the linear predicted mode.
% loglog_mode(Obj,'show',2) You can see the second variable.


loglog_mode.m

function loglog_mode(Obj,varargin)
% Draws with loglog the modes an Schnackenberg_jgd
% loglog_mode(Obj,'show_raster', 0)
% Optional Parameters are show_raster to show an raster 
% over the Modes.
% 1 represent the all modes which are possible 
% 2 represent the raster for the linear predicted mode.
% loglog_mode(Obj,'show',2) You can see the second variable


loglog_mode.m

function loglog_mode2(Obj,varargin)


loglog_mode3.m

function loglog_mode3(Obj,varargin)


Phasendiagramm.m

function Phasendiagramm(Obj,point)

Schnack_room


@Schnack_lin_room


classdef Schnack_lin_room < Schnack_room
    methods
     function obj = Schnack_lin_room(a,b,j_g,j_d,noise)

     function Obj = Turing_room_mode(Obj,varargin)
         %Uses mode_test to calculate the mode. 
         %For more information look at mode_test.
     function Obj = Turing_room_max_mode(Obj,j_prom,varargin)
         %Returns the maximal Mode, if there is a smaller 
         %mode
     function Obj = Schnack_lin_room_solver(Obj)



@Schnack_median_room


Schnack_median_room.m

classdef Schnack_median_room < Schnack_room
%Schnack_median_room is the subclass from Schnack_room.


Schnack_median_room_mode.m

function Obj = Schnack_median_room_mode(Obj,j_prom,varargin)




Schnack_room.m

classdef Schnack_room < Turing_room
    %Schnack_room is the subclass for Turing_room.
          
  methods
     function obj = Schnack_room(a,b,j_g,j_d,noise)


     function Schnack_lin = create_Schnack_lin(obj)


     function Schnack_median = create_Schnack_median(obj,k)


     function CopySchnack = create_Schnack_noise(obj,noise)


     function Obj = Turing_room_mode(Obj,varargin)
         %Uses mode_test to calculate the mode. 
         %For more information look at mode_test

     function Obj = Turing_room_max_mode(Obj,j_prom,varargin)
         %Returns the maximal Mode, if there is an smaller 
         %mode

     function Obj = Schnack_room_solver(Obj)


     function [u1,u2] = schnack_solver(Obj)



Schnackenberg_pdefunction


Schnack_Bcfun.m

function [pl,ql,pr,qr] = Schnack_BCfun(~,~,~,~,~,~,~)
% Neumannborder for Schnackenberg-PDE-Solver


Schnack_Icfun.m

function u0 = Schnack_ICfun(x,P)
% u0 = Schnack_IC_fun(x,P(5) = noise): 
% Starting point at equilibrium (u0 = [a+b;b/(a+b)^2]) with
% noise 



Schnack_linICfun.m

function u0 = Schnack_linICfun(~,P)
% u0 = noise*rand(size(u0)): 
% 0 as starting point and equilbrium


Schnack_linPDEfun.m

function [c,f,s] = Schnack_linPDEfun(~,~,u,dudx,P)
% Defintion of f,d,s function for pdepe.
% So the PDE looks like: c*dudt = dudx*f+s


Schnack_PDEfun.m

function [c,f,s] = Schnack_PDEfun(~,~,u,dudx,P)
% Definition of f,d,s function for pdepe.
% So the PDE looks like: c*dudt = dudx*f+s



Sol_Schnack_linsolv.m

function [u1,u2] =  Sol_Schnack_linsolv(Sol_Schnack,varargin)
% Solves for the grid of g and d the linearisation of 
% Schnackenberg with pdepe and
% safes for each grid point g/d the last temporal solution 
% of the PDE.
% With the optional parameter 'rng_seed_set', false you will 
% deactivate the seed.
% Setting of Sol_Schnack_linsolv. In the standard setting 
% it uses the rng_seed of the class.

Transform_Snak_Lin.m

function A = Transform_Snak_Lin(a,b)
