function xmin = runBuiltin(u0,Y)
    fun = @(u)u(1);
    [m,n] = size(Y);
    function [c,ceq] = mycon(u)
        for i=1:m
            c(1,:) = -norm([u(2) u(3)] - Y(i,:))-u(1);
        end
        c(m+2,:) = u(2)^2+u(3)^2-1;
        ceq = [];
    end
    lb = [-Inf -Inf 0];
    xmin = fmincon(fun, u0, [], [], [],[], lb, [], @mycon);
end