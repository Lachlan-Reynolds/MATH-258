%% Name: Lachlan Reynolds
%% Date: Septemeber 22, 2020
%% Student Number: 14511638
%% Beam Deflection Function: 
%%Parameters: elastic modulus, moment of inertia of a cross section,...
%%...distributed weight coefficient and array describing the beam)

%%Returns: Array describing beam with no deflection, array describing...
%%... with deflection

%%Purpose: plots graph of deflection with multiples of initial...
%%...distributed weight coefficient 
function [X,Y] =beam(E,I,q,x)
    length=x(end);
    X=x;
    Y=((2*x.^2)-(5*length*x)+(3*length^2)).*-((q/(48*E*I))*x.^2);
    plot(X,Y,'r');
    hold ON;
    for i=2:4
        plot(X,i*Y);
    end
    hold OFF;
    grid on;
    axis([0 length 8*min(Y) -8*min(Y)]);
    title(['Beam Bending for E = ', num2str(E/1e9,3),' GPa and I = ', num2str(I,3)]);
    xlabel('Beam length, m');
    ylabel('Beam deflection, m');
    legend([num2str(q,4), 'N/m'] ,[num2str(2*q,4), 'N/m'], [num2str(3*q,4), 'N/m'] , [num2str(4*q,4), 'N/m']);
