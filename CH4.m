%% Chapter4 Filtering in the Frequency Domain

%% fftshift&& Logarithmic transformation
clc
clear
f = imread('/images/dipum_images_ch04/Fig0403(a)(image).tif');
%imshow(f)
imshow(f,[])
title('the original image')
%%imfinfoMy(f)

F = fft2(f);

S = abs(F);
% S(1:5,1:5)
imshow(S,[])
title('Fourier spectrum image')
%%imfinfoMy(S)

Fc = fftshift(F);
S = abs(Fc);
% S(1:5,1:5)
%imshow(S)
imshow(S,[])
title('Centered Fourier spectrum image')
%%imfinfoMy(S)

S = abs(F);
% S(1:5,1:5)
S2 = log(1+S);
S3 = (S+1e-6)^0.2;
% imshow(S2)
imshow(S2,[])
title('Visually enhance the Fourier spectrum image by Logarithmic transformation')
%%imfinfoMy(S2)

Fc = fftshift(F);
S = abs(Fc);
% S(1:5,1:5)
S2 = log(1+S);
% imshow(S2)
imshow(S2,[])
title('Centered result of <visually enhance the Fourier spectrum image by Logarithmic transformation>')
%%imfinfoMy(S2)

%% fftshift&& Logarithmic transformation
clc
clear
f = imread('/images/dipum_images_ch04/flower_gray.jpg');
imshow(f)

f = double(f);

F = fft2(f);



Fc = fftshift(F);
S = abs(Fc);
% S(1:5,1:5)
S2 = log(1+S);
% imshow(S2)
imshow(S2,[])

%% ifft2 
clc
clear
f = imread('/images/dipum_images_ch04/flower_gray.jpg');
imshow(f)
%imfinfoMy(f)

f = double(f);  

f(1:8,1:8)
F = fft2(f);

f = real(ifft2(F));
f(1:8,1:8)
imshow(f,[])




%% Example 4.1 Filtering effects with and without padding:: lpfilter paddedsize
clc
clear

f = imread('/images/dipum_images_ch04/Fig0405(a)(square_original).tif');
f = im2double(f);
imshow(f,[])
%imfinfoMy(f)
title('Original image')

[M, N] = size(f);
F = fft2(f);  % max(F(:)) = 128000
imshow(F,[])
%imfinfoMy(F)
title('Fourier spectrum (complex) image')

sig = 10;
H = lpfilter('gaussian',M,N,sig); % max(H(:)) = 1
imshow(1-H,[]) % Display indicates that the filter image is not centered
title('Filter spectrum (inverse) image')

G = H.*F;
g = real(ifft2(G));
imshow(g,[])
title('Image after low pass filtering without padding')

PQ = paddedsize(size(f)); % size(f)=[256 256]
Fp = fft2(f, PQ(1),PQ(2));
Hp = lpfilter('gaussian',PQ(1),PQ(2),2*sig); % PQ=[512 512]
imshow(fftshift(Hp),[])
Gp = Hp.*Fp;
gp = real(ifft2(Gp));
imshow(gp,[])
title('Image after low pass filtering without padding')

gpc = gp(1:size(f,1),1:size(f,2));
imshow(gpc,[])
title('Image after low pass filtering and corpping(to the same size of the original image) without padding')
%imfinfoMy(gpc)

h = fspecial('gaussian',15,7);
gs = imfilter(f,h);
imshow(gs,[])
title('Image after spatial filtering')
%imfinfoMy(gs)

%% fspecial:Achieve the same function as the above procedure
clc
clear

f = imread('/images/dipum_images_ch04/Fig0405(a)(square_original).tif');

h = fspecial('gaussian',15,7); % 
imshow(h,[])

gs = imfilter(f,h);
imshow(gs,[])

%% dftfilt 
clc
clear
f = imread('/images/dipum_images_ch04/Fig0405(a)(square_original).tif');
f = im2double(f);
imshow(f,[])

PQ = paddedsize(size(f)); % size(f)=[256 256]
sig = 10;
H = lpfilter('gaussian',PQ(1),PQ(2),2*sig); % PQ=[512 512]

figure,mesh(abs(H(1:10:512,1:10:512)))

g = dftfilt(f,H);  %  % origin in the upper left corner
imshow(g,[])

% H1 = ifftshift(H);
% g1 = dftfilt(f,H1);  % 
% imshow(g1,[])

%% Example4.2 Comparison of spatial domain filtering and frequency domain filtering
clc
clear
f = imread('/images/dipum_images_ch04/Fig0409(a)(bld).tif');
%imfinfoMy(f)
imshow(f)
title('Original image')

