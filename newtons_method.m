% Name: Lachlan Reynolds
% Date: October 6, 2020
% Student Number: 14511638
%% Function: newton
% Paramters: function with function handle f, its derivative, Df, initial
% guess, tolerance on solution and max number of steps that the algorithm
% should take

% Outputs: root, number of steps taken, total time taken to get within the
% tolerance

% Purpose: Ues newtons method to estimate the roots of a function

function [root,num_steps,total_time] =newton(f,Df,x0,tolerance,max_steps)
   
   % Initialize constants 
   tic;
   tstart=tic;
   x=x0-(f(x0)/Df(x0));
   
  
   
   % Overall Control Loop
    for num_steps=0:1:max_steps
       
        x=x-(f(x)/Df(x));
        root=x;
       
        % 2 terminating conditions, 0 derivative or within tolerance
        if abs(f(x))<= tolerance || Df(x)==0
            break;
        end
        
    end
   
    
    % Re-write root, num_steps and total time if 0 derivative found
    if Df(x)==0
      root=NaN; 
      num_steps=NaN;
      total_time=NaN;
      disp(["Program terminated because f'(x)=0. No root found."]);
    else
      total_time=toc(tstart);
    end 
    
    % Exceed max interations  
    if num_steps==max_steps
        root=NaN;
        disp(['Program terminated after ', num2str(max_steps), ' iterations. No root found']);
    end
   
    % Display
    disp(['Found root ', num2str(root), ' after ', num2str(num_steps), ' iteration in ', num2str(total_time), ' seconds']);
    
    end
