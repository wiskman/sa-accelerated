function f = HypercubeTransform(x,Nom,variables)
    X = 0.5*ones(33,1);
    n = length(variables);
    for j = 1:n
        X(variables(j)-4) = x(j);
    end
    X = accTransform(X);
    f = Nom;
    for j = variables
       f(j) = X(j);
    end
end