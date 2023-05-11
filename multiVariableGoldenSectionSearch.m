% Matlab function m-file : multiVariableGoldenSectionSearch.m
%
% performs golden section search for finding minimum of f along the
% direction d, starting at x, where the minimum has upper and lower bound
% [a,b]


function [minEstimate, fminEstimate] = multiVariableGoldenSectionSearch(f,alpha,Y,a,b,tolerance, u, d)

% Check that the correct number of input arguments have been passed to the
% function (this is not essential, but it helps to detect user error)

% Check that input parameters have appropriate values

    if(b <= a)
        error('b must be strictly greater than a')    
    end
    
    if(tolerance <= 0)
        error('tolerance must be strictly positive')
    end

    
% begin the Golden Search algorithm

gamma = (sqrt(5) - 1)/2;  

k = 1;  % iteration counter

p = b - gamma*(b-a);
q = a + gamma*(b-a);

fp = feval(f, u + p*d, alpha, Y);
fq = feval(f, u + q*d, alpha, Y);

while ( (b-a) >= 2*tolerance )
    
    k = k + 1;
    
    if (fp <= fq) 
        
        b = q;
        q = p;
        fq = fp;
        
        p = b - gamma*(b-a);
        fp = feval(f, u + p*d, alpha, Y);
        
    else   
    
        a = p;
        p = q;
        fp = fq;
        
        q = a + gamma*(b-a);
        fq = feval(f, u + q*d, alpha, Y);
        
    end

end

% assign the output values of this function

minEstimate = (a+b)/2;      % the midpoint of the final interval
fminEstimate = feval(f, u + minEstimate*d, alpha, Y);  


    
    
    
    
    
    
    
    
    
    
    