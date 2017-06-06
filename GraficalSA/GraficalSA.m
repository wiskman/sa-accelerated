% Ber?knar enpv
n=1e4; %antalet simuleringar
data=generate(n);
npv1=zeros(n,1);
for i=1:n
	X=data(:,i);
	npv1(i)=AccNPV(X,0,0,0);
end
enpv=mean(npv1);
%% 5e variabeln cad2201_1_opt3m_time
clc;
points=linspace(0.6667,0.83333);%fixerade 100 X_i-punkter mellan 5% och 95% kvantilerna
 n=1e2; %antalet simuleringar f??r att ber??kna "fixerade" npv
 tmpdata=data(:,1:n); % kopiera data
 npv5=zeros(n,100);
 enpv5=zeros(n,1); %"enpv-punkter"
 for i=1:100
 	for j=1:n
     	tmpdata(5,j)=points(i);
     	X=tmpdata(:,j);
     	npv5(j,i)=AccNPV(X,0,0,0);
 	end
 	enpv5(i)=mean(npv5(:,i));
 end
plot(points,enpv5-enpv) % plotta de hundra punkterna

%% 7e variabeln prog1_Opt3m_3mToxTime
clc;
points=linspace(0.5,0.8);
 n=1e2;
 tmpdata=data(:,1:n);
 npv7=zeros(n,100);
 enpv7=zeros(n,1);
 for i=1:100
 	for j=1:n
     	tmpdata(7,j)=points(i);
     	X=tmpdata(:,j);
     	npv7(j,i)=AccNPV(X,0,0,0);
 	end
 	enpv7(i)=mean(npv7(:,i));
 end
plot(points,enpv7-enpv)

%% 8e variabeln ACC_POC_SetupTime
clc;
points=linspace(0.1,0.2);
 n=1e2;
 tmpdata=data(:,1:n);
 npv8=zeros(n,100);
 enpv8=zeros(n,1);
 for i=1:100
 	for j=1:n
     	tmpdata(8,j)=points(i);
     	X=tmpdata(:,j);
     	npv8(j,i)=AccNPV(X,0,0,0);
 	end
 	enpv8(i)=mean(npv8(:,i));
 end
plot(points,enpv8-enpv)

%% 9e variabeln ACC_POC_RecruitmentRatePerCenterPerMonth
clc;
points=linspace(1,3);
 n=1e2;
 tmpdata=data(:,1:n);
 npv9=zeros(n,100);
 enpv9=zeros(n,1);
 for i=1:100
 	for j=1:n
     	tmpdata(9,j)=points(i);
     	X=tmpdata(:,j);
     	npv9(j,i)=AccNPV(X,0,0,0);
 	end
 	enpv9(i)=mean(npv9(:,i));
 end
plot(points,enpv9-enpv)

%% 10e variabeln ACC_POC_AnalysisTime
clc;
points=linspace(0.1,0.15);
 n=1e2;
 tmpdata=data(:,1:n);
 npv10=zeros(n,100);
 enpv10=zeros(n,1);
 for i=1:100
 	for j=1:n
     	tmpdata(10,j)=points(i);
     	X=tmpdata(:,j);
     	npv10(j,i)=AccNPV(X,0,0,0);
 	end
 	enpv10(i)=mean(npv10(:,i));
 end
plot(points,enpv10-enpv)

%%
% 14e variabeln prog1_Opt3m_Ph3StudyTime
[m, s] = logen(1,1.5);
points1=lognrnd(m,s,[1,100]);
n=1e4;
tmpdata=data;
npv14=zeros(n,100);
enpv14=zeros(n,1);
 for i=1:100
 	for j=1:n
     	tmpdata(14,j)=points1(i);
     	X=tmpdata(:,j);
     	npv14(j,i)=AccNPV(X,0,0,0);
 	end
 	enpv14(i)=mean(npv14(:,i));
 end
1

% 15e variabeln prog1_Opt3m_RegTime
[m, s] = logen(1,1.1);
points2=lognrnd(m,s,[1,100]);

