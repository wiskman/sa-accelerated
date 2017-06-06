%% Improved Accelerated NPV

function f = AccNPVNomMorris(X, nom, variables)
    Y = X;
    [m, s] = logen(1,3);
    Y(1) = logninv(X(1),m,s);
    [m, s] = logen(1,1.5);
    Y(2) = logninv(X(2),m,s);
    [m, s] = logen(0.0026,0.0029);
    Y(3) = logninv(X(3),m,s);
    [m, s] = logen(3,5);
    Y(4) = logninv(X(4),m,s);
    simulations = nom;
    nOfX = length(variables);
    for i = 1:nOfX;
        simulations(variables(i)) = Y(i);
    end
   f = AccNPV(simulations,0,0,0);
end