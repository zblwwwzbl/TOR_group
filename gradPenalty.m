function val = gradPenalty(penalty, u, alpha, Y)
    function k = fun(x)
       k = l2(x,alpha,Y);
    end
    val = gradient(fun, u);
end
