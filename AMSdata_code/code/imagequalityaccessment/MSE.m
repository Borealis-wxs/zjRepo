function [ val_mse ] = MSE( image1,image2 )
%UNTITLED8 �˴���ʾ�йش˺�����ժҪ
%��������
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
y=sum/(M*N);
val_mse=y;
end

