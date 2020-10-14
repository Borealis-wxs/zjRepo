function [ val_ag ] = AverageGradent( image1 )
%UNTITLED9 此处显示有关此函数的摘要
%计算平均梯度
A=image1; 
A=double(A);

[M,N,K]=size(A);
sum=0;

for i=1:M-1
    for j=1:N-1
        diffX(i,j)=A(i,j)-A(i+1,j);
        diffY(i,j)=A(i,j)-A(i,j+1);
        w=sqrt(((diffX(i,j))^2+(diffY(i,j))^2)/2);
        sum=sum+w;
    end
end
AVEGRAD=sum/((M-1)*(N-1));
val_ag=AVEGRAD;
end

