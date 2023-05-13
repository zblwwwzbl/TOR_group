function val = logb(u, alpha, Y)
    v=u(3);
    x = [u(1),u(2)];
    sums = log(x(2));
    sums = sums + log(-(x(1)^2+x(2)^2-1));
    [m,~] = size(Y);
    for i = 1:m
        sums = sums + log(norm(x-Y(i,:))+v);
    end
    val = v-sums*1/alpha;
    if (~isreal(val))
        val = Inf;
    end
end
