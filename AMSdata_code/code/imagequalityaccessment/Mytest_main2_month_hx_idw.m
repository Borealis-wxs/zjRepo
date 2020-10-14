%Advanced Usage:
%   User defined parameters. For example
%
%   K = [0.05 0.05];
%   window = ones(8);
%   L = 100;
%   [mssim, ssim_map] = ssim(img1, img2, K, window, L);
clc;%����
clear;
if exist('result_output_idw_month_hx','dir')>=1
    rmdir('result_output_idw_month_hx','s')
end
mkdir('result_output_idw_month_th');
str_output=sprintf('result_output_idw_month_th//result_idw_month_hx.txt');
file1 = dir('input//th_idw_month//regions//hx//*.txt');
file2 = dir('input//th_idw_month//regions//hx//*.txt');
filenum = length(file1);
for idx = 1: filenum
    tempFileName = file1(idx).name;
    disp(tempFileName);
%     str_digital = tempFileName(isstrprop(tempFileName,'digit'));
    tempFileName1=tempFileName;
    tempFileName2 = file2(idx).name;
%     tempFileName2=sprintf('th_%s_idw.txt',str_digital);;
    pthFileName1  = sprintf('input//th_idw_month//regions//hx//%s',tempFileName);
    pthFileName2  = sprintf('input//th_idw_month//regions//hx//%s',tempFileName2);
    cell_1 = func_importfile_txt_R11C11_blank(pthFileName1, 7, 17);
    cell_2 = func_importfile_txt_R11C11_blank(pthFileName2, 7, 17);
    img1 = (cell_1);
    img2 = (cell_2);
    
    K = [0.05 0.05];
    window = ones(8);
    L = 100;
    %  [mssim, ssim_map] = ssim(img1, img2, K, window, L);
   [ssim, ssim_map] = ssim_twofiles_20200719(img1, img2 );
%     division=15; %����������ˮ���ݶ��������division��Ȼ��ת��Ϊ��0,255��֮���ͼ���������� yearpre
%     division=1; %����������ˮ���ݶ��������division��Ȼ��ת��Ϊ��0,255��֮���ͼ����������   daypre
    division=5; %����������ˮ���ݶ��������division��Ȼ��ת��Ϊ��0,255��֮���ͼ����������   monthpre
    [val_entropy]=info_entropy(img1,division);
    [ SD ] = StandardDeviation( img1 );
    [ val_sf ] = SpaceFrequency( img1 );
    [ val_ag ] = AverageGradent( img1 );
    [ val_psnr ] = PSNR( img1 ,img2);
    [ val_snr ] = SNR( img1 ,img2);
    [ val_rmse ] = RMSE( img1 ,img2 );
    [ val_mse ] = MSE( img1 ,img2 );
    [ val_joint_entropy ] = joint_entropy( img1,img2, division);
    
%     disp(['info_entropy=',num2str(val_entropy)]);
%     disp(['StandardDeviation=',num2str(SD)]);
%     disp(['SpaceFrequency=',num2str(val_sf)]);
%     disp(['AverageGradent=',num2str(val_ag)]);
%     disp(['PSNR(img1,img2)=',num2str(val_psnr)]);
%     disp(['SNR(img1,img2)=',num2str(val_snr)]);
%     disp(['RMSE(img1,img2)=',num2str(val_rmse)]);
%     disp(['MSE(img1,img2)=',num2str(val_mse)]);
%     disp(['joint_entropy(img1,img2)=',num2str(val_joint_entropy)]);
    
    fid = fopen(str_output,'a');
    fprintf(fid,'[%s : %s] [info_entropy]\t\t= %s\r\n',tempFileName1, tempFileName2,num2str(val_entropy));
    fprintf(fid,'[%s : %s] [StandardDeviation]\t\t= %s\r\n',tempFileName1, tempFileName2,num2str(SD));
    fprintf(fid,'[%s : %s] [SpaceFrequency]\t\t= %s\r\n',tempFileName1, tempFileName2,num2str(val_sf));
    fprintf(fid,'[%s : %s] [AverageGradent]\t\t= %s\r\n',tempFileName1, tempFileName2,num2str(val_ag));
    fprintf(fid,'[%s : %s] [PSNR(img1,img2)]\t\t= %s\r\n',tempFileName1, tempFileName2,num2str(val_psnr));
    fprintf(fid,'[%s : %s] [SNR(img1,img2)]\t\t= %s\r\n',tempFileName1, tempFileName2,num2str(val_snr));
    fprintf(fid,'[%s : %s] [RMSE(img1,img2)]\t\t= %s\r\n',tempFileName1, tempFileName2,num2str(val_rmse));
    fprintf(fid,'[%s : %s] [MSE(img1,img2)]\t\t= %s\r\n',tempFileName1, tempFileName2,num2str(val_mse));
    fprintf(fid,'[%s : %s] [joint_entropy(img1,img2)]\t\t= %s\r\n',tempFileName1, tempFileName2,num2str(val_joint_entropy));
    fprintf(fid,'[%s : %s] [ssim(img1,img2)]\t\t= %s\r\n',tempFileName1, tempFileName2,num2str(ssim));
    fclose(fid);
    % [val_entropy]=info_entropy(img2,division);
    % [ SD ] = StandardDeviation( img2 );
    % disp(['info_entropy=',num2str(val_entropy)]);
    % disp(['StandardDeviation=',num2str(SD)]);
end
