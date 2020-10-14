function [ output_args ] = Func_AddHeaderFile_noblank( pthFileName_src,pthFileName_dst )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
num_row=21;
num_col=29;
headerFileName='headertxt.txt';

cell_annual_year1 = func_importfile_txt_R21C29(pthFileName_src, 1, 21);
disp(pthFileName_src);
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
% 先复制一个头文件模板
pthFileName_SrcFile  = headerFileName;
pthFileName_DestFile  = pthFileName_dst;
copyfile(pthFileName_SrcFile, pthFileName_DestFile);

% 使用dlmwrite函数将计算结果写入到输出文件中
% 注意，此处使用'-append'属性参数，实现在头文件后，添加矩阵内容
dlmwrite(pthFileName_DestFile,cell_grid_1, 'delimiter', '\t', 'precision', '%8.6f','-append');
output_args='sucess';

end

