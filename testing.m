% This script runs individual instances of our algorithm, and the built in
% function
u = [0,0,-1];
alpha = 1;
Y = [1 0; -1 0; 0 1];    

runBuiltin(u,Y)
umin = findSP('acceleratedSD','l2','gradl2', Y,0.001,0.001,0.001,2,1);
xproj = orthogonalProjection(umin);
fmin = f(xproj, Y);
ans = [xproj(1), xproj(2), fmin]
