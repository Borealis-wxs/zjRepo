%dbfread('D:\workstation\matlab\20181205\\input');
%[DATA,NAMES] = dbfread('D:\workstation\matlab\20181205\input\th_TP_19560928.dbf')
%       sq_hq_py             regions1
clc;%·ûºÅ 
clear;
file = dir('D:\\workststion\\matlab\\data\\regions\\dbftotxt\\regions\\dbf\\expand_gwrmp_max\\max_regions\\*.dbf');
mkdir('D:\\workststion\\matlab\\data\\regions\\dbftotxt\\regions\\dbf\\expand_gwrmp_max\\max_regions\\txt');
filenum = length(file);
for idx = 1:filenum
    tempFileName = file(idx).name;
    pthFileName  = sprintf('D:\\workststion\\matlab\\data\\regions\\dbftotxt\\regions\\dbf\\expand_gwrmp_max\\max_regions\\%s',tempFileName);
    resultFileName = sprintf('D:\\workststion\\matlab\\data\\regions\\dbftotxt\\regions\\dbf\\expand_gwrmp_max\\max_regions\\txt\\%s.txt',tempFileName(1:length(tempFileName)-4) );
    [DATA,NAMES] = dbfread(pthFileName);
    HNCD=DATA(:,1);
    ZONE_CODE=DATA(:,2);
    COUNT=DATA(:,3);
    AREA=DATA(:,4);
    MEAN=DATA(:,5);
    res_date = table(HNCD,ZONE_CODE,COUNT,AREA,MEAN);
    writetable(res_date,resultFileName,'Delimiter','\t');
end

