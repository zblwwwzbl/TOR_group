% run the built in function fmincon with specified constraint and set Y
function xmin = runBuiltin(u0,Y)
    fun = @(u)u(3);
    [m,~] = size(Y);
    function [c,ceq] = mycon(u)
        for i=1:m
            c(i,:) = -norm([u(1) u(2)] - Y(i,:))-u(3);
        end
        c(m+1,:) = u(1)^2+u(2)^2-1;
        ceq = [];
    end
    lb = [-Inf 0 -Inf];
    xmin = fmincon(fun, u0, [], [], [],[], lb, [], @mycon);
end