F = fft2(f);
S = fftshift(log(1+abs(F)));
S = gscale(S);
imshow(S)
title('Fourier spectrum image')

f = im2double(f); % Type conversion
F = fft2(f);
S = fftshift(log(1+abs(F)));
S = gscale(S);
%imfinfoMy(S)
imshow(S)
title('Fourier spectrum image processed after using f = im2double(f)')
 
%% Example4.2 freqz2; Enhanced vertical edge ; sobel  H = freqz2(h,PQ(1),PQ(2)); % The resulting filter origin is at the center of the matrix
clc
clear
f = imread('/images/dipum_images_ch04/Fig0409(a)(bld).tif');
imshow(f)

F = fft2(f);
S = fftshift(log(1+abs(F)));
S = gscale(S);
imshow(S)

h = fspecial('sobel')'; % Enhanced vertical edge
%      1     0    -1
%      2     0    -2
%      1     0    -1
figure,freqz2(h); % uses [n2 n1] = [64 64].
% size_h = size(temp)

PQ = paddedsize(size(f));
H = freqz2(h,PQ(1),PQ(2)); % The resulting filter is centered
H1 = ifftshift(H); % Migrate the origin to the upper left corner
figure,mesh(abs(H1(1:20:1200,1:20:1200)))

imshow(abs(H),[])
imshow(abs(H1),[])

gs = imfilter(double(f),h);
gf = dftfilt(f,H1);

imshow(gs,[])
imshow(gf,[])

imshow(abs(gs),[])
imshow(abs(gf),[])

imshow(abs(gs) > 0.2*abs(max(gs(:))))
imshow(abs(gf) > 0.2*abs(max(gf(:))))


d = abs(gs-gf);
max(d(:))
min(d(:))

%% freqz2; Enhanced horizontal edge; sobel % fft2(f):The origin of F  is in the upper left corner
clc
clear
f = imread('/images/dipum_images_ch04/Fig0409(a)(bld).tif');
imshow(f)

F = fft2(f);
S = fftshift(log(1+abs(F)));
S = gscale(S);
imshow(S)

h = fspecial('sobel'); % Enhanced horizontal edge
figure,freqz2(h);
% size_h = size(temp)

PQ = paddedsize(size(f));
H = freqz2(h,PQ(1),PQ(2));
H1 = ifftshift(H);
figure,mesh(abs(H1(1:20:1200,1:20:1200)))

imshow(abs(H),[])
imshow(abs(H1),[])

gs = imfilter(double(f),h);
gf = dftfilt(f,H1);

% imshow(gs,[])
% imshow(gf,[])
% 
% imshow(abs(gs),[])
% imshow(abs(gf),[])
% 
% imshow(abs(gs) > 0.2*abs(max(gs(:))))
% imshow(abs(gf) > 0.2*abs(max(gf(:))))


d = abs(gs-gf);
max(d(:))
min(d(:))

%% freqz2:Enhanced vertical edge:prewitt
clc
clear
f = imread('/images/images_ch04/Fig0409(a)(bld).tif');
imshow(f)

F = fft2(f);
S = fftshift(log(1+abs(F)));
S = gscale(S);
imshow(S)

h = fspecial('prewitt')';
figure,freqz2(h);
% size_h = size(temp)

PQ = paddedsize(size(f));
H = freqz2(h,PQ(1),PQ(2));
H1 = ifftshift(H);
figure,mesh(abs(H1(1:20:1200,1:20:1200)))

imshow(abs(H),[])
imshow(abs(H1),[])

gs = imfilter(double(f),h);
gf = dftfilt(f,H1);

imshow(gs,[])
imshow(gf,[])

imshow(abs(gs),[])
imshow(abs(gf),[])

imshow(abs(gs) > 0.2*abs(max(gs(:))))
imshow(abs(gf) > 0.2*abs(max(gf(:))))


d = abs(gs-gf);
max(d(:))
min(d(:))

%% freqz2 ;Enhanced horizontal edge; prewitt
clc
clear
f = imread('/images/dipum_images_ch04/Fig0409(a)(bld).tif');
imshow(f)

F = fft2(f);
S = fftshift(log(1+abs(F)));
S = gscale(S);
imshow(S)

h = fspecial('prewitt');
figure,freqz2(h);
% size_h = size(temp)

PQ = paddedsize(size(f));
H = freqz2(h,PQ(1),PQ(2));
H1 = ifftshift(H);
figure,mesh(abs(H1(1:20:1200,1:20:1200)))

imshow(abs(H),[])
imshow(abs(H1),[])

gs = imfilter(double(f),h);
gf = dftfilt(f,H1);

