function NPV = AccNPV(X,PhaseBer,MarketBer,HyperCube)
% This function computes NPV.

    if HyperCube
        simulation = accTransform(X);
        uniform = rand(4,1);
        Bernoulli = uniform < [0.5; 0.5; 0.7; 0.9];
        simulation(1:4) = Bernoulli;
    else
        simulation = X;
    end
    
    if PhaseBer
        I1 = simulation(1);
        I2 = simulation(1)*simulation(2);
        I3 = simulation(1)*simulation(2)*simulation(3);
        I4 = simulation(1)*simulation(2)*simulation(3)*simulation(4);
    else
        I1 = 0.5; I2 = 0.25; I3 = 0.175; I4 = 0.1575;
    end
    
    %if MarketBer
    %    M = @(x,y) Market(x,y);
    %else
    %    M = @(x,y) ModMarket(x,y);
    %end
    
    interest = 1.1;
    startTime=2016.3;
    endTime=2047;
    projectlength = ceil(endTime-startTime);
    

    [t1, cf] = Phase1(simulation); %Phase1 is always initialized
    T = t1;
    CASH = cf;
    
    [t2, cf] = Phase2(simulation,T);%t2= T + Phase2Time 
    T = t2;
    CASH = CASH + I1*cf; %Costs yield negative Cashflow
    
    [t3, cf] = Phase3(simulation,T);
    T = t3;
    CASH = CASH + I2*cf;
    
    [t4, cf] = Registration(simulation,T);
    T = t4;
    CASH = CASH + I3*cf;
    
    if MarketBer
        [REV, COST] =Market(simulation,startTime+T);
        CASH = CASH + I4*(REV-COST) ;
    else
        [REV, COST] =ModMarket(simulation,startTime+T);
        CASH = CASH + I4*(REV-COST) ;
    end

    NPV = (1/interest).^(1:projectlength)*CASH;

end

