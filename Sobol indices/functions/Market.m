function [REVENUE, COST] = Market(simData, RE)
% returns cash flow vector from RE to end of sales 
% RE given as time from start in years, and simData is a 

% declare all constants
startTime=2016.3;
endTime=2047; % start = 2016-03-01, end = 2046-12-31
projectlength = ceil(endTime-startTime);
PatentExpiry=2033.2;
SalesPrice_US=0.00365;                 
RatioEligible=0.25;                    
dt=.05;

% assign sum data 
% maybe call Market with simData(30:38) and rewrite indices as 1:9
prevalence=simData(30);
RampTime=simData(31);
Comp1DoesLaunch=simData(32);
Comp1LaunchTime=simData(33);
Comp2DoesLaunch=simData(34);
Comp2LaunchTime=simData(35);
Comp3DoesLaunch=simData(36);
Comp3LaunchTime=simData(37);
OrderOfEntry=simData(38);

T = RE;
k = ceil(RE)-floor(startTime)-1;
COST = zeros(projectlength,1);
REVENUE = COST;
while T < endTime
    if (T-dt-floor(T))*(T-floor(T))<0
        k=k+1;
    end
    absIncome  = income(T);
    REVENUE(k) = REVENUE(k)+absIncome;
    T = T + dt;
end
COST = 0.1*REVENUE;


    function [absIncome]  = income(T)
       % checks behavior of market at time T and calculates the income in
       % [T, T+dt]
       % T=[RE, endTime]
       NumberOfEntries=1+Comp1DoesLaunch*(Comp1LaunchTime<T) + ...
                         Comp2DoesLaunch*(Comp2LaunchTime<T) + ...
                         Comp3DoesLaunch*(Comp3LaunchTime<T);
       PeakMarketShare= 0.5*(NumberOfEntries==1)*(OrderOfEntry==1) + ...
                        0.4*(NumberOfEntries==2)*(OrderOfEntry==1) + ...
                        0.2*(NumberOfEntries==2)*(OrderOfEntry==2) + ...
                        0.3*(NumberOfEntries==3)*(OrderOfEntry==1) + ...
                        0.2*(NumberOfEntries==3)*(OrderOfEntry==2) + ...
                        (NumberOfEntries==3)*(OrderOfEntry==3);
                    
      
      USPopulation=321e6*(1+0.0078)^(T-2014);
      USSales=USPopulation*prevalence*RatioEligible*PeakMarketShare*SalesPrice_US;
      slope=USSales/RampTime;
   
       if T>=endTime || RE==0 
            absIncome = 0;                        % no income
       elseif T>=RE && T<RE+RampTime  
            absIncome = slope*((T-RE)+dt/2)*dt;  % income from ramp time 
       elseif T>=RE+RampTime && T<=PatentExpiry
            absIncome = USSales*dt;                % income from peak 
          
       else    
            absIncome = 0.1*USSales*dt;            % income from after PatentExpiry
       end
    end


 
    








    

    




end






