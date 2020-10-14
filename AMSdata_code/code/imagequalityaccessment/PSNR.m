function [ val_psnr ] = PSNR( image1 ,image2)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%�����ֵ�����

A=image1; 
A=double(A);

B=image2;
B=double(B);

[M,N]=size(A);
sum=0;

%calc  two image's Standard Deviation
% ��������ͼ��ı�׼��
for i=1:M
    for j=1:N
        sum=sum+(B(i,j)-A(i,j))^2;
    end
end
RSME=sqrt(sum/(M*N));

% ��ֵ�����
y=20*log(abs(max(max(A(:)))/RSME));
val_psnr = y;


end

