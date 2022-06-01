%% imfilter 线性空间滤波（空间卷积）
f = imread('/images/dipum_images_ch03/Fig0315(a)(original_test_pattern).tif');
f = im2double(f);
imshow(f)

w = ones(31);

gd = imfilter(f, w);
figure;
imshow(gd,[])
%imshow(gd)

gr = imfilter(f, w, 'replicate');
figure;
imshow(gr,[])

gc = imfilter(f, w, 'circular');
figure;
imshow(gc,[])
f8 = im2uint8(f);
gr8 = imfilter(f8, w, 'replicate');
figure;
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

%filter2
%medfilt2




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

%A = imread('/images/dipum_images_ch03/Fig0318(a)(ckt-board-orig).tif');
A=rand(10)*100;
B = ordfilt2(A,25,true(5));
figure, imshow(A,[]), figure, imshow(B,[])
%% gradient
douA=im2double(A);
[dx dy] = gradient(douA);
graA=sqrt(dx.^2+dy.^2);
figure;imshow(graA,[])
clc
clear

