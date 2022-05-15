%%Name: Lachlan Reynolds
%%Date: September 30, 2020
%%Student Number: 14511638
%% Function: slope_field_euler
% Plot the slope field of the first order differential equation y'=f(t,y)
% and plot an approximate solution using Euler's method
% Parameters: Function to be approximated, lower and upper bounds on t and
% y, initial condition for particular solution, time step for particular
% solution
% Outputs: Vectors T and Y, where Y is the particular solution

function [T,Y]=slope_field_euler(f,tspan,yspan,grid_step,y0,time_step)

% Initialize constants and arrays
t=tspan(1):grid_step:tspan(2);
y=yspan(1):grid_step:yspan(2);
T=tspan(1):time_step:tspan(2);

Y(1)=y0;
L=0.4*grid_step;
 
%Plot slope field lines
for i=t(1):grid_step:t(end)
    for j=y(1):grid_step:y(end)
        m=f(i,j);
        theta=atan(m);
        dt=L*cos(theta);
        dy=L*sin(theta);
        line([i-dt, i+dt],[j-dy, j+dy]);
        hold ON;
    end
end
hold OFF;

% Compute Y and plot it
hold ON;
for n=1:length(T)-1
    Y(n+1)=Y(n) + f(t(n),Y(n))*(t(n+1)-t(n));
end

plot(T,Y,'r.','MarkerSize',25);
plot(T,Y,'r','LineWidth',.75);
hold OFF;

%Make graph look nice
grid ON;
axis([tspan(1) tspan(2) yspan(1) yspan(2)]);
xlabel('t');
ylabel('y');
title(["Slope Field for y' =",func2str(f)]);
