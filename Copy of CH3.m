%% chapter3 Intensity transformations and spatial filters

%% Use the function imadjust to: highlight the brightness bands we are interested in. Compress the 
%% lower gray levels and expand the higher gray levels
clc
clear

f=imread('/images/dipum_images_ch03/Fig0303(a)(breast).tif');
figure;
imshow(f)
g1 = imadjust(f,[0;1],[1;0]); % === imcomplement(f)  Gray scale inversion
figure;
imshow(g1)

g2 = imadjust(f,[0.5;0.75],[0;1]); % Highlight the intensity levels of brightness we are interested in
figure;
imshow(g2)

g3 = imadjust(f,[],[],2); %  Compress the lower gray levels and expand the higher gray levels



% 例3.2 使用对数变换   减小动态范围 经典的阈值函数
clc
clear

f = imread('/images/dipum_images_ch03/Fig0305(a)(spectrum).tif');

% 使用对数变换  ？？？动态范围

subplot(121),imshow(f),subplot(122),imhist(f),axis tight


g = im2uint8(mat2gray(log(1 + double(f))));
figure,subplot(121),imshow(g),subplot(122),imhist(g),axis tight
title('Use logarithmic transformation to reduce the dynamic range')
axis([0 255 0 4000])

% 对比度拉伸变换
m = 5;
E = 10;
h = im2uint8(mat2gray(1./(1 + (m./(double(f) + eps)).^E)));
figure,subplot(121),imshow(h),subplot(122),imhist(h),axis tight

%% nargchk 检测传递的参数数目是否正确
clc
clear

% Given the function foo, 
% 
% function f = foo(x, y, z)
% error(nargchk(2, 3, nargin))
% 
% Then typing foo(1) produces 
% 
% Not enough input arguments.

%% 例3.3 P51 intrans ·灰度变换的十项全能函数
clc
clear

f = imread('/images/dipum_images_ch03/Fig0306(a)(bone-scan-GE).tif');
figure;
imshow(f)

g = intrans(f,'stretch',mean2(im2double(f)),0.9);
figure;
imshow(g)

%% changeclass im2double
clc
clear



%mean2



%% gscale 把图像标度在全尺度
clc
clear


f = [125.3 69.8
    5.3 2.3];
g = uint8(f);

hf = gscale(f);
h1 = gscale(g);
h2 = gscale(g,'minmax',0.1,0.6);
class(h2);

%% 例3.5 直方图均衡化 默认为64
clc
clear
f = imread('/images/dipum_images_ch03/Fig0308(a)(pollen).tif');
subplot(121),imshow(f),subplot(122),imhist(f)
ylim('auto')

g = histeq(f,256);
figure,subplot(121),imshow(g),subplot(122),imhist(g)
ylim('auto')


g = histeq(f,128);
figure,subplot(121),imshow(g),subplot(122),imhist(g)
ylim('auto')


g = histeq(f);  % 默认为64
figure,subplot(121),imshow(g),subplot(122),imhist(g)
ylim('auto')

g = histeq(f,8);
figure,subplot(121),imshow(g),subplot(122),imhist(g)
ylim('auto')

%% 例3.6 Defects in histogram equalization 默认为64
clc
clear
f = imread('/images/dipum_images_ch03/Fig0310(a)(Moon Phobos).tif');
subplot(121),imshow(f),subplot(122),imhist(f)
ylim('auto')

[g T] = histeq(f,256);
figure,subplot(121),imshow(g),subplot(122),imhist(g)
ylim('auto')

% g = histeq(f);  % 默认为64
% figure,subplot(121),imshow(g),subplot(122),imhist(g)
% ylim('auto')
% 
% g = histeq(f,8);
% figure,subplot(121),imshow(g),subplot(122),imhist(g)
% ylim('auto')

% the transform
x = linspace(0,1,256);
figure,plot(x,T)
axis([0 1 0 1])

%% 例3.6 histogram matching（交互方式）
clc
clear

f = imread('/images/dipum_images_ch03/Fig0310(a)(Moon Phobos).tif');
p = manualhist;
plot(p)
figure,subplot(121),imshow(f),subplot(122),imhist(f),ylim('auto')
g = histeq(f,p);
figure,subplot(121),imshow(g),subplot(122),imhist(g),ylim('auto')



%% imfilter 线性空间滤波（空间卷积）
clc
clear
f = imread('/images/dipum_images_ch03/Fig0315(a)(original_test_pattern).tif');
f = im2double(f);
imshow(f)

w = ones(31);

gd = imfilter(f, w);
figure;
imshow(gd,[])
imshow(gd)

gr = imfilter(f, w, 'replicate');
imshow(gr,[])

gc = imfilter(f, w, 'circular');

f8 = im2uint8(f);
gr8 = imfilter(f8, w, 'replicate');
imshow(gr8,[])

%% colfilt gmean P71 实现非线性空间滤波
clc
clear
f = [1 2
     3 4];
frb = padarray(f,[3 2],'replicate','both'); % 默认both
g = colfilt(frb,[3 2],'sliding',@gmean);
size_g = size(g);





%% padarray
clc
clear

f = [1 2
     3 4];
frp = padarray(f,[3 2],'replicate','post')
frb = padarray(f,[3 2],'replicate','both') % 默认both
frpre = padarray(f,[3 2],'replicate','pre')


fsp = padarray(f,[3 2],'symmetric','post')
fsb = padarray(f,[5 6],'symmetric','both') % 默认both
fspre = padarray(f,[3 2],'symmetric','pre')

fcp = padarray(f,[3 2],'circular','post')
fcb = padarray(f,[5 6],'circular','both') % 默认both
fcpre = padarray(f,[3 2],'circular','pre')

%% gmean
clc
clear







%% fspecial  P75 产生各种线性空间滤波器 （ fspecial + imfilter ）
clc
clear
f = imread('/images/dipum_images_ch03/Fig0316(a)(moon).tif');
imshow(f)

w = fspecial('laplacian',0);
g1 = imfilter(f,w,'replicate');
imshow(g1,[])

f2 = im2double(f);
%imfinfoMy(f2)
g2 = imfilter(f2,w,'replicate');
imshow(g2,[])

g = f2-g2;
imshow(g,[])

imshow(g)

%% laplacian
clc
clear

f = imread('/images/dipum_images_ch03/Fig0316(a)(moon).tif');
imshow(f)

w4 = fspecial('laplacian',0);
w8 = [1 1 1; 1 -8 1; 1 1 1];

f = im2double(f);
g4 = f - imfilter(f,w4,'replicate');
g8 = f - imfilter(f,w8,'replicate');

imshow(imfilter(f,w4,'replicate'))
imshow(imfilter(f,w8,'replicate'))
% 
imshow(imfilter(f,w4,'replicate'),[])
imshow(imfilter(f,w8,'replicate'),[])

imshow(g4)
imshow(g8)

imshow(g4,[])
imshow(g8,[])

%% 例3.11 使用函数 medfilt2 进行中值滤波
clc
clear

f = imread('/images/dipum_images_ch03/Fig0318(a)(ckt-board-orig).tif');
imshow(f)

fn = imnoise(f, 'salt & pepper',0.2);
imshow(fn)

gm = medfilt2(fn);
imshow(gm)

gms = medfilt2(fn, 'symmetric');
imshow(gms)


%% ordfilt2 median medfilt2
clc
clear

median(1:10)

median(1:11)

median(-2:-1:-10)

median(11:-1:1)

median(-20:-10)

%%
clc
clear





