function f = NominalValues()
    e=@(mu, sigma)exp(mu+sigma^2/2);
    f=zeros(38,1);
    
    [m, s] = logen(0.6667,0.83333);
        f(5)=e(m,s);
    [m, s] = logen(0.6,0.8);
        f(6)=e(m,s);
    [m, s] = logen(0.5,0.8);
        f(7)=e(m,s);
    [m, s] = logen(0.1,0.2);
        f(8)=e(m,s);
    [m, s] = logen(1,3);
        f(9)=e(m,s);
    [m, s] = logen(0.1,0.15);
        f(10)=e(m,s);
    [m, s] = logen(0.6,1);
        f(11)=e(m,s);
    [m, s] = logen(1,1.1);
        f(12)=e(m,s);
    [m, s] = logen(0.75,1);
        f(13)=e(m,s);
    [m, s] = logen(1,1.5);
        f(14)=e(m,s);
    [m, s] = logen(1,1.1);
        f(15)=e(m,s);
    [m, s] = logen(2,2.2);
        f(16)=e(m,s);
    [m, s] = logen(0.3,0.4);
        f(17)=e(m,s);
    [m, s] = logen(0.25,0.3);
        f(18)=e(m,s);
    [m, s] = logen(1.5,1.8);
        f(19)=e(m,s);
    [m, s] = logen(0.1,0.3);
        f(20)=e(m,s);
    [m, s] = logen(0.03,0.04);
        f(21)=e(m,s);
    [m, s] = logen(1,1.2);
        f(22)=e(m,s);
    [m, s] = logen(0.1,0.2);
        f(23)=e(m,s);
    [m, s] = logen(1,3);
        f(24)=e(m,s);
    [m, s] = logen(0.3,0.4);
        f(25)=e(m,s);
    [m, s] = logen(2,3);
        f(26)=e(m,s);
    [m, s] = logen(75,95);
        f(27)=e(m,s);
    [m, s] = logen(10,20);
        f(28)=e(m,s);
    [m, s] = logen(4,6);
        f(29)=e(m,s);
    [m, s] = logen(0.0026,0.0029);
        f(30)=e(m,s);
    [m, s] = logen(3,5);    
        f(31)=e(m,s);
        
    f(33)=2022.3; %triangular
    
    f(35)=(2022.5-2021.2)/2; % uniform

    [m, s] = logen(2021.2,2022.5); % lognormal
    
    f(37)=e(m,s);
end