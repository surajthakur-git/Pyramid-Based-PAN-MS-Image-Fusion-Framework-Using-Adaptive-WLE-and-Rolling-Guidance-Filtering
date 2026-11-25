
clear; close all; clc;

% ---------------------------------------------------------
% Methods (23 Techniques) - Original Names Preserved
% ---------------------------------------------------------
methods = { ...
    'FGF-XDoG2','CDIF-CBF2','CBF2','Structure-aware2','LEGFF2',...
    'MDHU2','IMA2','VSM-WLS2','GFDF2','Two-scale2',...
    'MST-SR2','NcFSRM2','Gost2','MFIFU2','MORFO3',...
    'PMEF3','EXP3','ASDM1','Page1','AFI1','UMC1','SWT1','Proposed'};

% ---------------------------------------------------------
% MEDIAN VALUES FOR DATASETS 1, 8, 14, 17 AND D
% ---------------------------------------------------------
A = [67 88 62 67 66 63 67 58 67 61 56 59 ...
     67 53 64 64 48 58 54 58 63 62 58];

B = [90 122 85 90 87 82 89 78 90 84 79 75 ...
     89 71 85 88 65 76 76 85 84 84 79];

C = [95 130 89 94 91 91 93 83 94 87 83 65 ...
     89 76 91 89 70 82 80 92 88 88 83];

D = [57 76 53 56 55 50 56 50 56 52 58 62 ...
     56 46 54 55 42 47 46 47 53 53 51];

E = [155 208 141 130 114 140 140 129 142 136 142 118 ...
     134 124 91 124 123 136 135 133 143 136 137];

% ---------------------------------------------------------
% PLOT MEDIAN VALUES FOR DATASETS 1, 8, 14, 17 AND D
% ---------------------------------------------------------
figure('Color','w','Position',[100 100 1400 650]);

hold on;
grid on;
box on;

x = 1:length(methods);

plot(x,A,'-o','LineWidth',1.8,'MarkerSize',6);
plot(x,B,'-s','LineWidth',1.8,'MarkerSize',6);
plot(x,C,'-d','LineWidth',1.8,'MarkerSize',6);
plot(x,D,'-^','LineWidth',1.8,'MarkerSize',6);
plot(x,E,'-v','LineWidth',1.8,'MarkerSize',6);

% ---------------------------------------------------------
% AXIS SETTINGS
% ---------------------------------------------------------
set(gca,'XTick',x,...
        'XTickLabel',methods,...
        'XTickLabelRotation',50,...
        'FontSize',10,...
        'FontWeight','bold');

xlim([0.5 23.5]);

xlabel('Fusion Techniques','FontSize',12,'FontWeight','bold');
ylabel('Median Intensity','FontSize',12,'FontWeight','bold');

%title('Median Intensity Comparison Across Datasets 1, 8, 14, 17 and D',...'FontSize',14,'FontWeight','bold');

legend({'Image pair 1','Image pair 2','Image pair 3',...
        'Image pair 4','Image pair 5'},...
        'Location','northoutside',...
        'Orientation','horizontal');

set(gca,'LineWidth',1.1);

hold off;

% ---------------------------------------------------------
% SAVE FIGURE
% ---------------------------------------------------------
exportgraphics(gcf,'Median_Comparison_image.png','Resolution',600);
