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

function [xminEstimate, fminEstimate,k] = NewtonMethod(f, gradf, hessf, x0, tolerance1, tolerance2, T)
    k = 0;  % initialize iteration counter
    xk = x0;
    while ( norm(feval(gradf, xk)) >= tolerance1 )
        feval(gradf, xk);
        Hessian = feval(hessf, xk);
        Hessian = Hessian ./ max(max(Hessian)); % Correction if det Hessian gets too lagre or small

        if (eig(Hessian) > 0)   % Checks to see if the Hessian is positive definite
            dk = transpose(-Hessian^(-1) * transpose(feval(gradf, xk))); % the Newton direction - as a row vector
        else
            dk = -feval(gradf, xk);  % the steepest descent direction.
        end
        % minimise f with respect to t in the direction dk, which involves
        % two steps:
        % (1) find upper and lower bound,[a,b],for the stepsize t 
        % using the "improved procedure" presented in the lecture notes
        [a, b] = multiVariableHalfOpen(f, xk, dk, T);
         % (2) use golden section algorithm (suitably modified for
         % functions of more than one variable) to estimate the 
         % stepsize t in [a,b] which minimises f in the direction dk
         % starting at xk
         [tmin, fmin] = multiVariableGoldenSectionSearch(f, a, b, tolerance2, xk, dk);
         % note: we do not actually need fmin, but we do need
         % tmin
         % update the steepest descent iteration counter and the
         % current iterate
         k = k + 1;
         xk = xk + tmin*dk; 
    end  
    % assign output values
    xminEstimate = xk;
    fminEstimate = feval(f,xminEstimate);
end