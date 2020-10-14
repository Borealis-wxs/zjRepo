function [ val_joint_entropy ] = joint_entropy( image1,image2, division)
%UNTITLED10 此处显示有关此函数的摘要
%计算联合熵 

division=15;

A=image1;
A=double(A);

B=image2;
B=double(B);

[M,N]=size(A);
temp=zeros(256,256);

%对图像的灰度值成对地做统计
for m=1:M;
    for n=1:N;
        
        if A(m,n)==-9999 ||A(m,n)==0
            i=1;
        else
            i=ceil( A(m,n)/division )+1;
        end
        
        if A(m,n)==-9999 ||B(m,n)==0
            j=1;
        else
            j=ceil(B(m,n)/division )+1;
        end
        
        temp(i,j)=temp(i,j)+1;
    end
end
temp=temp./(M*N);

%由熵的定义做计算
result=0;

for i=1:size(temp,1)
    for j=1:size(temp,2)
        if temp(i,j)==0
            result=result;
        else
            result=result-temp(i,j)*log2(temp(i,j));
        end
    end
end
val_joint_entropy=result;

end

