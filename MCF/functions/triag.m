function r=triag(a,b,c) % genererar ett slumptal fr�n en triangelf�rdelning
% med parametrar a, b och c
pd = makedist('Triangular','a',a,'b',b,'c',c);
r=random(pd,1,1);
end