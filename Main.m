LP = im2double(rgb2gray(imread("me.png", "png")));
HP = im2double(rgb2gray(imread("zebra.jpg", "jpg")));

% y_axis, x_axis
LP = LP(100:599, 200:699);
HP = HP(75:574, 350:849);

imwrite(LP, "Report/Images/LP.png", "png")
imwrite(HP, "Report/Images/HP.png", "png")

% ---------------------------------------------------------

% 2: Compute frequency representations

fft_LP = fft2(LP);
fft_HP = fft2(HP);

imwrite(abs(fftshift(fft_LP))/125, "Report/Images/LP-freq.png", "png");
imwrite(abs(fftshift(fft_HP))/100, "Report/Images/HP-freq.png", "png");

% ---------------------------------------------------------

% 3: Visualize kernels

sobKer = fspecial('sobel');
gausKer = fspecial('gaussian', 17, 2.5);
dGaussKer = conv2(gausKer, sobKer);

% save kernel visualizations
title("Gaussian Kernel Visualization")
saveas(surf(gausKer), "gaus-surf.png", "png");
title("Derivative-of-Gaussian (DoG) Kernel Visualization")
saveas(surf(dGaussKer), "dog-surf.png", "png");

% save filtered images (gauss and dog)
gFilteredLP = imfilter(LP, gausKer);
imwrite(gFilteredLP, "Report/Images/LP-filt.png", "png");

gFilteredHP = imfilter(HP, gausKer);
imwrite(gFilteredHP, "Report/Images/HP-filt.png", "png");


% save freq. domain versions of gauss filtered images
fft_gFilteredLP = abs(fftshift(fft2(gFilteredLP)));
imwrite(fft_gFilteredLP, "Report/Images/LP-filt-freq.png", "png");

fft_gFilteredHP = abs(fftshift(fft2(gFilteredHP)));
imwrite(fft_gFilteredHP, "Report/Images/HP-filt-freq.png", "png");

% compute FFT of DoGs size 500x500
% apply filter to both images in freq domain
% convert back to spatial domain
FFT_dGaussKer = fft2(dGaussKer, 500, 500);


% apply that filter in frequency domain to both images
FFT_dFilteredLP_freq = imfilter(fft_LP, FFT_dGaussKer);
FFT_dFilteredLP_spat = abs(ifft2(FFT_dFilteredLP_freq));

imwrite(abs(fftshift(FFT_dFilteredLP_freq)/8000), "Report/Images/LP-dogfilt-freq.png", "png");
imwrite(FFT_dFilteredLP_spat*12.5, "Report/Images/LP-dogfilt.png", "png");

FFT_dFilteredHP_freq = imfilter(fft_HP, FFT_dGaussKer);
FFT_dFilteredHP_spat = abs(ifft2(FFT_dFilteredHP_freq));

imwrite(abs(fftshift(FFT_dFilteredHP_freq))/400, "Report/Images/HP-dogfilt-freq.png", "png");
imwrite(FFT_dFilteredHP_spat*12.5, "Report/Images/HP-dogfilt.png", "png");

% ---------------------------------------------------------

% 4: Anti-aliasing

L_SS2 = LP(1:2:end, 1:2:end);
H_SS2 = HP(1:2:end, 1:2:end);

imwrite(L_SS2, "Report/Images/LP-sub2.png")
imwrite(H_SS2, "Report/Images/HP-sub2.png")

FFT_L_SS2 = fft2(L_SS2);
FFT_H_SS2 = fft2(H_SS2);

imwrite(abs(fftshift(FFT_L_SS2))/100, "Report/Images/LP-sub2-freq.png")
imwrite(abs(fftshift(FFT_H_SS2))/100, "Report/Images/HP-sub2-freq.png")

L_SS4 = LP(1:4:end, 1:4:end);
H_SS4 = HP(1:4:end, 1:4:end);

imwrite(L_SS4, "Report/Images/LP-sub4.png")
imwrite(H_SS4, "Report/Images/HP-sub4.png")

FFT_L_SS4 = fft2(L_SS4);
FFT_H_SS4 = fft2(H_SS4);

imwrite(abs(fftshift(FFT_L_SS4))/75, "Report/Images/LP-sub4-freq.png")
imwrite(abs(fftshift(FFT_H_SS4))/75, "Report/Images/HP-sub4-freq.png")

% antialias HP using Gaussian filter
AA_H_SS2 = imgaussfilt(HP, 0.75, 'FilterSize', 17);
AA_H_SS4 = imgaussfilt(HP, 1.25, 'FilterSize', 17);

AA_H_SS2_samp = AA_H_SS2(1:2:end, 1:2:end);
AA_H_SS4_samp = AA_H_SS4(1:4:end, 1:4:end);

imwrite(AA_H_SS2_samp, "Report/Images/HP-sub2-aa.png", "png")
imwrite(AA_H_SS4_samp, "Report/Images/HP-sub4-aa.png", "png")

imwrite(abs(fftshift(fft2(AA_H_SS2)))/50, "Report/Images/HP-sub2-aa-freq.png", "png")
imwrite(abs(fftshift(fft2(AA_H_SS4)))/15, "Report/Images/HP-sub4-aa-freq.png", "png")

% ---------------------------------------------------------

% 5: Canny edge detection thresholding

[C_LP, LPThresh] = edge(LP, 'canny'); % 0.0250    0.0625
[C_HP, HPThresh] = edge(HP, 'canny'); % 0.0500    0.1250
% LPThresh
% HPThresh

% dflt: 0.0250, 0.0625
% best: 0.0800, 0.1150
% no nose and moustache diff even at 0.0851 upper
% 0.1150 is where the line in the right glass disappears
l = edge(LP, 'canny', [0.0800, 0.1200]);
imwrite(l, "Report/Images/LP-canny-optimal.png", "png");
L_ll = edge(LP, 'canny', [0.0600, 0.1200]);
L_hl = edge(LP, 'canny', [0.1000, 0.1200]);
L_lh = edge(LP, 'canny', [0.0800, 0.1000]);
L_hh = edge(LP, 'canny', [0.0800, 0.1400]);
imwrite(L_ll, "Report/Images/LP-canny-lowlow.png", "png");
imwrite(L_hl, "Report/Images/LP-canny-highlow.png", "png");
imwrite(L_lh, "Report/Images/LP-canny-lowhigh.png", "png");
imwrite(L_hh, "Report/Images/LP-canny-highhigh.png", "png");

% dflt: 0.0875, 0.2188
% best: 0.0400, 0.1200

h = edge(HP, 'canny', [0.0400, 0.1200]);
imwrite(h, "Report/Images/HP-canny-optimal.png", "png");
H_ll = edge(HP, 'canny', [0.0200, 0.1200]);
H_hl = edge(HP, 'canny', [0.0600, 0.1200]);
H_lh = edge(HP, 'canny', [0.0400, 0.1000]);
H_hh = edge(HP, 'canny', [0.0400, 0.1400]);
imwrite(H_ll, "Report/Images/HP-canny-lowlow.png", "png");
imwrite(H_hl, "Report/Images/HP-canny-highlow.png", "png");
imwrite(H_lh, "Report/Images/HP-canny-lowhigh.png", "png");
imwrite(H_hh, "Report/Images/HP-canny-highhigh.png", "png");

% Sources:
% zebra.jpg: https://dbknews.com/2021/09/09/five-zebras-loose-prince-georges-county-upper-marlboro/
