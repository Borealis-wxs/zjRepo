function [ val_sf ] = SpaceFrequency( image1 )
%UNTITLED9 �˴���ʾ�йش˺�����ժҪ

%����ռ�Ƶ��
%=============================================
%�ռ�Ƶ�ʷ�ӳ��һ��ͼ��ռ���������Ծ��
%=============================================
A=image1; 
A=double(A);

[M,N]=size(A);
sum1=0;
sum2=0;

%������Ƶ��
for i=1:M
    for j=2:N
        w=A(i,j)-A(i,j-1);
        sum1=sum1+w^2;
    end
end
RF=sqrt(sum1/(M*N));

%������Ƶ��
for j=1:N
    for i=2:M
        w=A(i,j)-A(i-1,j);
        sum2=sum2+w^2;
    end
end
CF=sqrt(sum2/(M*N));

SF=sqrt(RF^2+CF^2);
val_sf=SF;
end

