% Our algorithm, find_min() as described in the report. This method accepts
% a descentMethod for unconstrained optimization, the penalty function and
% its gradient, the set Y, the tolerances, stepsize T, and a numTries
% argument, that controls how many times we optimize P_ak for each k.
function [umin,k] = findSP(descentMethod, penalty, gradPenalty, Y, tolerance1, tolerance2, tolerance3, T, numTries)

k = 0;
uk = [100 100 100];
while (k==0 || norm(uprev - uk) > tolerance3) 
    uprev = uk;
    ak = (k+1);
    fmin = 100;
    umin = [-1 -1 -1];
    for j = 1:numTries
        u0(1) = rand(1,1)*2-1;
        u0(2) = sqrt(1-u0(1)^2)*rand(1,1);
        u0(3) = rand(1,1);
        [ustar,f,~] = feval(descentMethod,penalty, gradPenalty, ak, u0, Y, tolerance1, tolerance2, T);
        if (f < fmin)
            fmin = f;
            umin = ustar;
        end
    end
    uk = umin;
    k = k+1;
end
umin = uk;
