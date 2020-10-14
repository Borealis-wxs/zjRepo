clc;%符号
clear;
% 统计 
% 输出：station-站点编码	LON-经度	LAT-纬度	
% Slide_windows_cnt-落在滑动窗口的窗口编码（第几个窗口）
mkdir('result_output1');
file = dir('input1//input1_th_yuliang_station.txt');
% 默认初始化_0 的滑动窗口，默认在栅格的左上角。尤其注意：在窗口滑动过程中，纬度是降低的，经度是增加的。
% % 窗口是3*3大小，从左向右，从上到下滑动。
% left_lon_val_0=119.050298; % 窗口左边经度
left_lon_val_0=118.850298
% right_lon_val_0=119.350298;% 窗口右边经度
right_lon_val_0=119.150298;% 窗口右边经度
top_lat_val_0=32.419212;% 窗口上边纬度 30.119212
bottom_lat_val_0=32.119212;% 窗口下边纬度
cellsize=0.1; % 步长
ROUNUM=21; % 行数
COLNUM=29; % 列数
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
                    % 满足条件的点在滑动窗口内
                    fprintf(fid,'%d\t%f\t%f\t%d\r\n',station_id(idz),lon(idz),lat(idz),cnt_slide_windows)
                end
            end
        end
        
    end
    fclose(fid);
    
end