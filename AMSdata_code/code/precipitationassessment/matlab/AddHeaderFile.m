clc;
clear;
% if exist('month_idw_output','dir')>=1
%     rmdir('month_idw_output','s')
% end
% mkdir('month_idw_output');
file = dir('max_60D_idw//txt_noheader//*.txt');
% ���������ļ���
FILENAME_1='txt_noheader';
num_row=21;
num_col=29;
headerFileName='headertxt';

filenum = length(file);
for idx = 1: filenum
    % ��ȡ�ַ����е�����
    tempFileName = file(idx).name;
    pthFileName1  = sprintf('max_60D_idw//%s//%s',FILENAME_1,tempFileName);
    cell_annual_year1 = func_importfile_txt_R21C29(pthFileName1, 1, 21);
    disp(pthFileName1);
    %start ����һ��cell_grid�������洢Ԥ����������
    for id_row=1:num_row %��ѭ��
        for id_col=1:num_col %��ѭ��
            tmp_1=cell2mat(cell_annual_year1(id_row,id_col));
            if tmp_1 == -9999
                cell_grid_1(id_row,id_col)=-9999;
            else
                cell_grid_1(id_row,id_col)=cell2mat(cell_annual_year1(id_row,id_col));
            end
        end
    end % end for id_row
    %end ����һ��cell_grid����---------------
    
    %% �����д���ļ�
    str_month_idw_output=sprintf('max_60D_idw//%s',tempFileName);
    % �ȸ���һ��ͷ�ļ�ģ��
    pthFileName_SrcFile  = sprintf('max_60D_idw//%s.txt',headerFileName);
    pthFileName_DestFile  = str_month_idw_output;
    copyfile(pthFileName_SrcFile, str_month_idw_output);
    
    % ʹ��dlmwrite������������д�뵽����ļ���
    % ע�⣬�˴�ʹ��'-append'���Բ�����ʵ����ͷ�ļ�����Ӿ�������
    dlmwrite(str_month_idw_output,cell_grid_1, 'delimiter', '\t', 'precision', '%8.6f','-append');
    
    
end