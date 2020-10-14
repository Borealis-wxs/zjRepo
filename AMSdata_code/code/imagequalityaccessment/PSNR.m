function [ val_psnr ] = PSNR( image1 ,image2)
%UNTITLED3 此处显示有关此函数的摘要
%计算峰值信噪比

A=image1; 
A=double(A);

B=image2;
B=double(B);

[M,N]=size(A);
sum=0;

%calc  two image's Standard Deviation
% 计算两张图像的标准差
for i=1:M
    for j=1:N
        sum=sum+(B(i,j)-A(i,j))^2;
    end
end
RSME=sqrt(sum/(M*N));

% 峰值信噪比
y=20*log(abs(max(max(A(:)))/RSME));
val_psnr = y;


end

