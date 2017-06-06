function [Time, Cashflow]  = Registration(X,T)
    startTime=2016.3;
    endTime=2047;
    projectlength = ceil(endTime-startTime);
    T1 = T + X(15);
    Time = T1;
    
    Cost = X(29);
    Cashflow = zeros(projectlength,1);
    if floor(T1)==floor(T);
        Cashflow(floor(T1)+1) = -Cost;
    else
        annualCost = Cost/X(15);
        n = floor(T1)-floor(T)-1;
        ratio1 = 1 - (T-floor(T));
        ratio2 = T1 - floor(T1);
        annualTime = zeros(projectlength,1);
        annualTime(floor(T)+1) = ratio1;
        annualTime(floor(T1)+1) = ratio2;
        annualTime((floor(T)+2):floor(T1))=ones(n,1);
        Cashflow = Cashflow - annualCost*annualTime;
    end

end