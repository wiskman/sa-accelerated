%% FAST

variables = [5 9 14 30 31];
nFac = length(variables); %Number of input variables
Nr = 2; % Number of phase replications
M = 4;
phi = 2*pi*rand(Nr,nFac);
w = [ 11, 21, 27, 35, 39] ; %Appropriate angular frequencies
Ns = 2*max(w)*M+1;
t = linspace(0,2*pi,Ns);
t = ones(nFac,1)*t;
X = zeros(Nr*nFac,Ns);
y = zeros(Nr,Ns);
nom = NominalValues();

for i =1:Nr
    T = diag(w)*t+diag(phi(i,:))*ones(nFac,Ns);
    x=0.5+(asin(sin(T)))/pi;
    X((nFac*(i-1)+1):i*nFac,:) = x;
    for j=1:Ns
        x1 = 0.5*ones(38,1);
        
        for k=1:nFac
            x1(variables(k)-4) = x(k,j);
        end
        
        x1 = accTransform(x1);
        x0 = nom;
        
        for k=variables
           x0(k) = x1(k); 
        end
        
        y(i,j) = AccNPV(x0,0,0,0);
    end
    
end

%%

yhat = fft(y');

c2 = abs(yhat).^2;

D = sum(c2(2:floor(Ns/2),:));
D1 = zeros(nFac,1);

for i = 1:nFac
    D0 = sum(c2(w(i):(w(i)):floor(Ns/2),:));
    D1(i) = sum(D0);
end

D1 = D1/sum(D);