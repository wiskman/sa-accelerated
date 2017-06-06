function f=generate(n)
% returnerar en n x 38 -matris med invariabler f�r Accelerated
f=zeros(37,n);
 f(1,:) = binornd(1,0.5,[1,n]); % 3M_Ph1_Success
 f(2,:) = binornd(1,0.5,[1,n]); % Ph2 Success?
 f(3,:) = binornd(1,0.7,[1,n]); % Ph3 Success?
 f(4,:) = binornd(1,0.9,[1,n]); % Reg Success?
 
 [m, s] = logen(0.6667,0.83333); 
 f(5,:) = lognrnd(m,s,[1,n]); % cad2201_1_opt3m_time
 
 
 [m, s] = logen(0.6,0.8);
 f(6,:) = lognrnd(m,s,[1,n]); % Time
 
 [m, s] = logen(0.5,0.8);
 f(7,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_3mToxTime
 
 [m, s] = logen(0.1,0.2);
 f(8,:) = lognrnd(m,s,[1,n]); % ACC_POC_SetupTime
 
 [m, s] = logen(1,3);
 f(9,:) = lognrnd(m,s,[1,n]); % ACC_POC_RecruitmentRatePerCenterPerMonth
 
 [m, s] = logen(0.1,0.15);
 f(10,:) = lognrnd(m,s,[1,n]); % ACC_POC_AnalysisTime
 
 [m, s] = logen(0.6,1);
 f(11,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_batchForPH3Time
 
 [m, s] = logen(1,1.1);
 f(12,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_6MToxTime
 
 [m, s] = logen(0.75,1);
 f(13,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_3MPOCTime
 
 [m, s] = logen(1,1.5);
 f(14,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_Ph3StudyTime
 
 [m, s] = logen(1,1.1);
 f(15,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_RegTime
 
 [m, s] = logen(2,2.2);
 f(16,:) = lognrnd(m,s,[1,n]); % Development costs
 
 [m, s] = logen(0.3,0.4);
 f(17,:) = lognrnd(m,s,[1,n]); % Development costs
 
 [m, s] = logen(0.25,0.3);
 f(18,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_3MToxCost
 
 [m, s] = logen(1.5,1.8);
 f(19,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_
 
 [m, s] = logen(0.1,0.3);
 f(20,:) = lognrnd(m,s,[1,n]); % ACC_POC_SetupCost
 
 [m, s] = logen(0.03,0.04);
 f(21,:) = lognrnd(m,s,[1,n]); % ACC_POC_CostPerPatient
 
 [m, s] = logen(1,1.2);
 f(22,:) = lognrnd(m,s,[1,n]); % ACC_POC_CostPerCenter
 
 [m, s] = logen(0.1,0.2);
 f(23,:) = lognrnd(m,s,[1,n]); % ACC_POC_AnalysisCost
 
 [m, s] = logen(1,3);
 f(24,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_batchForPH3Cost
 
 [m, s] = logen(0.3,0.4);
 f(25,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_6MToxCost
 
 [m, s] = logen(2,3);
 f(26,:) = lognrnd(m,s,[1,n]); % Development costs
 
 [m, s] = logen(75,95);
 f(27,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_ph3studyCosts
 
 [m, s] = logen(10,20);
 f(28,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_ph3OtherCosts
 
 [m, s] = logen(4,6);
 f(29,:) = lognrnd(m,s,[1,n]); % prog1_Opt3m_RegCosts
 
 [m, s] = logen(0.0026,0.0029);
 f(30,:) = lognrnd(m,s,[1,n]); % prog1_prevalence
 
 [m, s] = logen(3,5);
 f(31,:) = lognrnd(m,s,[1,n]); % prog1_RampTimeInYears
 
 f(32,:) =  binornd(1,0.2,[1,n]); % prog1_Comp1DoesLLaunch
 
 for i=1:n
 f(33,i) = triag(2021.1,2022.3,2023.1); % prog1_Comp1LaunchTime
 end
 
 f(34,:) =  binornd(1,0.2,[1,n]); % prog1_Comp2DoesLLaunch
 
 f(35,:) = unifrnd(2021.2,2022.5,[1,n]); % prog1_Comp2LaunchTime
 
 f(36,:) =  binornd(1,0.2,[1,n]); % prog1_Comp3DoesLLaunch
 
 [m, s] = logen(2020.8,2023.5);
 f(37,:) = lognrnd(m,s,[1,n]); % prog1_Comp3LaunchTime
 
%  X=f(:,1:37);
%  A=zeros(n,1);
%  T=0.7;
%  for i=1:n
%     [A(i),~]=Registration(X(i,:),T);
%     A(i)=A(i)+2016.3;
%  end
%  for i=1:n
%  f(i,38)=1+f(i,32)*indicate1(f(i,33),A)+f(i,34)*indicate1(f(i,35),A)+f(i,36)*indicate1(f(i,37),A);
%  % OrderOfEntry
%  end
 
end









