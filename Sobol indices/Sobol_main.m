nom = NominalValues();
variables = [5 6 7 8 9 10 14 15 30 31]; % from Morris screening 
n = length(variables);
N = 1e4;
%% Sobol first order index
Simulations = zeros(N,2+n);

for i = 1:N
    x = rand(n,1);
    y = rand(n,1);
    X = HypercubeTransform(x,nom,variables);
    Y = HypercubeTransform(y,nom,variables);
    Simulations(i,1) = AccNPV(X,0,0,0);
    Simulations(i,2) = AccNPV(Y,0,0,0);
    for j=1:n
        xy = x; xy(j) = y(j);
        XY = HypercubeTransform(xy,nom,variables);
        Simulations(i,j+2) = AccNPV(XY,0,0,0);
    end
end

% Sobol total index
f0 = mean([Simulations(:,1); Simulations(:,2)]);
f02 = mean([Simulations(:,1); Simulations(:,2)].^2);
V = f02-f0.^2;
Vfirst = zeros(n,1);
Vtotal = Vfirst;
e1 = Vfirst; e2 = Vfirst;
for i = 1:n
    x1 = Simulations(:,2).*(Simulations(:,i+2)-Simulations(:,1));
    x2 = 0.5*(Simulations(:,1)-Simulations(:,i+2)).^2;
    Vfirst(i) = mean(x1);
    Vtotal(i) = mean(x2);
    e1(i) = 1.96*std(x1)/sqrt(N);
    e2(i) = 1.96*std(x1)/sqrt(N);
end

Sfirst = Vfirst/V;
Stotal = Vtotal/V;

Results = [Sfirst e1/V Stotal e2/V];

reArr = [5     9     3     2    10     7     8     6     4     1];
% Print results
Results = Results(reArr,:)