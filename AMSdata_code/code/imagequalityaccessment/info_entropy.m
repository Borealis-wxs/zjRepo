function [ en ] = info_entropy( image,division )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   ����ͼ�����Ϣ��
%A=img1; 
A=image;
[M,N]=size(A);
temp=zeros(1,256);

%��ͼ��ĻҶ�ֵ��[0,255]����ͳ��
for m=1:M;
    for n=1:N;
        if A(m,n)==-9999 || A(m,n)==0 ;
            i=0;
        else
            i=ceil( A(m,n)/division )+1;
            temp(i)=temp(i)+1;
        end
        % temp(i)=temp(i)+1;
    end
end
temp=temp./(M*N);

%���صĶ���������
en=0;

for i=1:length(temp)
    if temp(i)==0;
        en=en;
    else
        en=en-temp(i)*log2(temp(i));
    end
end

end

