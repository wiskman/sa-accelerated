function [ table_outputs2, table_ee2, factors_over2, n2, points2, initialization2 ] = loop_function( nfac, studied_function, table_outputs, table_ee, factors_over, n, points, initialization )
% Function for the calculation of the algorithm at one step.
% This function must be used in a loop (as in the file program_to_run.m).
% See program_to_run.m for further information about the variables.
%
% 8 INPUTS
% 1) nfac : Number of factors of uncertainty.         
% 2) studied_function : Function studied.                 
% 3) table_outputs : All the outputs of the simulations runs.
% 4) table_ee : All the elementary effects.
% 5) factors_over : Indexes of the factors over the limit at the end of the last step.
% 6) n : Step number.
% 7) points : Sampled points of the factors hyperspace.         
% 8) initialization : Boolean, the calculations foccus on the factors under the limit if it equals 1.
%
% 6 OUTPUTS : table_outputs2, table_ee2, factors_over2, n2, points2, initialization2 (see the description of the corresponding inputs)

%% DENSIFICATION

% Information about the points sampled
[npoint, mpoint] = size(points); % npoint is the number of points already sampled.

% If the step number is larger than the number of points already sampled, new points must be sampled
if npoint < n
    if npoint==0 % At the beginning of the algorithm, 4 points are first sampled
        npoint = 4;
    else
        npoint = npoint*3; % The number of points is multiplied by 3 at each densification
    end
    
    delta=1/npoint; % Distance between two successive discrete values in a given dimension.
    mini=delta/2; % Minimum discrete value in a given dimension.
    maxi=mini+delta*(npoint-1); % Maximum discrete value in a given dimension.
    
    % Values of the npoint discrete values in each dimension
    coord = 0:npoint-1;
    coord = coord/(npoint-1)*(maxi-mini)+mini;
    
    if npoint>4 % If points have been sampled before
        % Values which have already been used
        npoint_prec=npoint/3;
        delta_prec=1/npoint_prec;
        mini_prec=delta_prec/2;
        maxi_prec=mini_prec+delta_prec*(npoint_prec-1);
        coord_prec = 0:npoint_prec-1;
        coord_prec = coord_prec/(npoint_prec-1)*(maxi_prec-mini_prec)+mini_prec;
        
        puissance_verifiee = -round(log10(mini)-6); % Accuracy used to compare values.
        
        to_delete = round(coord_prec*10^puissance_verifiee); % Change of the order of magnitude of the values already used
        for i=1:length(to_delete) % For each value already used
            id_to_delete = find(round(coord*10^puissance_verifiee)==to_delete(i)); % Index of the value already used amongst the new values
            coord(id_to_delete) = []; % Removal of the value already used
        end
    end
    
    % Sampling the new points in a Latin hypercube : For each factor (for a given column), each of the new coordinates is one different value of coord
    for i=1:nfac
        points_extra(1:length(coord),i) = coord(randperm(length(coord))); % Additional points
    end
    
    points = [points; points_extra]; % The additional points are added to the former points
else
    delta=1/npoint; % Distance between two successive discrete values in a given dimension.
    mini=delta/2; % Minimum discrete value in a given dimension.
    maxi=mini+delta*(npoint-1); % Maximum discrete value in a given dimension.
end

%% CALCULATION OF THE ELEMENTARY EFFECTS

% Variation applied to the factors to calculate the elementary effects
if mod(n,2) == 1 % If the step number is odd
    variation = 0.5;
else % If the step number is even
    variation = 0.75*0.5; 
end

[lines_outputs, columns_outputs] = size(table_outputs); % lines_outputs is the maximum step number reached

if ~initialization % At the beginning, the elementary effects are calculated for all the factors
    table_outputs(n,1) = studied_function(points(n,:)); % Output of the function at the n-th sampled point.
    
    for i=1:nfac % For each factor
        if points(n,i) < 0.5 % If its coordinate if smaller than 0.5, a positive variation is applied
            table_outputs(n,1+i) = studied_function([points(n,1:i-1) points(n,i)+variation points(n,i+1:nfac)]);
        else % If its coordinate if larger than 0.5, a negative variation is applied
            table_outputs(n,1+i) = studied_function([points(n,1:i-1) points(n,i)-variation points(n,i+1:nfac)]);
        end
        table_ee(n,i) = abs(table_outputs(n,1+i)-table_outputs(n,1))/variation; % Elementary effect of the i-th factor at the n-th sampled point.
    end
    
    if n>=3 % From the third step, the ability to define a limit between the factors with a low and a high influence is estimated
        for i=1:3 % For three steps
            for j=1:nfac % For all the factors
                test_initialization(i,j) = max(table_ee(1:n-3+i,j)); % Maxima of the elementary effects obtained for each factor (column) at each of the last three steps (three lines)
            end
        end
        for i=1:3 % For each of the last three steps
            test_initialization_sort(i,1:nfac) = sort(test_initialization(i,:)); % Ordering the maxima of the elementary effects of each factor.
            test_initialization_sort_shift(i,1:nfac) = [test_initialization_sort(i,1) test_initialization_sort(i,1:nfac-1)]; % New table where the first elementary effect is repeted twice.
            test_initialization_delta(i,1:nfac) = test_initialization_sort(i,:)-test_initialization_sort_shift(i,:); % Variation between the successive maxima.
            test_initialization_delta_max(i) = max(test_initialization_delta(i,:)); % The largest variation at each step.
        end
        test_initialization_delta_max_sort = sort(test_initialization_delta_max,'descend'); % Ordering the largest variations at the three steps.
        if (test_initialization_delta_max_sort(3)>=0.5*test_initialization_delta_max_sort(1)) % If the smallest value is larger than half of the largest value, the variations are considered to be roughly stable.
           initialization = 1; % The calculations will then foccus on the factors under the limit defined with the largest variation between successice maxima.
        end
    end
    
