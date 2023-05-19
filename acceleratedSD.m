% ASD algorithm. Adapted from code provided in assignment 2
%
% xminEstimate  - estimate of the minimum
%
% fminEstimate  - the value of f at xminEstimate

function [xminEstimate, fminEstimate,k] = acceleratedSD(penalty, gradPenalty, ak, u0, Y, tolerance1, tolerance2, T)

k = 0;  % initialize iteration counter

uk = u0;
% lambdak = 0;
yk = u0;
uprev = u0;

while ( norm(feval(gradPenalty, uk, ak, Y)) >= tolerance1 ) 

    if (k >= 1000) 
        break; 
    end
      
    % calculate steepest descent direction vector at current iterate xk
    %du = feval(gradf, xk);
    %dk = -du/norm(du);
    
    dk = -1*feval(gradPenalty, uk, ak, Y);  % a row vector
    
    % minimise f with respect to t in the direction dk, which involves
    % two steps:
    
            % (1) find upper and lower bound,    [a,b]   ,for the stepsize t using the "improved
            % procedure" presented in the lecture notes
    
            [a, b] = multiVariableHalfOpen(penalty, uk, ak, Y, dk, T);
               
             % (2) use golden section algorithm (suitably modified for
             % functions of more than one variable) to estimate the 
             % stepsize t in [a,b] which minimises f in the direction dk
             % starting at xk
                 
             [tmin, ~] = multiVariableGoldenSectionSearch(penalty, ak, Y, a, b, tolerance2, uk, dk);
             
             
             % note: we do not actually need fmin, but we do need
             % tmin
             
             % update the steepest descent iteration counter and the
             % current iterate
             
             k = k + 1;
             % yprev = yk;
             % yk = uk + tmin*dk;
             % lambdaprev = lambdak;
             % lambdak = (1 + sqrt(1 + 4*lambdak^2))/2;
             % gammak = (1-lambdaprev)/lambdak;
             % uk = (1-gammak)*yk + gammak*yprev;
             uk = yk + tmin*dk;
             yk = uk + (k-1)/(k+2)*(uk - uprev);
             uprev = uk;


       end  
    
    % assign output values
    
    
    xminEstimate = uk;
    fminEstimate = feval(penalty,xminEstimate, ak, Y);
    