tmpdata=data(:,1:n);
npv15=zeros(n,100);
enpv15=zeros(n,1);
 for i=1:100
 	for j=1:n
     	tmpdata(15,j)=points2(i);
     	X=tmpdata(:,j);
     	npv15(j,i)=AccNPV(X,0,0,0);
 	end
 	enpv15(i)=mean(npv15(:,i));
 end
2

% 27e variabeln prog1_Opt3m_ph3studyCosts
[m,s]=logen(75,95);
points3=lognrnd(m,s,[1,100]);

tmpdata=data(:,1:n);
npv27=zeros(n,100);
enpv27=zeros(n,1);
 for i=1:100
 	for j=1:n
     	tmpdata(27,j)=points3(i);
     	X=tmpdata(:,j);
     	npv27(j,i)=AccNPV(X,0,0,0);
 	end
 	enpv27(i)=mean(npv27(:,i));
 end
3

% 30e variabeln prog1_prevalence
[m, s] = logen(0.0026,0.0029);
points4=lognrnd(m,s,[1,100]);
tmpdata=data(:,1:n);
npv30=zeros(n,100);
enpv30=zeros(n,1);
 for i=1:100
 	for j=1:n
     	tmpdata(30,j)=points4(i);
     	X=tmpdata(:,j);
     	npv30(j,i)=AccNPV(X,0,0,0);
 	end
 	enpv30(i)=mean(npv30(:,i));
 end
4

% 31e variabeln prog1_RampTimeInYears
[m, s] = logen(3,5);
points5=lognrnd(m,s,[1,100]);
tmpdata=data(:,1:n);
npv31=zeros(n,100);
enpv31=zeros(n,1);
 for i=1:100
 	for j=1:n
     	tmpdata(31,j)=points5(i);
     	X=tmpdata(:,j);
     	npv31(j,i)=AccNPV(X,0,0,0);
 	end
 	enpv31(i)=mean(npv31(:,i));
 end
5
%%
maxvec=zeros(5,1);
minvec=zeros(5,1);
maxvec(1)=max(enpv14(1:100)-enpv);
maxvec(2)=max(enpv15(1:100)-enpv);
maxvec(3)=max(enpv27(1:100)-enpv);
maxvec(4)=max(enpv30(1:100)-enpv);
maxvec(5)=max(enpv31(1:100)-enpv);
minvec(1)=min(enpv14(1:100)-enpv);
minvec(2)=min(enpv15(1:100)-enpv);
minvec(3)=min(enpv27(1:100)-enpv);
minvec(4)=min(enpv30(1:100)-enpv);
minvec(5)=min(enpv31(1:100)-enpv);
b=max(maxvec);
a=min(minvec);

% subplot(3,2,1)
figure(1)
plot(points1,enpv14(1:100)-enpv,'k.')
xlabel('prog1\_Opt3m\_Ph3StudyTime')
ylabel('E[Y|X_i]-E[Y]')
ylim([a,b])

% subplot(3,2,2)
figure(2)
plot(points2,enpv15(1:100)-enpv,'k.')
xlabel('prog1\_Opt3m\_RegTime')
ylabel('E[Y|X_i]-E[Y]')
ylim([a,b])

% subplot(3,2,3)
figure(3)
plot(points3,enpv27(1:100)-enpv,'k.')
xlabel('prog1\_Opt3m\_ph3studyCosts')
ylabel('E[Y|X_i]-E[Y]')
ylim([a,b])

% subplot(3,2,4)
figure(4)
plot(points4,enpv30(1:100)-enpv,'k.')
xlabel('prog1\_prevalence')
ylabel('E[Y|X_i]-E[Y]')
ylim([a,b])

% subplot(3,2,5)
figure(5)
plot(points5,enpv31(1:100)-enpv,'k.')
xlabel('prog1\_RampTimeInYears')
ylabel('E[Y|X_i]-E[Y]')
ylim([a,b])

