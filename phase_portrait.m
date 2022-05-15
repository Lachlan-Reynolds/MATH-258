%%Name: Lachlan Reynolds
%%Date: November 5, 2020
%%Student Number: 14511638

%% Function: phase_portrait
    % Inputs: 
        % A, 2x2 Matrix
        % width, width of figure window
        % height: height of figure window
        % h: space between arros in slope field
        % N: number of plotted trajectories
    % Outputs: void
    % Purpose: Plot the phase portrait of the linear system dxdt = A
   
function phase_portrait(A,width,height,h,N)
    
    % Plot Arrows and Origin
    plot(0,0,'b','MarkerSize', 15);    
    x=-width:h:width;
    y=-height:h:width;
    
    [X,Y]=meshgrid(x,y);
    u=A(1,1)*X+A(1,2)*Y;
    v=A(2,1)*X+A(2,2)*Y;

    U=u./sqrt(u.^2+v.^2);
    V=v./sqrt(u.^2+v.^2);
   
    quiver(X,Y,U,V,0.5);
    hold ON;
    
    % Plot Nullclines and Origin
    plot(0,0,'b.','MarkerSize', 15);
    L= norm([width height]);
    
    xn=[A(1,2),-A(1,1)];
    xn=L*xn/norm(xn);
    plot([-xn(1), xn(1)],[-xn(2),xn(2)],'r--');
    
    yn=[A(2,2),-A(2,1)];
    yn=L*yn/norm(yn);
    plot([-yn(1), yn(1)],[-yn(2),yn(2)],'r--');
    
    %Find and plot Eigenvalues and Eigenvectors
    [evec,eval]=eig(A);
    if imag(eval(1,1))==0
       evec1=L*evec(:,1);
       plot([-evec1(1),evec1(1)],[-evec1(2),evec1(2)],'b');
       evec2=L*evec(:,2);
       plot([-evec2(1),evec2(1)],[-evec2(2),evec2(2)],'b');
    end
   
    %Set Up ODE
    odefun=@(t,y) A*y;

    options = odeset('Events', @stop);
    
    function [value,isterminal,direction] = stop(t,y)
        value = [1,1];
        if norm(y) > norm([width,height])
        value(1) = 0;
        end
        if norm(y) < 1e-5
        value(2) = 0;
        end
        isterminal = [1,1];
         direction = [0,0];
    end

    %Determining behavior of phase portrait based on realness of eigvalues
    %1. Purely imaginary Eigenvalues
    if (imag(eval(1,1)~=0)&&abs(real(eval(1,1)))<1e-15)
        tf=2*pi/imag(eval(1,1));
        for n=1:N
        [T,U] = ode45(@odefun, [0,tf], [width,height]*n/(N+1));
        plot(U(:,1),U(:,2),'b-');
        end
        
    %2. Positive and Real Eigenvalues
    elseif (real(eval(1,1))>0) && (real(eval(2,2))>0)
        tf=Inf;
        for theta=0:(2*pi/N):2*pi
            y0=0.5*L*[cos(theta),sin(theta)];
            [T,U]=ode45(odefun,[0,tf],y0,options);
            plot(U(:,1),U(:,2),'b-');
            [T,U]=ode45(odefun,[0,-tf],y0,options);
            plot(U(:,1),U(:,2),'b-');
        end

    %3. Saddlepoint origin
    else
        tf=Inf;
        N=floor(N/4);
        for n=[1:N,-N:-1]
            [T,U]=ode45(odefun,[0,tf],xn*n/(N+2),options);
            plot(U(:,1),U(:,2),'b-');
            [T,U]=ode45(odefun,[0,-tf],xn*n/(N+2),options);
            plot(U(:,1),U(:,2),'b-');
            
            [T,U]=ode45(odefun,[0,tf],yn*n/(N+2),options);
            plot(U(:,1),U(:,2),'b-');
            [T,U]=ode45(odefun,[0,-tf],yn*n/(N+2),options);
            plot(U(:,1),U(:,2),'b-');
        end
    end
    
    %Set graph limits and make graph look nice
    title(['Phase Portrait for A= [',num2str(A(1,1)),',',num2str(A(1,2)),';',num2str(A(2,1)),',',num2str(A(2,2)),']']);
    xlim([-width,width]);
    ylim([-height,height]);


end
