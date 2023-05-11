% script to call steepestDescentMethod, NewtonMethod, BFGS (2D)

tStart0 = tic; % starts a stopwatch timer to measure performance
numInstances = 1;
stationary_points = [];

for i = 1:numInstances
    tStart = tic;  % internal timer
     switch i
         case 1
             x0 = [1,1];
         case 2
             x0 = [1.5,1];
     end
    tolerance1 = 0.01; %tolerance for search methods
    tolerance2 = 0.001; % tolerance for Golden section search
    T = 2; %step size
    disp('Initial condition: '); 
    disp(x0);

    [xmin,f,k] = steepestDescentMethod('f', 'gradf', x0, tolerance1, tolerance2, T) ;

    disp('Steepest Descent Method');
    display([xmin, f, k]);

    [xmin,f,k] = NewtonMethod('f', 'gradf', 'hessf', x0, tolerance1, tolerance2, T);
    
    disp('Netwon Method');
    disp([xmin, f, k]);

    [xmin,f,k] = BFGS('f', 'gradf', x0, eye(2), tolerance1, tolerance2, T) ;

    disp('BFGS');
    disp([xmin, f, k]);
    
    tElapsed = toc(tStart);
    disp(['Time used is ', num2str(tElapsed)]);
end

averageTime = toc(tStart0)/numInstances;
disp(['Average time for ', num2str(numInstances), ' is ', num2str(averageTime)]); 