function val = l2(u, alpha, Y)
v=u(1);
x = [u(2),u(3)];
sums = max(0,-x(1))^2;
sums = sums + max(0,x(1)^2+x(2)^2-1)^2;
[m,n] = size(Y);
for i = 1:m
    sums = sums + max(0, -norm(x-Y(i))-v)^2;
val = u(1)+alpha/2*sums;
end

