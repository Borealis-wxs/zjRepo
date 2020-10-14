clc;%
clear;
file = dir('D:\\workststion\\matlab\\data\\regions\\dbftotxt\\regions\\dbf\\expand_gwrmp_max\\max_regions\\txt\\*.txt');
mkdir('D:\\workststion\\matlab\\data\\regions\\dbftotxt\\regions\\dbf\\expand_gwrmp_max\\max_regions\\txt\\res');
filenum = length(file);
resultFileName = sprintf('D:\\workststion\\matlab\\data\\regions\\dbftotxt\\regions\\dbf\\expand_gwrmp_max\\max_regions\\txt\\res\\expand_max_regions.txt');
fid = fopen(resultFileName,'w');
fprintf(fid,'filename\tHNCD\tZONE_CODE\tCOUNT\tAREA\tpre\r\n');
for idx = 1:filenum
    tempFileName = file(idx).name;
    pthFileName  = sprintf('D:\\workststion\\matlab\\data\\regions\\dbftotxt\\regions\\dbf\\expand_gwrmp_max\\max_regions\\txt\\%s',tempFileName);
    [HNCD,ZONE_CODE,COUNT,AREA,pre] = textread(pthFileName,'%s%d%d%f%f','headerlines',1);

	for idy=1:length(ZONE_CODE)
		fprintf(fid,'%s\t%s\t%d\t%d\t%f\t%f\r\n',tempFileName,cell2mat(HNCD(idy)),ZONE_CODE(idy),COUNT(idy),AREA(idy),pre(idy));
	end
end
fclose(fid);

