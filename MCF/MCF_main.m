%% Monte Carlo filtering 
% workspace is saved in mcf.mat.
% figures used in report has been modified.
% 
%% Calculates NPV
addpath('functions')
n=1e4; % number of simulations
data=generate(n);
npv1=zeros(n,1);
for i=1:n
    X=data(:,i);
    npv1(i)=AccNPV(X,0,0,0);
end
 
%% Get variable names from SUM generated excel file 
[~,names,~] = xlsread('data.xlsx');
data1=[data;npv1'];
[row,col]=size(data1);
names={'\texttt{cadtime}', '\texttt{Time}','\texttt{3mToxTime}','' }

%%
names ={'Ph1Sucess', 'Ph2Sucess','Ph3Sucess', 'RegSucess', ...
    '\texttt{cadtime}', '\texttt{Time}','\texttt{3mToxTime}',... 
    '\texttt{POC\_SetupTime}', '\texttt{POC\_RecruitmentRate}', ... 
    '\texttt{POC\_AnalysisTime}', '\texttt{batchForPH3Time}',...
    '\texttt{6MToxTime}', '\texttt{3MPOCTime}','\texttt{Ph3StudyTime}', ...
    '\texttt{RegTime}', '\texttt{Development\_costs1}', ...
    '\texttt{Development\_costs2}', '\texttt{3MToxCost}', ...
    '\texttt{Other\_PH1\_Costs}','\texttt{POC\_SetupCost}' , ...
    '\texttt{POC\_CostPerPatient}', '\texttt{POC\_CostPerCenter}', ... 
    '\texttt{POC\_AnalysisCost}', '\texttt{batchForPH3Cost}', ...
    '\texttt{6MToxCost}', '\texttt{Development\_costs3}', ...
    '\texttt{ph3studyCosts}', '\texttt{ph3OtherCosts}', '\texttt{RegCosts}', ...
    '\texttt{prevalence}', '\texttt{RampTimeInYears}', ...
    '\texttt{Comp1DoesLaunch}', '\texttt{Comp1LaunchTime}', ...
    '\texttt{Comp2DoesLaunch}', '\texttt{Comp2LaunchTime}', ...
    '\texttt{Comp3DoesLaunch}', '\texttt{Comp3LaunchTime}'};

%% Group simulations, less or greater than eNPV. 
enpv=mean(data1(38,:));
mnpv=median(data1(38,:));
aa=find(data1(38,:)<=enpv); 
bb=find(data1(38,:)>enpv);
data2=data1(:,aa);   
data3=data1(:,bb);  
%% Kolmogorov-Smirnov test 
i=1;
for ii=5:row-1
   [h,p] = kstest2(data3(ii,:),data2(ii,:),'Alpha',0.05); 
   if p<=0.05  
       x(i)=ii; % save number of significant variables
       i=i+1;    
   end
end
%% Plot empirical distribution for significant variables 

set(0,'defaulttextinterpreter','latex')
figure;

for i=1:length(x)
    subplot(ceil(length(x)/2),2,i)
    [f2, x2]=ecdf(data2(x(i),:));
    [f3, x3]=ecdf(data3(x(i),:));
    plot(x2, f2,'b', x3, f3,'r')    
    title(names(x(i)), 'Fontsize', 14)
    xlabel('$x$')
    ylabel('$F(x)$')
end
legend('NPV<\xi', 'NPV>\xi')
