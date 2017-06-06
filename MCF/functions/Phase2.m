function [Time, Cashflow] = Phase2(X,T)
    startTime=2016.3;
    endTime=2047;
    projectlength = ceil(endTime-startTime);
    times = X(8:13);
    times(2) = 400/(3*12*times(2))+0.25; %fixed treatment time (See first
    %the first activity of Phase2
    trialTimes = [sum(times(1:3)); X(11:13)];
    T1 = max(trialTimes);
    Time = T + T1;
    costs1 = X(20:26);
    costs = zeros(6,1);
    costs(1) = costs1(1);
    costs(2) = 400*costs1(2)+3*costs1(3); %num of patients and num of centers
    % = fixed
    costs(3:end) = costs1(4:end);
    Cashflow = zeros(projectlength,1);
    
    ratio1 = 1 - (T-floor(T));
    
    for i = 1:6;
        
        T1 = T+times(i);
        if floor(T1)==floor(T) %The Phase does not span over more than 1 year
            Cashflow(floor(T)+1) = Cashflow(floor(T)+1) - costs(i);
        else
           annualCost = costs(i)/times(i);
           n = floor(T1)-floor(T)-1; %Number of whole years
           ratio2 = T1 - floor(T1);
           annualTime = zeros(projectlength,1);
           annualTime(floor(T)+1) = ratio1;
           annualTime(floor(T1)+1) = ratio2;
           annualTime((floor(T)+2):floor(T1))=ones(n,1);
           Cashflow = Cashflow - annualCost*annualTime;
        end
    end
end