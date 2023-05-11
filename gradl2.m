function grad=gradl2(u,alpha,Y)
v = u(1);
x = [u(2),u(3)];
sums = max(0,-x(1)) * [0,-1,0];
sums = sums + max(0,x(1)^2+x(2)^2-1)*[2*x(1),2*x(2),0];
[m,n] = size(Y);
for i = 1:m
    length = norm(x-Y(i));
    sums = sums + max(0, -length-v)*[-(x(1)-Y(m,1))/length, -(x(2)-Y(m,2))/length, -1];
grad = [0,0,1]+alpha*sums;
end
