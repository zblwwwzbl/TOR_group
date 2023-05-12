syms x1 x2 v
f = symfun(ff(x1,x2,v), [x1 x2 v]);
f(1, 3, 5)
gradient_f = gradient(f, [x1 x2 v]);  % Compute the gradient
vpa(gradient_f(1,3,5))  % Substitute point x into the gradient expression

function val = ff(x1,x2,v)
    sums = max(0,-x2)^2;
    alpha = 1;
    x = [x1 x2];
    Y = [1 0; -1 0];
    sums = sums + max(0,x1^2+x2^2-1)^2;
    [m,~] = size(Y);
    for i = 1:m
        sums = sums + max(0, -norm(x-Y(i,:))-v)^2;
    end

    val = v+sums*alpha/2;
end

