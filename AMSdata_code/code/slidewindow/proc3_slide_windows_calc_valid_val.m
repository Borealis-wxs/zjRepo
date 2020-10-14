clc;%����
clear;
% ͳ��
% �����station-վ�����	LON-����	LAT-γ��
% Slide_windows_cnt-���ڻ������ڵĴ��ڱ��루�ڼ������ڣ�
%
mkdir('result_output3//year_bias//');
file = dir('input3//year_bias//*.txt');
% Ĭ�ϳ�ʼ��_0 �Ļ������ڣ�Ĭ����դ������Ͻǡ�����ע�⣺�ڴ��ڻ��������У�γ���ǽ��͵ģ����������ӵġ�
% ������3*3��С���������ң����ϵ��»�����

ROUNUM=21; % ����
COLNUM=29; % ����
NO_VALUE=-9999;


tmp_row_matrix=ones(2,COLNUM)*(-9999);% ��ʼ��һ��2*29���о���
tmp_col_matrix=ones(ROUNUM+2+2,2)*(-9999);% ��ʼ��һ��25*2���о���

filenum = length(file);
for idx = 1: filenum
    tempFileName = file(idx).name;
    pthFileName  = sprintf('input3//year_bias//%s',tempFileName);
    cell_mswep = func_importfile_txt_R21C29(pthFileName, 7, 29);
    num_row=size(cell_mswep,1); % ����
    num_col=size(cell_mswep,2); % ����
    tmp_matrix=cell2mat(cell_mswep);
    tmp_matrix=[tmp_row_matrix;tmp_matrix]; % �ھ������������
    tmp_matrix=[tmp_matrix;tmp_row_matrix]; % �ھ������������
    tmp_matrix=[tmp_col_matrix,tmp_matrix]; % �ھ�����߼�����
    tmp_matrix=[tmp_matrix,tmp_col_matrix]; % �ھ����ұ߼����У������γ�һ��(ROUNUM+2+2)*(COLNUM+2+2)�ľ���
    
    cnt_slide_windows=0;
    left_lon_val_0=119.050298; % ������߾���
    right_lon_val_0=119.350298;% �����ұ߾���
    top_lat_val_0=32.419212;% �����ϱ�γ��
    bottom_lat_val_0=32.119212;% �����±�γ��
    cellsize=0.1; % ����
    str_output_1=sprintf('result_output3//year_bias//%s',tempFileName);
    fid = fopen(str_output_1,'w');
    fprintf(fid,'%s\t%s\t%s\t%s\t%s\r\n','fileName','Slide_windows_Cnt','valid_val_Cnt','valid_val_Sum','valid_val_Avg')
    for idy=1:(ROUNUM+2+2)*(COLNUM+2+2) % ������С�������в���Ҫ��������Ϊ���ǲ����-9999��Чֵ
        cnt_slide_windows=cnt_slide_windows+1;
        cnt_slide_windows_valid_val=0;
        sum_valid_val=0;
        tmp_row=double(idivide(int32(idy),int32(COLNUM+2+2),'ceil'));
        tmp_col=mod(idy,COLNUM+2+2);
        if tmp_col==0
            tmp_col=COLNUM+2+2;
        end
        left_lon_val=left_lon_val_0 + (tmp_col-1)*cellsize;
        right_lon_val=right_lon_val_0 + (tmp_col-1)*cellsize;
        top_lat_val=top_lat_val_0 - (tmp_row-1)*cellsize;
        bottom_lat_val=bottom_lat_val_0 - (tmp_row-1)*cellsize;
        
        if tmp_col<=COLNUM+2 && tmp_row <=ROUNUM+2
            val_1=tmp_matrix(tmp_row,tmp_col);
            val_2=tmp_matrix(tmp_row,tmp_col+1);
            val_3=tmp_matrix(tmp_row,tmp_col+2);
            val_4=tmp_matrix(tmp_row+1,tmp_col);
            val_5=tmp_matrix(tmp_row+1,tmp_col+1);
            val_6=tmp_matrix(tmp_row+1,tmp_col+2);
            val_7=tmp_matrix(tmp_row+2,tmp_col);
            val_8=tmp_matrix(tmp_row+2,tmp_col+1);
            val_9=tmp_matrix(tmp_row+2,tmp_col+2);
            
            if val_1 ~= NO_VALUE
                sum_valid_val=sum_valid_val+val_1;
                cnt_slide_windows_valid_val=cnt_slide_windows_valid_val+1;
            end
            if val_2 ~= NO_VALUE
                sum_valid_val=sum_valid_val+val_2;
                cnt_slide_windows_valid_val=cnt_slide_windows_valid_val+1;
            end
            if val_3 ~= NO_VALUE
                sum_valid_val=sum_valid_val+val_3;
                cnt_slide_windows_valid_val=cnt_slide_windows_valid_val+1;
            end
            if val_4 ~= NO_VALUE
                sum_valid_val=sum_valid_val+val_4;
                cnt_slide_windows_valid_val=cnt_slide_windows_valid_val+1;
            end
            if val_5 ~= NO_VALUE
                sum_valid_val=sum_valid_val+val_5;
                cnt_slide_windows_valid_val=cnt_slide_windows_valid_val+1;
            end
            if val_6 ~= NO_VALUE
                sum_valid_val=sum_valid_val+val_6;
                cnt_slide_windows_valid_val=cnt_slide_windows_valid_val+1;
            end
            if val_7 ~= NO_VALUE
                sum_valid_val=sum_valid_val+val_7;
                cnt_slide_windows_valid_val=cnt_slide_windows_valid_val+1;
            end
            if val_8 ~= NO_VALUE
                sum_valid_val=sum_valid_val+val_8;
                cnt_slide_windows_valid_val=cnt_slide_windows_valid_val+1;
            end
            if val_9 ~= NO_VALUE
                sum_valid_val=sum_valid_val+val_9;
                cnt_slide_windows_valid_val=cnt_slide_windows_valid_val+1;
            end
            
            if cnt_slide_windows_valid_val>0
                % ���������ĵ��ڻ���������
                fprintf(fid,'%s\t%d\t%d\t%f\t%f\t%f\r\n', ...
                    tempFileName,cnt_slide_windows,cnt_slide_windows_valid_val, ...
                    sum_valid_val,sum_valid_val/cnt_slide_windows_valid_val)
                fprintf(fid,'\r\n');
            end
            
        end
        
        
        
    end
    fclose(fid);
    
end


