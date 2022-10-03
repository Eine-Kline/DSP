clear all;close all;clc;                 
X=imread('dog.jpg'); 
X=im2double(X);
figure;
subplot(121);
imshow(X);    
xlabel('原图像');
X=rgb2gray(X);%转化成灰度图
subplot(122);     
imshow(X); 
xlabel('灰度图像');
% 生成含噪图像并图示
% X=double(X);
% 添加随机噪声
XX=imnoise(X,'gaussian',0,0.01); %添加均值为0，标准差为sigma高斯噪声
figure();         
imshow(XX);              
title('含噪图像 ');       
%用小波函数coif2对图像XX进行2层分解
[c,s]=wavedec2(XX,2,'haar'); 
% 设置尺度向量
n=[1,2];  
% n=1;
% 设置阈值向量 , 对高频小波系数进行阈值处理
p=[0.48955,0.48955]; 
% p=0.1;
nc=wthcoef2('h',c,s,n,p,'s');
% 图像的二维小波重构
X1=waverec2(nc,s,'haar');   
figure;           
imshow(X1);                
%colormap(map);            
title(' haar小波第一次消噪后的图像 '); 
%再次对高频小波系数进行阈值处理
mc=wthcoef2('v',nc,s,n,p,'s');
% 图像的二维小波重构
X2=waverec2(mc,s,'haar');     
dev1=abs(XX-X);
MSE1=mse(dev1);%计算均方逼近误差
PSNR1=10*log10(255^2/MSE1); 
dev2=abs(X1-X);
MSE2=mse(dev2);%计算均方逼近误差
PSNR2=10*log10(255^2/MSE2); 
dev3=abs(X2-X);
MSE3=mse(dev3);%计算均方逼近误差
PSNR3=10*log10(255^2/MSE3); 
simval1 = ssim(X,XX);
simval2 = ssim(X,X2);
figure;subplot(121);         
imshow(XX);              
title('含噪图像 '); 
% xlabel({'MSE:';MSE1});
xlabel({'SSIM:';simval1});
subplot(122);imshow(X2);                  
title(' 消噪后的图像 ');
% xlabel({'MSE:';MSE3});
xlabel({'SSIM:';simval2});
simval3 = ssim(X,X1);