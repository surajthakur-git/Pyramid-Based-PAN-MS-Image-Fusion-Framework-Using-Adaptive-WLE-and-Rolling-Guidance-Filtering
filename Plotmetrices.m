% Clear environment
clear; close all; clc;

% Define fusion methods
methods = {'FGF-XDoG2','CDIF-CBF2','CBF2','Structure-aware2','LEGFF2',...
           'MDHU2','IMA2','VSM-WLS2','GFDF2','Two-scale2',...
           'MST-SR2','NcFSRM2','Gost2','MFIFU2','MORFO3',...
           'PMEF3','EXP3','ASDM1','Page1','AFI1','UMC1','SWT1','Proposed'};

% Metric values (Dataset E)
QABF = [0.6525, 0.4859, 0.5113, 0.5125, 0.5365, ...
        0.7820, 0.1541, 0.5117, 0.7880, 0.5440, ...
        0.6520, 0.699054, 0.391134, 0.769528, 0.590271, ...
        0.841135, 0.856096, 0.845410, 0.838577, 0.631582, ...
        0.822860, 0.846739, 0.806017];

LABF = [0.3475, 0.5043, 0.4786, 0.4775, 0.4635, ...
        0.2180, 0.8459, 0.4883, 0.2060, 0.4560, ...
        0.3480, 0.070273, 0.608864, 0.188091, 0.285439, ...
        0.148827, 0.096755, 0.129589, 0.117330, 0.368388, ...
        0.119760, 0.152650, 0.193000];

% X-axis
x = 1:length(methods);

% Plot
figure; hold on; grid on; box on;

% QABF
stem3(x, ones(size(x)), QABF, 'o', 'LineWidth', 1.5, ...
      'Color',[0 0.45 0.74], 'MarkerFaceColor',[0 0.45 0.74]);

% LABF
stem3(x, 2*ones(size(x)), LABF, 's', 'LineWidth', 1.5, ...
      'Color',[0.85 0.33 0.10], 'MarkerFaceColor',[0.85 0.33 0.10]);

% Axis settings
set(gca,'XTick',1:length(methods),...
        'XTickLabel',methods,...
        'XTickLabelRotation',45);

set(gca,'YTick',1:2,'YTickLabel',{'QABF','LABF'});

%xlabel('Fusion Methods');
ylabel('Metric Type');
zlabel('Metric Value');
title('Dataset E');

% View
view(45,30);
set(gca,'FontSize',12,'FontWeight','bold');
set(gcf,'Color','w');

% Legend
legend({'QABF','LABF'},'Location','northoutside','Orientation','horizontal');