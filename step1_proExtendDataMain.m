clc;%符号
clear;
if exist('result_output','dir')>=1
    rmdir('result_output','s')
end
mkdir('result_output//max_gwrmp//flood//');
file = dir('input//max_idw//flood//*.txt');
%%
filenum = length(file);
num_row=0;num_col=0;
%  23行，27列
cell_grid_1=zeros(filenum,21,29);
cell_grid_2=zeros(filenum,21,29);
for idx = 1:  filenum
    tempFileName = file(idx).name;
    str_tmp = tempFileName;
    str_digital = str_tmp(isstrprop(str_tmp,'digit'));
    % val_date=str2num(str_digital);
    pthFileName  = sprintf('input//max_idw//flood//%s_idw.txt',str_digital);
    pthFileName_mswep  = sprintf('input//max_gwrmp//flood//%s_gwrmp.txt',str_digital);
    cell_annual_year = func_importfile_txt_R21C29_blank(pthFileName, 7);
    cell_annual_year_mswep = func_importfile_txt_R21C29_blank(pthFileName_mswep, 7);
    num_row=size(cell_annual_year,1); % 行数
    num_col=size(cell_annual_year,2); % 列数
    %定义一个cell_grid变量，存储预处理后的数据
    
    for id_row=1:num_row %行循环
        for id_col=1:num_col %列循环
            tmp_1=cell2mat(cell_annual_year(id_row,id_col));
            tmp_2=cell2mat(cell_annual_year_mswep(id_row,id_col));
            
            cell_grid_1(idx,id_row,id_col)=tmp_1;
            cell_grid_2(idx,id_row,id_col)=tmp_2;
        end
    end % end for id_row
end

%% 用polyfit 做线性拟合，就系数a和b，分别存储在matrix_a，matrix_b
merge_matrix_idw=[];
merge_matrix_mswep=[];
matrix_a=zeros(num_row,num_col)+(-9999);
matrix_b=zeros(num_row,num_col)+(-9999);
r_sqrt=zeros(num_row,num_col)+(-9999);
for id2_row=1:num_row %行循环
    for id2_col=1:num_col %列循环
        if cell_grid_1(1,id2_row,id2_col) == -9999 %跳过-9999等空间坐标点
            matrix_a(id2_row,id2_col)=-9999;
            matrix_b(id2_row,id2_col)=-9999;
        else
            input_matrix_1=cell_grid_1(:,id2_row,id2_col);
            input_matrix_2=cell_grid_2(:,id2_row,id2_col);
            p = polyfit(input_matrix_1',input_matrix_2',1);
            matrix_a(id2_row,id2_col)=p(1);
            matrix_b(id2_row,id2_col)=p(2);
            
            % 求R^2
            x=input_matrix_1;
            y=input_matrix_2;
            y_poly=x*p(1)+p(2);
            y_mean=mean(y);
            r_tmp1=0;r_tmp2=0;
            for jj=1:size(y,1)
                r_tmp1=r_tmp1+(y(jj)-y_poly(jj))^2;
                r_tmp2=r_tmp2+(y(jj)-y_mean)^2;
            end
            r_sqrt(id2_row,id2_col)=1-r_tmp1/r_tmp2;
        end
        
    end
end

%%
pthFileName_nihe=sprintf('result_output//max_gwrmp//flood//nihe_check.txt');
if id_row ==num_row && id_col==num_col
    dlmwrite(pthFileName_nihe,r_sqrt, 'delimiter', '\t', 'precision', '%8.6f');
end










