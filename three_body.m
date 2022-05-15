% Name: Lachlan Reynolds
% Date: Oct 29, 2020
% Student Number: 14511638

%% Function: three_body_euler
% Purpose: animates the trajectory of a planet orbiting 2 stars fixed in space
% Inputs: 
    % m1: mass of Star 1
    % S1: vector of length 2 containing x and y positions of Star 1
    % m2: mass of Star 2
    % S2: vector of length 2 containing x and y positions of Star 2
    % P: vector of length 4 containing x and y positions and velocities of
    % the planet
    % tspan: vector of length 2 which defines the interval of integration

function [X Y]=three_body_euler(m1, S1, m2, S2, P, tspan)
    
    G=4*pi^2;
    t=tspan(1):0.1:tspan(2);
    
    % State Derivative Vector
    function dudt=odefun(~,u,G)
        dudt=zeros(4,1);
        dudt(1,1)=u(2);
        dudt(2,1)=(G*m1*(S1(1)-u(1)))/(((S1(1)-u(1))^2+(S1(2)-u(3))^2)^(3/2))+(G*m2*(S2(1)-u(1)))/(((S2(1)-u(1))^2+(S2(2)-u(3))^2)^(3/2));
        dudt(3,1)=u(4);
        dudt(4,1)=(G*m1*(S1(2)-u(3)))/(((S1(1)-u(1))^2+(S1(2)-u(3))^2)^(3/2))+(G*m2*(S2(2)-u(3)))/(((S2(1)-u(1))^2+(S2(2)-u(3))^2)^(3/2));
    end

    options =odeset('RelTol',1e-9,'AbsTol',1e-10);
    [T,U]=ode45(@(t,u) odefun(t,u,G),tspan,P,options);

    % Translate State Vectors into x-y coordinates on plot
    X=U(:,1);
    Y=U(:,3);
    
    %Define Limits for graph
    xlimit=[min(X), max(X)];
    ylimit=[min(Y), max(Y)];
    
   
    % Plot stars, plot planets trajectory, save plots in variable M
    for i=1:length(T)
        
        plot(S1(1),S1(2),'r*','MarkerSize',15*m1);
        hold ON;
        plot(S2(1),S2(2),'r*','MarkerSize',15*m2);
        
        plot(X(i),Y(i),'bo','MarkerSize',4,'MarkerFaceColor','b'); 
        xlim(1.5*xlimit); ylim(1.5*ylimit);
        grid ON;
        M(i)=getframe(gcf);'
        % Taking the hold off eliminates the trace left by the planet
        % hold OFF; 
    end
    
    
    % Animate plot
    figure, axes('Position', [0 0 1 1]), movie(M);
    
end


