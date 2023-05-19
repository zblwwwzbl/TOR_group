% script to call fun the built-in and our algorithm. Ths is how our experimental
% results are produced. Note that part of the code is commented, and they 
% are uncommented if we wanted to test out features about those functions.

tStart0 = tic; % starts a stopwatch timer to measure performance
maxYSize = 400;
numTrials = 5;
points = [];
tolerance1 = 0.001; % tolerance for search methods
tolerance2 = 0.001; % tolerance for Golden section search
tolerance3 = 0.001; % tolerance for u^k
T = 2; %step size
numTries = 1;
range = 4; % controls coordinate of yi

for size = 1:10:maxYSize
    for i =1:numTrials
        Y = range*(rand(size,2)-0.5);

        % tStart = tic;
        % umin = findSP('BFGS','logb','gradlogb', Y,tolerance1,tolerance2,tolerance3,T,numTries);
        % xproj = orthogonalProjection(umin);
        % fmin = f(xproj, Y);
        % tElapsed = toc(tStart);
        % points  = [points; 1, size, xproj, fmin, tElapsed];

        tStart = tic;
        umin = findSP('BFGS','l2','gradl2', Y,tolerance1,tolerance2,tolerance3,T,numTries);
        xproj = orthogonalProjection(umin);
        fmin = f(xproj, Y);
        tElapsed = toc(tStart);
        points  = [points; 2, size, xproj, fmin, tElapsed];

        % tStart = tic;
        % umin = findSP('acceleratedSD','l2','gradl2', Y,tolerance1,tolerance2,tolerance3,T,numTries);
        % xproj = orthogonalProjection(umin);
        % fmin = f(xproj, Y);
        % tElapsed = toc(tStart);
        % points  = [points; 5, size, xproj, fmin, tElapsed];
        % 
        % tStart = tic;
        % umin = findSP('steepestDescentMethod','l2','gradl2', Y,tolerance1,tolerance2,tolerance3,T,numTries);
        % xproj = orthogonalProjection(umin);
        % fmin = f(xproj, Y);
        % tElapsed = toc(tStart);
        % points  = [points; 3, size, xproj, fmin, tElapsed];
        
        % u0 = range*(rand(1,3)-0.5);
        % tStart = tic;
        % umin = runBuiltin(u0, Y);
        % fmin = f([umin(1), umin(2)], Y);
        % tElapsed = toc(tStart);
        % points = [points; 4, size, umin(1), umin(2), fmin, tElapsed];

        tStart = tic;
        fbest = 100;
        for j=1:5
            umin = findSP('BFGS','l2','gradl2', Y,tolerance1,tolerance2,tolerance3,T,numTries);
            xproj = orthogonalProjection(umin);
            fmin = f(xproj, Y);
            if (fmin < fbest)
                fbest = fmin;
            end
        end
        tElapsed = toc(tStart);
        points = [points; 5, size, xproj, fbest, tElapsed];

        tStart = tic;
        fbest = 100;
        for j=1:10
            umin = findSP('BFGS','l2','gradl2', Y,tolerance1,tolerance2,tolerance3,T,numTries);
            xproj = orthogonalProjection(umin);
            fmin = f(xproj, Y);
            if (fmin < fbest)
                fbest = fmin;
            end
        end
        tElapsed = toc(tStart);
        points = [points; 6, size, xproj, fbest, tElapsed];
    end
    disp(size)
end
header = {'type', 'size', 'x1', 'x2', 'fmin', 'time'};
writecell(header, 'l2_boost_res.csv','Delimiter', ',');
writematrix(points, 'l2_boost_res.csv', 'Delimiter', ',', 'WriteMode', 'append');




