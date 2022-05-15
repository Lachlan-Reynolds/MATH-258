%%Name: Lachlan Reynolds
%%Date: October 26, 2020
%%Student Number: 14511638
%% Function: pendulum
% Animate the motion of a simple in 2 ways:
% 1. Use ode45 to solve the nonlinear eqation: y''+ (g/L)sin(y)=0
% 2. Use small angle approximation: y'' + (g/L)y=0
% Parameters: Length of pendulum rod L, start and end time of animation
% tspan, initial angle and anglular velocity y0, and frames per second fps
% Outputs: Array of movie frams captured by getframe

function M=pendulum(L,tspan,y0,fps)
    t=linspace(tspan(1),tspan(2),fps*(tspan(2)-tspan(1)));
    g=9.81;
    
    % State Derivative Vector
    function dudt = odefun(~,Y,L,g)
       dudt=zeros(2,1);
       dudt(1,1)=Y(2);
       dudt(2,1)=(-g/L).*sin(Y(1));
    end
 
    [T,Y]=ode45(@(t,y) odefun(t,y,L,g),t,y0);
     
    % Positions of real and approx solution mass as a function of angle
    x=L*sin(Y(:,1));
    y=-L*cos(Y(:,1));
    
    naturalFreq=sqrt(g/L);
    thetaApprox=y0(2)/naturalFreq*sin(naturalFreq*t)+y0(1)*cos(naturalFreq*t);
    xApprox=L*sin(thetaApprox);
    yApprox=-L*cos(thetaApprox);
    
    
    %Animate approx and real solutions of rod and mass 
    for i=1:length(T)
       plot([0 x(i)], [0 y(i)], 'b');
       hold ON;
       plot([0 xApprox(i)], [0 yApprox(i)], 'r');
       plot(x(i),y(i),'bo','MarkerSize',10,'MarkerFaceColor','b'); 
       plot(xApprox(i),yApprox(i),'ro','MarkerSize',10,'MarkerFaceColor','r');
       xlim([-2*L 2*L]); ylim([-2*L 2*L]);
       M(i)=getframe(gcf);
       hold OFF;
    end   
    
    
end