% imshow(gs,[])
% imshow(gf,[])
% 
% imshow(abs(gs),[])
% imshow(abs(gf),[])
% 
% imshow(abs(gs) > 0.2*abs(max(gs(:))))
% imshow(abs(gf) > 0.2*abs(max(gf(:))))


d = abs(gs-gf);
max(d(:))
min(d(:))


%% Example4.3 dftuv: Build a grid array for implementing a frequency domain filter
clc
clear

[U,V] = dftuv(7,5);
% [U,V] = dftuv(8,5);

D = U.^2 + V.^2

fftshift(D)

%% Example 4.4 Low pass filter dftfilt dftuv
clc
clear
f = imread('/images/dipum_images_ch04/Fig0413(a)(original_test_pattern).tif');
imshow(f)
title('Original image')

F1 = fft2(f); % Notice the difference between F1 and F below
imshow(log(1+abs(fftshift(F1))),[])
title('Fourier spectrum image')

PQ = paddedsize(size(f));
[U V] = dftuv(PQ(1),PQ(2));
D0 = 0.05*PQ(2);

F = fft2(f,PQ(1),PQ(2));
imshow(log(1+abs(fftshift(F))),[])
title('Fourier spectrum image')

H = exp(-(U.^2+V.^2)/(2*(D0^2)));
imshow(fftshift(H),[])
title('Spectral image of gaussian low pass filter')

g = dftfilt(f,H);
imshow(g,[])
title('Image after Gaussian low pass processing')


%% Example4.5 Drawing a wireframe mesh LPFilter low-pass mesh
clc
clear
H = fftshift(lpfilter('gaussian',500,500,50));
mesh(H(1:10:500,1:10:500))
axis([0 50 0 50 0 1])

% colormap([0 0 0])
% axis off
% grid off

imshow(H,[])


%% Example4.6 High-pass filter HPfilter high-pass
clc
clear

H = fftshift(hpfilter('ideal',500,500,100)); % ??????100
% H = fftshift(hpfilter('gaussian',500,500,50));
% H = fftshift(hpfilter('btw',500,500,50));

mesh(H(1:10:500,1:10:500))
axis([0 50 0 50 0 1])

colormap([0 0 0])
axis off
grid off

imshow(H,[])

%% Example4.7 High-pass filter
clc
clear

f = imread('/images/dipum_images_ch04/Fig0413(a)(original_test_pattern).tif');
imshow(f)
title('Original image')

PQ = paddedsize(size(f));

D0 = 0.05*PQ(1); % The radius is D0
H = hpfilter('gaussian',PQ(1),PQ(2),D0);
g = dftfilt(f,H);
imshow(g,[])
title('Image after Gaussian high-pass filtering')



%% Example4.8 High frequency emphasis filtering and histogram equalization are combined; hpfilter histeq
clc
clear
f = imread('/images/dipum_images_ch04/Fig0419(a)(chestXray_original).tif');
imshow(f)
title('Original image')
%imfinfoMy(f)

PQ = paddedsize(size(f));
D0 = 0.05*PQ(1);
HBW = hpfilter('btw',PQ(1),PQ(2),D0,2);
H = 0.5+2*HBW;
gbw = dftfilt(f,HBW);
% after using gscale(gbw) , the imshow(gbw) is equal to imshow(gbw,[])
gbw = gscale(gbw); 
imshow(gbw,[])
title('Image after high pass filtering')
%imfinfoMy(gbw)

gbe = histeq(gbw,256);
imshow(gbe,[])
title('Image after high-pass filtering and histogram equalization')
%imfinfoMy(gbe)

ghf = dftfilt(f,H);
ghf = gscale(ghf);
imshow(ghf,[])
title('High frequency emphasizes the filtered image')
%imfinfoMy(ghf)

ghe = histeq(ghf,256);
imshow(ghe,[])
title('Image after high-frequency emphasis filtering and histogram equalization')
%imfinfoMy(ghe)

%% fftshift ifftshift 
clc
clear

A = [2 0 0 1
     0 0 0 0
     0 0 0 0
     3 0 0 4]

fftshift(A)

fftshift(fftshift(A))

ifftshift(fftshift(A))



%% Pay attention!!!
freqz2 The resulting filter origin is perfectly central
lpfilter%(Low pass) generates the filter origin in the upper left corner
hpfilter%(high pass) generates the filter origin in the upper left corner

%% 
clc
clear


% ??????????????????
%       -- ?????? 
%       
% ???????????????????????????????? 
% ?????????????????????????????? 
% ???????????????????????????????? 
% ???????????????????????? 
% 
% ???????????????????????????????????? 
% ?????????????????????????????? 
% ???????????????????????????????? 
% ???????????????????????? 

