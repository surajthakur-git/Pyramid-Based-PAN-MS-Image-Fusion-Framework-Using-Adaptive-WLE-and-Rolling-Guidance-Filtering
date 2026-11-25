
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
% MODE VALUES FOR DATASETS 1, 8, 14, 17 AND D
% ---------------------------------------------------------
A = [61 83 57 61 58 61 61 52 61 56 52 50 ...
     61 45 59 63 45 52 48 52 57 61 53];

B = [26 40 23 25 27 22 25 23 20 24 26 13 ...
     20 25 20 26 25 32 13 15 23 24 23];

C = [92 255 82 255 85 92 89 79 255 80 81 68 ...
     86 73 89 85 70 82 76 89 86 86 78];

D = [55 70 54 54 50 54 54 49 54 51 57 54 ...
     54 40 53 55 38 45 41 46 51 51 49];

E = [255 255 141 147 255 255 145 125 255 132 188 255 ...
     131 255 91 115 255 255 255 131 255 150 144];

% ---------------------------------------------------------
% PLOT MODE VALUES FOR DATASETS 1, 8, 14, 17 AND D
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
ylim([0 270]);

xlabel('Fusion Techniques','FontSize',12,'FontWeight','bold');
ylabel('Value','FontSize',12,'FontWeight','bold');

%title('Mode Intensity Comparison Across Datasets 1, 8, 14, 17 and D',...'FontSize',14,'FontWeight','bold');

legend({'Image pair 1','Image pair 2','Image pair 3',...
        'Image pair 4','Image pair 5'},...
        'Location','northoutside',...
        'Orientation','horizontal');

set(gca,'LineWidth',1.1);

hold off;

% ---------------------------------------------------------
% SAVE FIGURE
% ---------------------------------------------------------
exportgraphics(gcf,'Mode_Comparison_image.png','Resolution',600);
