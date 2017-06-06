%% Calculate NPV in different ways
[X,~,~] = xlsread('data');
Y = rand(10000,38);

NPV1 = zeros(10000,1);
NPV2 = NPV1; NPV3 = NPV1; NPV4 = NPV1;

for i = 1:10000;
   NPV1(i) = AccNPV(X(i,:)',1,1,0); 
   NPV2(i) = AccNPV(X(i,:)',0,1,0);
   NPV3(i) = AccNPV(X(i,:)',0,0,0);
   NPV4(i) = AccNPV(Y(i,:)',0,0,1);
end
%% Calculate mean and SD
eNPV1 = mean(NPV1);
error1 = std(NPV1)/100;

eNPV2 = mean(NPV2);
error2 = std(NPV2)/100;

eNPV3 = mean(NPV3);
error3 = std(NPV3)/100;

eNPV4 = mean(NPV4);
error4 = std(NPV4)/100;
