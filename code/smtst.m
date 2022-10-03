clear all;close all;clc;                 
X=imread('dog.jpg'); 
X=im2double(X);
figure();
subplot(211);
imshow(X);
title('原始图像/灰度图像'); 
X=rgb2gray(X);%转化成灰度图
subplot(212);     
imshow(X);   
[cA1, cH1, cV1, cD1] = dwt2(X, 'haar');
figure;
subplot(221), imshow(cA1, []);
subplot(222), imshow(cH1, []);
subplot(223), imshow(cV1, []);
subplot(224), imshow(cD1, []);
% 生成含噪图像并图示
% X=double(X);
% 添加随机噪声
XX=imnoise(X,'gaussian',0,(30/255)^2); %添加均值为0，标准差为sigma=20高斯噪声
figure();         
imshow(XX);              
title(' 含噪图像 ');       
%用小波函数coif2对图像XX进行2层分解
[c,s]=wavedec2(XX,2,'haar'); 
% 设置尺度向量
n=[1,2];  
% n=1;
% 设置阈值向量 , 对高频小波系数进行阈值处理
p=[30,60]; 
% p=0.1;
nc=wthcoef2('h',c,s,n,p,'s');
% 图像的二维小波重构
X1=waverec2(nc,s,'haar');   
figure;           
imshow(X1);                
%colormap(map);            
title(' haar小波消噪后的图像 '); 
%再次对高频小波系数进行阈值处理
% mc=wthcoef2('v',nc,l,n,p,'s');
% % 图像的二维小波重构
% X2=waverec2(mc,l,'coif2');  
% figure;
% imshow(uint8(X2));               
% title(' 第二次消噪后的图像 ');   
dev1=(XX-X);
Err1=mse(dev1);%计算均方逼近误差
dev2=(X1-X);
Err2=mse(dev2);%计算均方逼近误差
% dev3=(X2-X);
% Err3=mse(dev3);%计算均方逼近误差1