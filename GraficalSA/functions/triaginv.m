function f =triaginv(P,a,b,c)
    if P == 0
        f = a;
    elseif P == 1
        f = b;
    elseif P<=(c-a)/(b-a)
        f = a+sqrt(P*(b-a)*(c-a));
    else
        f = b - sqrt((b-a)*(c-a)*(1-P));
    end
end