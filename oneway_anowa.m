
clc;
clear;
close all;

%% =========================================================
%  ONE-WAY ANOVA FOR QABF VALUES
%  23 Fusion Techniques Across 5 Datasets (1, 8, 14, 17, D)
% ==========================================================

%% Step 1: Input QABF Data

QABF = [
0.908117  0.906530  0.893779  0.906554  0.119400;
0.727828  0.725938  0.716536  0.783709  0.545100;
0.958167  0.962820  0.985239  0.963931  0.666700;
0.907532  0.903439  0.892051  0.901938  0.677800;
0.715235  0.762917  0.817304  0.710372  0.729000;
0.828892  0.822880  0.848884  0.853434  0.069600;
0.907895  0.903649  0.897502  0.901534  0.683400;
0.857459  0.858527  0.892365  0.883973  0.280900;
0.906369  0.906369  0.892090  0.901449  0.052500;
0.969440  0.977580  0.989526  0.971759  0.224900;
0.973609  0.978772  0.990312  0.970042  0.122500;
0.719082  0.758874  0.873026  0.760097  0.565074;
0.195545  0.297821  0.348595  0.148017  0.446378;
0.586772  0.574646  0.632188  0.642497  0.535132;
0.367054  0.397936  0.240291  0.292038  0.390475;
0.963271  0.969832  0.987305  0.961494  0.896222;
0.943657  0.946007  0.979438  0.936778  0.894021;
0.916719  0.912616  0.903952  0.910977  0.897054;
0.657766  0.727930  0.677862  0.663295  0.640974;
0.871060  0.876498  0.841112  0.873699  0.792624;
0.851704  0.842880  0.839835  0.819464  0.870134;
0.858512  0.892393  0.881368  0.894765  0.889823;
0.962582  0.970185  0.984759  0.960935  0.863187
];

%% Step 2: Method Names

methods = { ...
    'FGF-XDoG2','CDIF-CBF2','CBF2','Structure-aware2',...
    'LEGFF2','MDHU2','IMA2','VSM-WLS2','GFDF2',...
    'Two-scale2','MST-SR2','NcFSRM2','Gost2',...
    'MFIFU2','MORFO2','PMEF2','EXP2','ASDM',...
    'Page','AFI','UMC','SWT','Proposed'};

%% Step 3: Significance Level

alpha = 0.05;

%% Step 4: Degrees of Freedom

[a,b] = size(QABF);

N = numel(QABF);

df_between = a - 1;
df_within  = N - a;
df_total   = N - 1;

fprintf('\n============================================\n');
fprintf('       ONE-WAY ANOVA: QABF RESULTS\n');
fprintf('============================================\n');

fprintf('\nNumber of techniques = %d\n',a);
fprintf('Number of datasets   = %d\n',b);
fprintf('Total observations   = %d\n',N);

fprintf('\nDEGREES OF FREEDOM\n');
fprintf('df_between = %d\n',df_between);
fprintf('df_within  = %d\n',df_within);
fprintf('df_total   = %d\n',df_total);

%% Step 5: ANOVA Calculations

group_means = mean(QABF,2);
overall_mean = mean(QABF(:));

SS_between = sum(b*(group_means - overall_mean).^2);

SS_within = sum(sum( ...
    (QABF - repmat(group_means,1,b)).^2));

SS_total = SS_between + SS_within;

MS_between = SS_between / df_between;
MS_within  = SS_within / df_within;

F_value = MS_between / MS_within;

p_val = 1 - fcdf(F_value,df_between,df_within);

%% Step 6: Display ANOVA Table

fprintf('\nANOVA TABLE\n');

fprintf('-------------------------------------------------------------\n');
fprintf('%-15s %-12s %-8s %-12s %-10s %-10s\n',...
    'Source','SS','df','MS','F','Prob>F');
fprintf('-------------------------------------------------------------\n');

fprintf('%-15s %-12.6f %-8d %-12.6f %-10.4f %-10.6f\n',...
    'Between',SS_between,df_between,MS_between,F_value,p_val);

fprintf('%-15s %-12.6f %-8d %-12.6f\n',...
    'Within',SS_within,df_within,MS_within);

fprintf('%-15s %-12.6f %-8d\n',...
    'Total',SS_total,df_total);

fprintf('-------------------------------------------------------------\n');

%% Step 7: Critical F Value

F_crit = finv(1-alpha,df_between,df_within);

fprintf('\nDECISION RULE\n');

fprintf('Significance level (alpha) = %.2f\n',alpha);
fprintf('Critical F value = %.6f\n',F_crit);
fprintf('Calculated F value = %.6f\n',F_value);

%% Step 8: Statistical Decision

fprintf('\nRESULT AND CONCLUSION\n');

if p_val < alpha
    fprintf('Reject the null hypothesis (H0).\n');
    fprintf('Significant differences exist among the techniques.\n');
else
    fprintf('Fail to reject the null hypothesis (H0).\n');
    fprintf('No statistically significant difference was detected.\n');
end

%% Step 9: Effect Size (Eta-Squared)

eta_sq = SS_between / SS_total;

fprintf('\nEFFECT SIZE\n');

fprintf('Eta-Squared (eta^2) = %.6f\n',eta_sq);
fprintf('Explained variance = %.2f%%\n',eta_sq*100);

%% Step 10: Mean QABF of Each Technique

fprintf('\nMEAN QABF VALUES\n');

for i = 1:a
    fprintf('%-20s : %.6f\n',methods{i},group_means(i));
end

fprintf('\n============================================\n');
fprintf('             ANALYSIS COMPLETED\n');
fprintf('============================================\n');
