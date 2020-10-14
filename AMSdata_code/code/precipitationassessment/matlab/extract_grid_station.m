clc;%符号
clear;
if exist('output','dir')>=1
    rmdir('output','s')
end
file_name='xitiaoxi//mswep//txt//';
file = dir('xitiaoxi//mswep//txt//*.txt'); % 程序中两个替换地方
str3=sprintf('output');
mkdir(str3);
%%
filenum = length(file);
ROUNUM=4; % 行数
COLNUM=6; % 列数
lon=119.23143740201;
lat=30.376398487548;
cellsize=0.1; % 步长
NODATA_value=-9999;

for idx = 1: filenum
    tempFileName = file(idx).name;
    disp(tempFileName);
    str_digital = tempFileName(isstrprop(tempFileName,'digit'));
    pthFileName  = sprintf('%s//%s',file_name,tempFileName);
    cell_grid_val = func_importfile_txt_R4C6_blank(pthFileName, 7, 10);
    num_row=size(cell_grid_val,1); % 行数
    num_col=size(cell_grid_val,2); % 列数
    icnt=0;
    for idn=1:num_col
        for idm=1:num_row
            tmp_val=cell2mat(cell_grid_val(idm,idn)) ;
            if isa(tmp_val,'double')~=1
                tmp_val=str2double(tmp_val);
            end
            if tmp_val ~= NODATA_value
                icnt = icnt + 1;
                cell_grid_index(icnt,1)=idm;
                cell_grid_index(icnt,2)=idn;
                
                tmp_lon = lon+(idn-1)*cellsize;
                cell_grid_index(icnt,3)=tmp_lon;
                
                tmp_lat = lat+(ROUNUM-idm)*cellsize;
                cell_grid_index(icnt,4)=tmp_lat;
                
                cell_grid_index(icnt,5)=tmp_val;
                
                str_output_r=sprintf('output//%d_%d.txt',idm,idn);
                fid = fopen(str_output_r,'a');
                fprintf(fid,'%s\t%f\t%f\t%f\r\n',str_digital, tmp_lon,tmp_lat,tmp_val);
                fclose(fid);
    
            end
        end
    end
    
end
