alpha = 1;
u = [1,0,0];
Y = [0 0];

% runBuiltin(u,Y)
findSP('steepestDescentMethod','l2','gradl2', Y,0.01,0.01,0.01,2,10)