elseif n<=lines_outputs % If the algorithm returned to a previous step
    
    for i=1:nfac % For each of the factors
        if (table_ee(n,i)==-1) & ~ismember(i,factors_over) % If the elementary effect has not been calculated before and if the factor is not over the limit         
            if points(n,i) < 0.5 % If its coordinate if smaller than 0.5, a positive variation is applied
                table_outputs(n,1+i) = studied_function([points(n,1:i-1) points(n,i)+variation points(n,i+1:nfac)]);
            else % If its coordinate if larger than 0.5, a negative variation is applied
                table_outputs(n,1+i) = studied_function([points(n,1:i-1) points(n,i)-variation points(n,i+1:nfac)]);
            end
            table_ee(n,i) = abs(table_outputs(n,1+i)-table_outputs(n,1))/variation; % Elementary effect of the i-th factor at the n-th sampled point.
        end
    end
    
else % If it is a new step where the calculations have to be foccused on the factors under the limit
    table_outputs(n,1) = studied_function(points(n,:)); % Output of the function at the n-th sampled point.
    for i=1:nfac % For each factor
        if ~ismember(i,factors_over) % If the factor is not over the limit   
            if points(n,i) < 0.5 % If the elementary effect has not been calculated before and if the factor is not over the limit
                table_outputs(n,1+i) = studied_function([points(n,1:i-1) points(n,i)+variation points(n,i+1:nfac)]);
            else % If its coordinate if larger than 0.5, a negative variation is applied
                table_outputs(n,1+i) = studied_function([points(n,1:i-1) points(n,i)-variation points(n,i+1:nfac)]);
            end
            table_ee(n,i) = abs(table_outputs(n,1+i)-table_outputs(n,1))/variation; % Elementary effect of the i-th factor at the n-th sampled point.
        else % If the factor is over the limit
            %table_ee(n,i) = -1; % Its elementary effect is not calculated
        end
    end
end

%% IDENTIFICATION OF THE FACTORS OVER THE LIMIT
if initialization % If the calculations will be foccused on the factors under the limit at the next step

    % Identification of the maxima of the elementary effects of each factor
    for i=1:nfac
        resultat(i) = max(table_ee(:,i));
    end
    
    [resultat_sort, ordre] = sort(resultat); % Ordering the maxima of the elementary effects of each factor.
    resultat_sort_shift = [resultat_sort(1) resultat_sort(1:nfac-1)]; % New table where the first elementary effect is repeted twice.
    delta = resultat_sort-resultat_sort_shift; % Variation between the successive maxima.
    gagnant = min(find(delta>=(max(delta)/10))); % Limit = First variation larger than or equal to the largest variation between two successive maxima
        
    % Is there any missing elementary effect for the factors under the
    % limit ? (= a factor under the limit was formerly over the limit)
    if ~isempty(factors_over) % If there were factors over the limit after the last step

        factors_problem = []; % Factors with missing elementary effects

        for i=1:length(factors_over) % For each of the factors which were over the limit after the last step
            indice_autre_facteur = find(ordre==factors_over(i)); % Index of the factor in the new ordered values.
            if indice_autre_facteur<gagnant % If the factor is before the limit
                factors_problem = [factors_problem factors_over(i)]; % The list of factors with missing elementary effects is added.
            end
        end

        if ~isempty(factors_problem) % If one of the factors which were over the limit is now under the limit
            
            verification_factors = 0; % Stopping variable.
            i = 1; % From the first step.
            while verification_factors==0 & i<=length(table_ee(:,1)) % While the stopping variable has not been enabled, and while there are still calculation steps to check.
                verification_factors = sum(table_ee(i,factors_problem)==-1); % If there is no elementary effect for one or more of the factors at the i-th step, verification_factors becomes different from zero
                if ~verification_factors % If the stopping variable is still not enabled, the next step is considered
                    i=i+1;
                end
            end

            if verification_factors % If the stopping variable has been enabled, it is necessary to return to the step with a missing elementary effect
                n=i;
            else % Or the algorithms continues normally
                n=n+1;
            end

        else % If none of the factors which were over the limit moved under the limit
            n=n+1;
        end

    else % If there were no factor over the limit after the last step
        n=n+1;
    end

    gagnants = gagnant:nfac; % Ordered indexes of the factors over the limit
    factors_over = ordre(gagnants); % Real indexes of the factors over the limit
else % If the elementary effects will still be calculated for all the factors at the next step
    n=n+1;
    factors_over=[];
end

%% OUTPUTS
factors_over2 = factors_over;
table_outputs2 = table_outputs;
table_ee2 = table_ee;
n2 = n;
points2=points;
initialization2=initialization;

end