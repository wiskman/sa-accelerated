function [Time, Cashflow] = Phase1(X)
    startTime=2016.3;
    endTime=2047;
    projectlength = ceil(endTime-startTime);
    times = [X(5:7); X(5)];
    Time = max(times);
    costs = X(16:19);

    Cashflow = zeros(projectlength,1);
    T = startTime-floor(startTime);
    ratio1 = 1 - (T-floor(T));
    for i = 1:4;
        T1 = T+times(i);
        if floor(T1)==floor(T) %The study does not span over more than 1 year
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