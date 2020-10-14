clc;
clear;
% if exist('month_idw_output','dir')>=1
%     rmdir('month_idw_output','s')
% end
% mkdir('month_idw_output');
file = dir('max_60D_idw//txt_noheader//*.txt');
% 两个输入文件夹
FILENAME_1='txt_noheader';
num_row=21;
num_col=29;
headerFileName='headertxt';

filenum = length(file);
for idx = 1: filenum
    % 提取字符串中的数字
    tempFileName = file(idx).name;
    pthFileName1  = sprintf('max_60D_idw//%s//%s',FILENAME_1,tempFileName);
    cell_annual_year1 = func_importfile_txt_R21C29(pthFileName1, 1, 21);
    disp(pthFileName1);
    %start 定义一个cell_grid变量，存储预处理后的数据
    for id_row=1:num_row %行循环
        for id_col=1:num_col %列循环
            tmp_1=cell2mat(cell_annual_year1(id_row,id_col));
            if tmp_1 == -9999
                cell_grid_1(id_row,id_col)=-9999;
            else
                cell_grid_1(id_row,id_col)=cell2mat(cell_annual_year1(id_row,id_col));
            end
        end
    end % end for id_row
    %end 定义一个cell_grid变量---------------
    
    %% 将结果写入文件
    str_month_idw_output=sprintf('max_60D_idw//%s',tempFileName);
    % 先复制一个头文件模板
    pthFileName_SrcFile  = sprintf('max_60D_idw//%s.txt',headerFileName);
    pthFileName_DestFile  = str_month_idw_output;
    copyfile(pthFileName_SrcFile, str_month_idw_output);
    
    % 使用dlmwrite函数将计算结果写入到输出文件中
    % 注意，此处使用'-append'属性参数，实现在头文件后，添加矩阵内容
    dlmwrite(str_month_idw_output,cell_grid_1, 'delimiter', '\t', 'precision', '%8.6f','-append');
    
    
end