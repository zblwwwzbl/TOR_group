function val = l2(u, alpha, Y)
    v=u(3);
    x = [u(1),u(2)];
    sums = max(0,-x(2))^2;
    sums = sums + max(0,x(1)^2+x(2)^2-1)^2;
    [m,~] = size(Y);
    for i = 1:m
        sums = sums + max(0, -norm(x-Y(i,:))-v)^2;
    end
    val = v+sums*alpha/2;
end
