% script to call steepestDescentMethod, NewtonMethod, BFGS (2D)

tStart0 = tic; % starts a stopwatch timer to measure performance
maxYSize = 50;
numTrials = 10;
l2_points = [];
builtin_points = [];
tolerance1 = 0.01; % tolerance for search methods
tolerance2 = 0.001; % tolerance for Golden section search
tolerance3 = 0.01; % tolerance for u^k
T = 2; %step size
range = 4; % controls coordinate of yi

for size = 1:maxYSize
    for i =1:numTrials
        Y = range*(rand(size,2)-0.5);
        index = (size-1)*numTrials + i;
        for numTries = 1:10
        tStart = tic;
        umin = findSP('BFGS','l2','gradl2', Y,tolerance1,tolerance2,tolerance3,T,10);
        xproj = orthogonalProjection(umin);
        fmin = f(xproj, Y);
        tElapsed = toc(tStart);
        l2_points(index,:) = ['BFGSsize, xproj, fmin, tElapsed];
    end
end
header = {'size', 'x1', 'x2', 'fmin', 'time'};
writecell(header, 'l2_res.csv','Delimiter', ',');
writematrix(l2_points, 'l2_res.csv', 'Delimiter', ',', 'WriteMode', 'append');
writecell(header, 'builtin_res.csv','Delimiter', ',');
writematrix(builtin_points, 'builtin_res.csv', 'Delimiter', ',', 'WriteMode', 'append');



