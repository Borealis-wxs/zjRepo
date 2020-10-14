function [ val_snr ] = SNR( image1,image2 )
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%�������
%==================================================
%��Ϊ�ں�ͼ��������ͼ��Ĳ����������������ͼ�������Ϣ
%�����Խ��˵���ں�ͼ���������Ƶ�Խ��
%==================================================

A=image1; 
A=double(A);

B=image2;
B=double(B);

sum1=0;
sum2=0;
[M,N]=size(A); 

for i=1:M
    for j=1:N
        sum1=sum1+(B(i,j))^2;
        sum2=sum2+(A(i,j)-B(i,j))^2;
    end
end
y=10*log(sum1/sum2);
val_snr= y;
end

