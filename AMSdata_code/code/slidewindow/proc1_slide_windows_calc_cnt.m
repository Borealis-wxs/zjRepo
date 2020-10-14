clc;%����
clear;
% ͳ�� 
% �����station-վ�����	LON-����	LAT-γ��	
% Slide_windows_cnt-���ڻ������ڵĴ��ڱ��루�ڼ������ڣ�
mkdir('result_output1');
file = dir('input1//input1_th_yuliang_station.txt');
% Ĭ�ϳ�ʼ��_0 �Ļ������ڣ�Ĭ����դ������Ͻǡ�����ע�⣺�ڴ��ڻ��������У�γ���ǽ��͵ģ����������ӵġ�
% % ������3*3��С���������ң����ϵ��»�����
% left_lon_val_0=119.050298; % ������߾���
left_lon_val_0=118.850298
% right_lon_val_0=119.350298;% �����ұ߾���
right_lon_val_0=119.150298;% �����ұ߾���
top_lat_val_0=32.419212;% �����ϱ�γ�� 30.119212
bottom_lat_val_0=32.119212;% �����±�γ��
cellsize=0.1; % ����
ROUNUM=21; % ����
COLNUM=29; % ����
NO_VALUE=-9999;

cnt_slide_windows=0;

filenum = length(file);
for idx = 1: filenum
    tempFileName = file(idx).name;
    pthFileName  = sprintf('input1//%s',tempFileName);
    [station_id,lon,lat]=textread(pthFileName,'%d%f%f','headerlines',1);
    str_output_1=sprintf('result_output1//res_matrix.txt');
    fid = fopen(str_output_1,'w');
    fprintf(fid,'%s\t%s\t%s\t%s\r\n','station','LON','LAT','Slide_windows_cnt')
    for idy=1:(ROUNUM+2+2)*(COLNUM+2+2)
        cnt_slide_windows=cnt_slide_windows+1;
        
        tmp_row=double(idivide(int32(idy),int32(COLNUM+2+2),'ceil'));
        tmp_col=mod(idy,COLNUM+2+2);
        if tmp_col==0
            tmp_col=COLNUM+2+2;
        end
      
        left_lon_val=left_lon_val_0 + (tmp_col-1)*cellsize;
        right_lon_val=right_lon_val_0 + (tmp_col-1)*cellsize;
        top_lat_val=top_lat_val_0 - (tmp_row-1)*cellsize;
        bottom_lat_val=bottom_lat_val_0 - (tmp_row-1)*cellsize;
        
        for idz=1:length(station_id) 
            if lon(idz)<=right_lon_val && lon(idz) >=left_lon_val 
                if lat(idz)<=top_lat_val && lat(idz)>=bottom_lat_val
                    % ���������ĵ��ڻ���������
                    fprintf(fid,'%d\t%f\t%f\t%d\r\n',station_id(idz),lon(idz),lat(idz),cnt_slide_windows)
                end
            end
        end
        
    end
    fclose(fid);
    
end