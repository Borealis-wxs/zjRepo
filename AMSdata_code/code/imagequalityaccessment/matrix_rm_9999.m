function [ AA ] = matrix_rm_9999( img1 )
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
A=img1; 
[M,N]=size(A);
k=1;
for i=1:M
    for j=1:N
        if A(i,j)~=-9999
            AA(k)=A(i,j);
            k=k+1;
        end
    end
end

end

