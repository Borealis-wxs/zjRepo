file = dir('input//max_idw//flood//*.txt');
mkdir('result_output//max_gwrmp_bpk//flood');
filenum = length(file);
num_row=0;num_col=0;
%  23行，27列
cell_grid_res=zeros(21,29);
for idx = 1:  filenum
    tempFileName = file(idx).name;
    str_tmp = tempFileName;
    str_digital = str_tmp(isstrprop(str_tmp,'digit'));
    % val_date=str2num(str_digital);
    pthFileName  = sprintf('input//max_idw//flood//%s_idw.txt',str_digital);
    pthFileName_mswep  = sprintf('result_output//max_gwrmp_bpk//flood//%s_gwrmp.txt',str_digital);
    cell_annual_year_idw = func_importfile_txt_R21C29_blank(pthFileName, 7);
    num_row=size(cell_annual_year,1); % 行数
    num_col=size(cell_annual_year,2); % 列数
    for id_row=1:num_row %行循环
        for id_col=1:num_col %列循环
            tmp_1=cell2mat(cell_annual_year_idw(id_row,id_col));
            if abs(abs(tmp_1)- abs(-9999))<=0.0001
                tmp_2=-9999;
            else
                tmp_2=matrix_a(id_row,id_col)*tmp_1+matrix_b(id_row,id_col);
                if tmp_2<=0
                    tmp_2=0;
                end
            end
            cell_grid_res(id_row,id_col)=tmp_2;
        end
    end % end for id_row
    
    if id_row ==num_row && id_col==num_col
        dlmwrite(pthFileName_mswep,cell_grid_res, 'delimiter', '\t', 'precision', '%8.6f');
    end
end
%% 

