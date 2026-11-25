clc; clear; close all;
tic;
PAN = im2double(imread("F:\paper_3\paper_3_lap_rol\code4\New folder\dataset\pic1\pan1.jpg"));
MS  = im2double(imread("F:\paper_3\paper_3_lap_rol\code4\New folder\dataset\pic1\MS.jpg"));

%PAN = im2double(imread("F:\paper_3\paper_3_lap_rol\code4\new_dataset\pan8.jpg"));
%MS  = im2double(imread("F:\paper_3\paper_3_lap_rol\code4\new_dataset\ms8.jpg"));

% Resize if needed
if size(PAN,1) ~= size(MS,1) || size(PAN,2) ~= size(MS,2)
    MS = imresize(MS, [size(PAN,1), size(PAN,2)]);
end
level = 3;
sigma_s = 4;
sigma_r = 0.01;
iteration = 4;
GaussianPrecision = 0.01;

outDir = 'F:\paper_3\paper_3_lap_rol\code4\output_6';

%% ---- PYRAMID DECOMPOSITION ----
pyrPAN = pyramiddec(PAN, level);
pyrMS  = pyramiddec(MS,  level);

figure; imshow(mat2gray(pyrPAN{1}));
%imwrite(mat2gray(pyrPAN{1}), fullfile(outDir,'pyrPAN_detail1.png'));

figure; imshow(mat2gray(pyrPAN{2}));
%imwrite(mat2gray(pyrPAN{2}), fullfile(outDir,'pyrPAN_detail2.png'));

figure; imshow(pyrPAN{3});
%imwrite(pyrPAN{3}, fullfile(outDir,'pyrPAN_base.png'));

figure; imshow(mat2gray(pyrMS{1}));
%imwrite(mat2gray(pyrMS{1}), fullfile(outDir,'pyrMS_detail1.png'));

figure; imshow(mat2gray(pyrMS{2}));
%imwrite(mat2gray(pyrMS{2}), fullfile(outDir,'pyrMS_detail2.png'));

figure; imshow(pyrMS{3});
%imwrite(pyrMS{3}, fullfile(outDir,'pyrMS_base.png'));

%% weight - WLE metrix
E1 = WLE(double(im2gray(pyrPAN{1})));
E2 = WLE(double(im2gray(pyrMS{1})));

W1D1 = E1 ./ (E1 + E2 + eps);
W2D1 = E2 ./ (E1 + E2 + eps);

E3 = WLE(double(im2gray(pyrPAN{2})));
E4 = WLE(double(im2gray(pyrMS{2})));

W1D2 = E3 ./ (E3 + E4 + eps);
W2D2 = E4 ./ (E3 + E4 + eps);

figure; imshow(mat2gray(W1D1));
%imwrite(mat2gray(W1D1), fullfile(outDir,'W1D1.png'));

figure; imshow(mat2gray(W1D2));
%imwrite(mat2gray(W1D2), fullfile(outDir,'W1D2.png'));

figure; imshow(mat2gray(W2D1));
%imwrite(mat2gray(W2D1), fullfile(outDir,'W2D1.png'));

figure; imshow(mat2gray(W2D2));
%imwrite(mat2gray(W2D2), fullfile(outDir,'W2D2.png'));

%% base enhancement - Rolling guidance Filter
Enh_basePAN = RollingGuidanceFilter((pyrPAN{3}), sigma_s, sigma_r, iteration, GaussianPrecision);
Enh_baseMS  = RollingGuidanceFilter((pyrMS{3}),  sigma_s, sigma_r, iteration, GaussianPrecision);

figure; imshow(Enh_basePAN);
%imwrite(Enh_basePAN, fullfile(outDir,'Enh_basePAN.png'));

figure; imshow(Enh_baseMS);
%imwrite(Enh_baseMS, fullfile(outDir,'Enh_baseMS.png'));

%% Detail fusion - weighted average
fused_detail1 = (pyrPAN{1} .* W1D1 + pyrMS{1} .* W2D1);
fused_detail2 = (pyrPAN{2} .* W1D2 + pyrMS{2} .* W2D2);

figure; imshow(fused_detail1);
%imwrite(fused_detail1, fullfile(outDir,'fused_detail1.png'));

figure; imshow(fused_detail2);
%imwrite(fused_detail2, fullfile(outDir,'fused_detail2.png'));

%% Base fusion - simple averaging
fused_base = (Enh_basePAN + Enh_baseMS) / 2;

figure; imshow(fused_base);
%imwrite(fused_base, fullfile(outDir,'fused_enh.png'));

%% Reconstruction
fused_pyr = {fused_detail1, fused_detail2, fused_base};
Fused_img = pyramidrec(fused_pyr);
toc;

figure; imshow(Fused_img);
%imwrite(Fused_img, fullfile(outDir,'new20F.png'));

matrices_new_suraj(rgb2gray(Fused_img), im2gray(PAN), im2gray(MS));



% Check weight normalization
S1 = W1D1 + W2D1;
S2 = W1D2 + W2D2;

fprintf('D1 - Maximum deviation from 1: %.12e\n', ...
    max(abs(S1(:) - 1)));

fprintf('D2 - Maximum deviation from 1: %.12e\n', ...
    max(abs(S2(:) - 1)));

fprintf('D1 - Mean weight sum: %.12f\n', mean(S1(:)));
fprintf('D2 - Mean weight sum: %.12f\n', mean(S2(:)));
