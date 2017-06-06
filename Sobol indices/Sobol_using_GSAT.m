% Use this program with caution. Check the specification of parameters of
% the lognormal distributions.  
%% Generate nominal values
nom = NominalValues();
%%
modNPV3 = zeros(10000,1);

for i = 1:10000
   modNPV3(i) = AccNPVNom(X(i,variables),nom,variables); %set insignificant variables to nom
end

%% Create project
N = 10000;
variables=...; % specify variables
l = length(variables);
pro = pro_Create();

%% specify inputs corresponding to variables
[m, s] = logen(0.6667,0.83333);
pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'cad2201');

[m, s] = logen(0.6,0.8);
pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'time'); 

[m, s] = logen(0.5,0.8);
pro = pro_AddInput(pro, @(N)pdf_LogNormal(N,m,s), '3mToxTime'); 

[m, s] = logen(0.1,0.2); 
pro = pro_AddInput(pro, @(N)pdf_LogNormal(N,m ,s), 'setuptime');

[m, s] = logen(1,3);
pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'RecruitmentRate/center');

[m, s] = logen(0.1,0.15);
pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'analysistime');

[m, s] = logen(1,1.5);
pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'Ph3StudyTime');

[m, s] = logen(1,1.1);
pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'RegTime');

[m, s] = logen(0.0026,0.0029);
pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'prevalence');

[m, s] = logen(3,5);
pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'RampTimeInYears');
        
pro = pro_SetModel(pro, @(X)AccNPVNom(X,nom,variables), 'model');
pro.N = N;

pro = GSA_Init(pro);

%% Calculate first order and total index
S=zeros(1,l); St = S;
eS = S; eSt = S;
  for i=1:l  
      [S(i), eS(i)] = GSA_GetSy(pro, {i});
      [St(i), eSt(i)] = GSA_GetTotalSy(pro,{i});
  end

%% display results 
disp('**************************************************')
disp('Sobol indices:')
disp(S)
disp('Error:')
disp(eS)
disp('Sobol total indices:')
disp(St)
disp('Error:')
disp(eSt)

%% List of all variables with distributions specified 
%[m, s] = logen(0.6667,0.83333);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'cad2201');
%
%[m, s] = logen(0.6,0.8);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'time'); 
%
%[m, s] = logen(0.5,0.8);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N,m,s), '3mToxTime'); 
%
%[m, s] = logen(0.1,0.2);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N,m ,s), 'setuptime');
%
%[m, s] = logen(1,3);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'RecruitmentRate/center');
%
%[m, s] = logen(0.1,0.15);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'analysistime');
%
%[m, s] = logen(0.6,1);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'batchForPH3Time');
%
%[m, s] = logen(1,1.1);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), '6MToxTime');
%
%[m, s] = logen(0.75,1);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), '3MPOCTime');
%
%[m, s] = logen(1,1.5);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'Ph3StudyTime');
%
%[m, s] = logen(1,1.1);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'RegTime');
%
%[m, s] = logen(2,2.2);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'Development costs1');
%
%[m, s] = logen(0.3,0.4);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'Development costs2');
%
%[m, s] = logen(0.25,0.3);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), '3MToxCostparam14');
%
%[m, s] = logen(1.5,1.8);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'prog1_Opt3m_');
%
%[m, s] = logen(0.1,0.3);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'SetupCost');
%
%[m, s] = logen(0.03,0.04);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'Cost/Patient');
%
%[m, s] = logen(1,1.2);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'Cost/Center');
%
%[m, s] = logen(0.1,0.2);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'AnalysisCost');
%
%[m, s] = logen(1,3);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'batchForPH3Cost');
%
%[m, s] = logen(0.3,0.4);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), '6MToxCost');
%
%[m, s] = logen(2,3);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'Development costs3');
%
%[m, s] = logen(75,95);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'ph3studyCosts');
%
%[m, s] = logen(10,20);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'ph3OtherCosts');
%
%[m, s] = logen(4,6);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'RegCosts');
% 
%[m, s] = logen(0.0026,0.0029);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'prevalence');
%
%[m, s] = logen(3,5);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'RampTimeInYears');
%
%pro = pro_AddInput(pro, @(N)pdf_Uniform(N,[0 1]), 'Comp1LaunchTime'); 
%
%pro = pro_AddInput(pro, @(N)pdf_Uniform(N,[2021.2 2022.5]), 'Comp2LaunchTime'); 
%
%[m, s] = logen(2020.8,2023.5);
%pro = pro_AddInput(pro, @(N)pdf_LogNormal(N, m, s), 'Comp3LaunchTime');
