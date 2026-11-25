% Methods and observed QAB/F scores
%methods = {'[16]', '[19]', '[18]', '[17]', '[22]', '[21]_1', '[21]_2', '[23]', '[20]', '[25]', '[26]', '[27]', '[24]', 'Proposed'};


%observed=[0.4666,0.4744,0.5135,0.5155,0.5047,0.669,0.3162,0.5212,0.3929,0.5759,0.7144,0.802774,0.572581,0.757194,0.820382]; //A
observed=[0.1404,0.3771,0.456,0.4747,0.2044,0.2217,0.5992,0.2252,0.1232,0.1464,0.5453,0.651406,0.280767,0.719747,0.572973];  %//B
%observed= [0.8436,0.46,0.5231,0.56,0.7857,0.7548,0.5992,0.7322,0.9426,0.7949,0.4833,0.695366,0.487769,0.666764,0.762166];     //C
%observed=[0.1194,0.5451,0.6667,0.6778,0.9229,0.0696,0.6834,0.2809,0.0525,0.2249,0.1225,0.565074,0.446378,0.535132,0.863187];   //D

%observed=[0.6525,0.4859,0.5113,0.5125,0.5365,0.782,0.1541,0.5117,0.888,0.544,0.652,0.699054,0.391134,0.769528,0.806017];




% Expected value
E = 1;

% Calculate O-E, (O-E)^2, and (O-E)^2/E
O_minus_E = observed - E;
squared = O_minus_E.^2;
chi_contrib = squared / E; % same as squared since E=1

% Create a table
T = table(observed', repmat(E,length(observed),1), O_minus_E', squared', chi_contrib', ...
    'VariableNames', {'Observed_O', 'Expected_E', 'O_minus_E', 'Squared', 'ChiSquare_Contribution'});

% Add total Chi-Square
total_chi = sum(chi_contrib);
disp(T);
fprintf('\nTotal Chi-Square Statistic: %.4f\n', total_chi);
