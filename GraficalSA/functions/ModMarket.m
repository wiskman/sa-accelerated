function [REVENUE, COST] = ModMarket(simData, RE)
        startTime=2016.3;
        endTime=2047; % start = 2016-03-01, end = 2046-12-31
        projectlength = ceil(endTime-startTime);
        PatentExpiry=2033.2;
        SalesPrice_US=0.00365;                 
        RatioEligible=0.25;                    
        dt=.05;
        prevalence=simData(30);
        RampTime=simData(31);
        p = [0.2 0.2 0.3];
        q = 1-p;
        permutations = [1 1 1;0 1 1;1 0 1;1 1 0;0 0 1;0 1 0;1 0 0;0 0 0];
        nPermutations = size(permutations)*[1;0];
        CompTimes = [simData(33); simData(35); simData(37)];
        OrderOfEntries = 1 + permutations*(CompTimes < RE);
        COST = zeros(projectlength,1);
        REVENUE = COST;
        for i = 1:nPermutations
            iPermutation = permutations(i,:);
            iP = prod(p.^iPermutation)*prod(q.^(1-iPermutation));
            OrderOfEntry = OrderOfEntries(i);
            T = RE;
            k = ceil(RE)-floor(startTime)-1;
        
            while T < endTime
                if (T-dt-floor(T))*(T-floor(T))<0
                    k=k+1;
                end
                absIncome  = ModIncome(T,iPermutation,OrderOfEntry);
                REVENUE(k) = REVENUE(k)+iP*absIncome;
                T = T + dt;
            end
        end
      COST = 0.1*REVENUE; 
      function [absIncome]  = ModIncome(T,Permutation,OrderOfEntry)
            % checks behavior of market at time T and calculates the income in
            % [T, T+dt]
            % T=[RE, endTime]
      NumberOfEntries=1+Permutation*(CompTimes<T);
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

