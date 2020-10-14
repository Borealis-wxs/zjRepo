clc;%符号
clear;
% 统计
% 输出：
mkdir('result_output//year_gwrmp//');
mkdir('result_output//year_idw//');
mkdir('result_output//add_header//year_gwrmp//');
mkdir('result_output//add_header//year_idw//');
file1 = dir('input//year_gwrmp//*.txt');
file2 = dir('input//year_idw//*.txt');
ROUNUM=21; % 行数
COLNUM=29; % 列数
NO_VALUE=-9999;

filenum = length(file1);
for idx = 1: filenum
    tempFileName1 = file1(idx).name;
    tempFileName2 = file2(idx).name;
    pthFileName1  = sprintf('input//year_gwrmp//%s',tempFileName1);
    pthFileName2  = sprintf('input//year_idw//%s',tempFileName2);
    %month
%     cell_1 = func_importfile_txt_R21C29(pthFileName1, 7, 29);
%     cell_2 = func_importfile_txt_R21C29(pthFileName2, 7, 29);
    
    % year
        cell_1 = func_importfile_txt_R21C29_blank(pthFileName1, 7, 29);
        cell_2 = func_importfile_txt_R21C29_blank(pthFileName2, 7, 29);
    
    num_row=size(cell_1,1); % 行数
    num_col=size(cell_1,2); % 列数
    tmp_matrix1=cell2mat(cell_1);
    tmp_matrix2=cell2mat(cell_2);
    tmp_cell_grid1=ones(num_row,num_col)*NO_VALUE;
    tmp_cell_grid2=ones(num_row,num_col)*NO_VALUE;
    for idn=1:num_col
        for idm=1:num_row
            tmp_val=tmp_matrix1(idm,idn);
            if tmp_val ~= NO_VALUE
                tmp_cell_grid1(idm,idn)= ...
                    abs(tmp_matrix1(idm,idn)-tmp_matrix2(idm,idn))/tmp_matrix1(idm,idn);
                tmp_cell_grid2(idm,idn)= ...
                    abs(tmp_matrix1(idm,idn)-tmp_matrix2(idm,idn))/tmp_matrix2(idm,idn);
                
            end
        end
    end
    str_output1=sprintf('result_output//year_gwrmp//%s_rb_gwrmp.txt',tempFileName1(1:6));
    dlmwrite(str_output1,tmp_cell_grid1, 'delimiter', ' ', 'precision', '%8.6f');
    str_output2=sprintf('result_output//year_idw//%s_rb_idw.txt',tempFileName2(1:6));
    dlmwrite(str_output2,tmp_cell_grid2, 'delimiter', ' ', 'precision', '%8.6f');
    str_output1_dst=sprintf('result_output//add_header//year_gwrmp//%s_rb_gwrmp.txt',tempFileName1(1:6));
    str_output2_dst=sprintf('result_output//add_header//year_idw//%s_rb_idw.txt',tempFileName2(1:6));
    [tmp_res]=Func_AddHeaderFile_blank(str_output1,str_output1_dst);
    [tmp_res]=Func_AddHeaderFile_blank(str_output2,str_output2_dst);
    
    %     str_output1=sprintf('result_output//year_gwrmp//%s',tempFileName1);
    %     dlmwrite(str_output1,tmp_cell_grid1, 'delimiter', ' ', 'precision', '%8.6f');
    %     str_output2=sprintf('result_output//year_idw//%s',tempFileName2);
    %     dlmwrite(str_output2,tmp_cell_grid2, 'delimiter', ' ', 'precision', '%8.6f');
    %
    %     str_output1_dst=sprintf('result_output//add_header//year_gwrmp//%s',tempFileName1);
    %     str_output2_dst=sprintf('result_output//add_header//year_idw//%s',tempFileName2);
    %
    %     [tmp_res]=Func_AddHeaderFile_blank(str_output1,str_output1_dst);
    %     [tmp_res]=Func_AddHeaderFile_blank(str_output2,str_output2_dst);
end


