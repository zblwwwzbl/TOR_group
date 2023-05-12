function val = f(x,Y)
    maxDist = -Inf;
    [m,n] = size(Y);
    for i=1:m
        dist = -norm(x-Y(i,:));
        maxDist = max(dist, maxDist);
    end
    val = maxDist;
end

