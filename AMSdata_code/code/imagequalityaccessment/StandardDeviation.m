function [ SD ] = StandardDeviation( img1 )
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明
A=img1; 
A=double(A);
A=matrix_rm_9999(A);
Average=mean2(A(:));
[M,N]=size(A);
sum=0;

for i=1:M
    for j=1:N
        sum=sum+(A(i,j)-Average)^2;
    end
end

SD=sqrt(sum/(M*N));

end

