function [ val_rmse ] = RMSE( image1,image2 )
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%����������
%=================================================
%�ں�ͼ��������ͼ��ı�׼ƫ�RSMEԽС˵���ں�ͼ����
%����ͼ��Խ�ӽ���Ҳ����˵�ں�Ч��Խ��
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

