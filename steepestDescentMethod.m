% Matlab function m-file:   steepestDescentMethod.m
%
% INPUT: 
%
%   f               - the multivariable function to minimise (a separate
%                       user-defined Matlab function m-file)
%
%  gradf        - function which returns the gradient vector of f evaluated
%                       at x (also a separate user-defined Matlab function
%                       m-file)
%
% x0                - the starting iterate
%
% tolerance1   - tolerance for stopping criterion of steepest descent
%                           method
%
% tolerance2  - tolerance for stopping criterion of line minimisation (eg: in golden section search)
%
% T                     - parameter used by the "improved algorithm for
%                           finding an upper bound for the minimum" along
%                           each given descent direction
%
% OUTPUT:
%
% xminEstimate  - estimate of the minimum
%
% fminEstimate  - the value of f at xminEstimate

function [xminEstimate, fminEstimate,k] = steepestDescentMethod(penalty, gradPenalty, ak, u0, Y, tolerance1, tolerance2, T)

k = 0;  % initialize iteration counter

uk = u0;

while ( norm(feval(gradPenalty, uk, ak, Y)) >= tolerance1 )
      
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
             uk = uk + tmin*dk;
       end  
    
    % assign output values
    
    
    xminEstimate = uk;
    fminEstimate = feval(penalty,xminEstimate, ak, Y);
    
    
    
    
    
        
    
    
    
  
