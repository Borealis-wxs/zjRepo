function [ val_rmse ] = RMSE( image1,image2 )
%UNTITLED5 此处显示有关此函数的摘要
%求均方根误差
%=================================================
%融合图像与理想图像的标准偏差，RSME越小说明融合图像与
%理想图像越接近，也就是说融合效果越好
%=================================================
A=image1; 
A=double(A);

B=image2;
B=double(B);

[M,N]=size(A);
sum=0;

for i=1:M
    for j=1:N
        sum=sum+(B(i,j)-A(i,j))^2;
    end
end
y=sqrt(sum/(M*N));
val_rmse=y;
end

