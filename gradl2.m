function grad=gradl2(u,alpha,Y)
    v = u(3);
    x = [u(1),u(2)];
    sums = max(0,-x(2)) * [0,-1,0];
    sums = sums + max(0,x(1)^2+x(2)^2-1)*[2*x(1),2*x(2),0];
    [m,~] = size(Y);
    for i = 1:m
        length = norm(x-Y(i,:));
        sums = sums + max(0, -length-v)*[-(x(1)-Y(i,1))/length, -(x(2)-Y(i,2))/length, -1];
    end
    grad = [0,0,1]+alpha*sums;
end
