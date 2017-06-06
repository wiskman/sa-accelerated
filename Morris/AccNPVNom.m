%% Improved Accelerated NPV

function f = AccNPVNom(X, nom, variables)
    simulations = nom;
    nOfX = length(variables);
    for i = 1:nOfX;
        simulations(variables(i)) = X(i);
    end
   f = AccNPV(simulations,0,0,0);
end