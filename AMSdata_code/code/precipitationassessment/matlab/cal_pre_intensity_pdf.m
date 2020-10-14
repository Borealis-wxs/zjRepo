% 导入excel数据，矩阵格式，结果为data3pre,可复制黏贴导出

matrix=gwrmpxiu2;
Num_col=length(matrix(1,:));
Num_row=length(matrix(:,1));
VAL_1=0;
VAL_2=0.1;
VAL_3=10;
VAL_4=25;
VAL_5=50;
VAL_6=100;
VAL_7=9999; % 表示无穷大
tep_matrix_1=zeros(Num_row-4,floor(Num_col/2));
tep_matrix_2=tep_matrix_1;
tep_matrix_3=tep_matrix_1;
tep_matrix_4=tep_matrix_1;
tep_matrix_5=tep_matrix_1;
tep_matrix_6=tep_matrix_1;

result_matrix=zeros(floor(Num_col/2),7+7);

for j=2:2: Num_col
    station_id=matrix(1,j);
    for i=5: Num_row
        a=matrix(i,j);b=matrix(i,j+1);
        if a>=VAL_1 && b>=VAL_1 && a<VAL_2 && b<VAL_2
            tep_matrix_1(i-4,j/2)=tep_matrix_1(i-4,j/2)+1;
        elseif a>=VAL_2 && b>=VAL_2 && a<VAL_3 && b<VAL_3
            tep_matrix_2(i-4,j/2)=tep_matrix_2(i-4,j/2)+1;
        elseif a>=VAL_3 && b>=VAL_3 && a<VAL_4 && b<VAL_4
            tep_matrix_3(i-4,j/2)=tep_matrix_3(i-4,j/2)+1;
        elseif a>=VAL_4 && b>=VAL_4 && a<VAL_5 && b<VAL_5
            tep_matrix_4(i-4,j/2)=tep_matrix_4(i-4,j/2)+1;
        elseif a>=VAL_5 && b>=VAL_5 && a<VAL_6 && b<VAL_6
            tep_matrix_5(i-4,j/2)=tep_matrix_5(i-4,j/2)+1;
        elseif a>=VAL_6 && b>=VAL_6 && a<VAL_7 && b<VAL_7
            tep_matrix_6(i-4,j/2)=tep_matrix_6(i-4,j/2)+1;    
        end
        
        
    end
    result_matrix(j/2,1)=station_id; % staion_id
    tmp_length_no_NAN=length(matrix(:,j))-4-numel(find(isnan(matrix(5:end,j))));
    result_matrix(j/2,2)= sum(tep_matrix_1(:,j/2))/tmp_length_no_NAN; %[0,0.1)
    result_matrix(j/2,3)= sum(tep_matrix_2(:,j/2))/tmp_length_no_NAN; %[0.1,10) 
    result_matrix(j/2,4)= sum(tep_matrix_3(:,j/2))/tmp_length_no_NAN; %[10,25)
    result_matrix(j/2,5)= sum(tep_matrix_4(:,j/2))/tmp_length_no_NAN; %[25,50)
    result_matrix(j/2,6)= sum(tep_matrix_5(:,j/2))/tmp_length_no_NAN; %[50,100)
    result_matrix(j/2,7)= sum(tep_matrix_6(:,j/2))/tmp_length_no_NAN; %[100,9999)
    result_matrix(j/2,8)=sum(tep_matrix_1(:,j/2)); %[0,0.1) 的个数
    result_matrix(j/2,9)=sum(tep_matrix_2(:,j/2)); %[0.1,10) 的个数
    result_matrix(j/2,10)=sum(tep_matrix_3(:,j/2)); %[10,25) 的个数
    result_matrix(j/2,11)=sum(tep_matrix_4(:,j/2)); %[25,50) 的个数
    result_matrix(j/2,12)=sum(tep_matrix_5(:,j/2)); %[50,100) 的个数
    result_matrix(j/2,13)=sum(tep_matrix_6(:,j/2)); %[100,9999) 的个数
    result_matrix(j/2,14)=tmp_length_no_NAN; % 非NaN的个数 
end


