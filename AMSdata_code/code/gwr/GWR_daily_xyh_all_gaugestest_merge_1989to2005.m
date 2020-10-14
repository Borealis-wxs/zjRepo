% clc;
% clear;
% if exist('mergepre_test_1989to2005','dir')>=1
%     rmdir('mergepre_test_1989to2005','s')
% end
mkdir('mergepre_test_1989to2005');
mkdir('mergepre_test_1989to2005//ARG');
mkdir('mergepre_test_1989to2005//PRE');
%% ���׶��ս�ˮ��GWR��ֵ����(���þ�γ��+�߳���Ϣ)
%% ��ȡվ�㽵�����ݺ�վ����ͱ�����������Ϣ��
% 1.0 ��ȡ1km����̣߳�����1km��ֵ����
file = dir('D://workststion//matlab//20190612GWR//input_files1989-2005//rec_mswep//txt//*.txt');
filenum = length(file);
for idx = 1676: filenum %392-19910725��803-19940607��
%��195-19900611��389-19910722;561-19920810;751-19930916;1001-19950722;
%1301-19970716;1601-19990710��
    tempFileName = file(idx).name;
    idx
    % ��ȡ�ַ����е�����
    str_tmp=tempFileName;
    str_digital=str_tmp(isstrprop(str_tmp,'digit'));
    pthFileName1  = sprintf('D://workststion//matlab//20190612GWR//input_files1989-2005//rec_mswep//txt//%s.tif.txt',str_digital);
    fid=fopen(pthFileName1,'rt');
    
    
    %��ֻ���ķ�ʽ�򿪲ü���դ���ļ�
    f=textscan(fid,'%s %f',6);                                                 %��ȡǰ���б�ͷ
    B=f{2};                                                                    %��ȡǰ���б�ͷ�ڶ�������
    ncols=B(1);nrows=B(2);
    xllcorner=B(3);yllcorner=B(4);
    cellsize=B(5);NODATA_value=B(6);
    elevation=[];Ra_Ex=textscan(fid,'');
    fclose(fid);
    for i=1:length(Ra_Ex)
        elevation=[elevation,Ra_Ex{1,i}];
    end
    judge_matrix=(elevation==-9999);
    B=[];
    y_lefttop=yllcorner+nrows*cellsize;x_lefttop=xllcorner;
    y_leftdown=yllcorner;x_righttop=xllcorner+ncols*cellsize;
    Y_interplot=y_lefttop-cellsize/2:-cellsize:y_leftdown+cellsize/2;          % ��ֵ���ĵ�
    X_interplot=x_lefttop+cellsize/2:cellsize:x_righttop-cellsize/2;
    % 2.0 ��ȡ����վ��Ϣ������վ�߳���Ϣ����
    gauge_file='D:\workststion\matlab\20190612GWR\input_files1989-2005\̫����������վ_all.xlsx';
    [a,b,c]=xlsread(gauge_file,'����ɸѡ���');c(1,:)=[];
    for i=1:size(c,1)
        gauge_information(i,1)=c{i,3};    %վ�����
        gauge_information(i,2)=c{i,8};   %վ�㾭��ͶӰ����
        gauge_information(i,3)=c{i,9};   %վ��γ��ͶӰ����
    end
    for i=1:size(gauge_information,1)
        if y_leftdown-gauge_information(i,3)==0
            location(i,1)=fix((y_lefttop-gauge_information(i,3))./cellsize);
        else
            location(i,1)=fix((y_lefttop-gauge_information(i,3))./cellsize)+1;
        end
        if gauge_information(i,2)-x_righttop==0
            location(i,2)=fix((gauge_information(i,2)-x_lefttop)./cellsize);
        else
            location(i,2)=fix((gauge_information(i,2)-x_lefttop)./cellsize)+1;
        end
        gauge_information(i,4)=elevation(location(i,1),location(i,2));
    end
    % 3.0 ��ȡ���ս�������Ϣ
    %rain_file='D:\workststion\matlab\data\20190430-gwr\GWR��ֵ_ȫ�����ø߳���Ϣ\0.1\input_files1979-1988\1979_1988daypre.xlsx';
    rain_file='D:\workststion\matlab\20190612GWR\input_files1989-2005\1989_2005_error.xlsx';
    
    [a,b,c]=xlsread(rain_file,'all3');
    %daily_rain_data=c(4:size(c,1),:);
    daily_rain_data=c(idx+3,:);
    daily_rain_data=cell2mat(daily_rain_data);
    %PRE=daily_rain_data(1:end,2:end);DATE=daily_rain_data(1:end,1);    % ʱ�䷶Χ�ǣ�20140101-20151231
    PRE=daily_rain_data(1,2:end);DATE=daily_rain_data(1,1);    % ʱ�䷶Χ�ǣ�20140101-20151231

    %% ����/��������GWRģ�Ͳ�������+��������GWRģ�Ͳ�������
    index_pre0=[];EE=[];
    PRE_01=PRE;PRE_01(PRE>=0.1)=1;PRE_01(PRE<0.1)=0;
    tic;
    for i=1:size(PRE_01,1)
        % �׶�1������ʶ��
        y=PRE_01(i,:)';
        percen_pre=sum(y)/length(y);
        nobs=length(y);
        x=[ones(nobs,1)*1000 gauge_information(:,2:3)/1000 gauge_information(:,4)];
        east=gauge_information(:,2)/1000;
        north=gauge_information(:,3)/1000;
        %x=[ones(nobs,1) gauge_information(:,2:3) gauge_information(:,4)];
        %east=gauge_information(:,2);
        %north=gauge_information(:,3);
        info.dtype='gaussian';
        % tic;
        result=gwr(y,x,east,north,info);
        % toc;
        P0=result.y;P_sim0=result.yhat;
        options=optimset('MaxIter',500,'TolX',0.001);thre_min=0;thre_max=1;
        [threshold,junk,exitflag,output]=fminbnd('search_threshold',thre_min,thre_max,options,P0,P_sim0);
        P_sim0(P_sim0<threshold)=0;P_sim0(P_sim0>=threshold)=1;
        bwidth0=result.bwidth;
        % ����������
        y=PRE(i,:)';
        % tic;
        result=gwr(y,x,east,north,info);
        % toc;
        P1=result.y;P_sim1=result.yhat;
        P=P1;P_sim=P_sim1.*P_sim0;
        bwidth1=result.bwidth;
        E=P-P_sim;
        ME=mean(E);
        MAE=mean(abs(E));
        BIAS=sum(E)/sum(P)*100;
        ABIAS=sum(abs(E))/sum(P)*100;
        CC0=corrcoef(P,P_sim);CC=CC0(1,2);
        % index_pre=[index_pre;q_best,ME,MAE,BIAS,ABIAS,CC];
        index_pre0=[index_pre0;bwidth0,threshold,percen_pre,bwidth1,ME,MAE,BIAS,ABIAS,CC];
        EE=[EE,E];
    end
    toc;
    bwidth0=index_pre0(:,1);threshold=index_pre0(:,2);
    bwidth1=index_pre0(:,4);
    %% �����ģ��� 
    target_path='D:\workststion\matlab\20190612GWR\mergepre_test_1989to2005\';
    target_file='GWR_xyh_ȫ������վ_��ģ���.xlsx';
    file_name=strcat(target_path,target_file);
    if 1==idx % ��һ���ļ�����Ҫ��д���ͷ,���಻��
        name_col=[{'ʱ��'},{'����ʶ�����'},{'�����б��ٽ�ֵ'},{'����վ�����'},{'���Ŵ���'},{'ME'},{'MAE'},{'BIAS'},{'ABIAS'},{'CC'}];
        xlswrite(file_name,name_col,'Sheet1','A1'); %��excel��A1��ʼ��λ��д���ͷ����
    end
    index_write_date=strcat('A',num2str(idx+1));
    index_write_result=strcat('B',num2str(idx+1));
    xlswrite(file_name,DATE,'Sheet1',index_write_date);%��excel��A2��λ��д����������
    xlswrite(file_name,index_pre0,'Sheet1',index_write_result);%��excel��B2��λ��д�����������
    
%     target_path='D:\workststion\matlab\20190612GWR\mergepre_test_1989to2005\';
%     target_file='GWR_xyh_ȫ������վ_ģ��в�.xlsx';
%     file_name=strcat(target_path,target_file);
%     index_write_date2=strcat('A',num2str(idx));
%     index_write_result2=strcat('B',num2str(idx));
%     xlswrite(file_name,DATE','Sheet1',index_write_date2);
%     xlswrite(file_name,EE','Sheet1',index_write_result2);
    fprintf(1,'=====================GWR��ģ����===================\n');
    %% ����GWRģ�ͽ��н���ռ��ֵ
    % ��ȡ����γ������͸߳�
    fid=fopen(pthFileName1,'rt') %��ֻ���ķ�ʽ�򿪲ü���դ���ļ�
    f=textscan(fid,'%s %f',6);                                                 %��ȡǰ���б�ͷ
    B=f{2};                                                                    %��ȡǰ���б�ͷ�ڶ�������
    ncols=B(1);nrows=B(2);
    xllcorner=B(3)/1000;yllcorner=B(4)/1000;
    cellsize=B(5)/1000;NODATA_value=B(6);
    %xllcorner=B(3);yllcorner=B(4);
    %cellsize=B(5);NODATA_value=B(6);
    elevation=[];Ra_Ex=textscan(fid,'');
    fclose(fid);
    for i=1:length(Ra_Ex)
        elevation=[elevation,Ra_Ex{1,i}];
    end
    y_lefttop=yllcorner+nrows*cellsize;x_lefttop=xllcorner;
    y_leftdown=yllcorner;x_righttop=xllcorner+ncols*cellsize;
    Y_interplot=y_lefttop-cellsize/2:-cellsize:y_leftdown+cellsize/2;          % ��ֵ���ĵ�
    X_interplot=x_lefttop+cellsize/2:cellsize:x_righttop-cellsize/2;
    [XI,YI]=meshgrid(X_interplot,Y_interplot);                                 % ��ֵ����
    GRIDP_index=zeros(nrows,ncols);GRIDP=zeros(nrows,ncols);
    GRIDC0=zeros(nrows,ncols); GRIDCX=zeros(nrows,ncols);
    GRIDCY=zeros(nrows,ncols); GRIDCH=zeros(nrows,ncols);
    dstring=info.dtype;
    if strcmp(dstring,'gaussian')
        dtype=0;
    elseif strcmp(dstring,'exponential')
        dtype=1;
    elseif strcmp(dstring,'bi_square')
        dtype=2;
    end
    for kk=1:size(PRE,1)
        y0=PRE_01(kk,:)';y1=PRE(kk,:)';
        wt=zeros(length(y1),1);d=zeros(length(y1),1);
        for i=1:nrows
            for j=1:ncols
                % 1.���㵥Ԫ���Ƿ�����
                gxy=[XI(i,j),YI(i,j)];
                gh=elevation(i,j);
                dx=east-gxy(1);
                dy=north-gxy(2);
                d=(dx.*dx + dy.*dy);
                sd=std(sqrt(d));
                % sort distance to find q nearest neighbors
                ds=sort(d);
                if dtype==2
                    dmax=ds(q_best(kk),1);
                end
                if dtype == 0      % Gausian weights
                    wt = stdn_pdf(sqrt(d)/(sd*bwidth0(kk)));
                elseif dtype==1, % exponential weights
                    wt = exp(-d/bwidth0(kk));
                elseif dtype==2, % bi_square weights
                    wt = zeros(n,1);
                    nzip = find(d<= dmax);
                    wt(nzip,1)=(1-(d(nzip,1)/dmax).^2).^2;
                end
                wt = sqrt(wt);
                % computational trick to speed things up
                % use non-zero wt to pull out y,x observations
                nzip=find(wt>=0.01);
                ys=y0(nzip,1).*wt(nzip,1);
                xs=matmul(x(nzip,:),wt(nzip,1));
                xpxi=invpd(xs'*xs);
                b=xpxi*xs'*ys;
                VAR=[1000,gxy,gh];
                pre_index=VAR*b;
                if pre_index>=threshold(kk)
                    GRIDP_index(i,j)=1;
                else
                    GRIDP_index(i,j)=0;
                end
                % 2.���㵥Ԫ������
                % sort distance to find q nearest neighbors
                if dtype==2
                    dmax=ds(q_best(kk),1);
                end
                if dtype == 0    % Gausian weights
                    wt = stdn_pdf(sqrt(d)/(sd*bwidth1(kk)));
                elseif dtype==1, % exponential weights
                    wt = exp(-d/bwidth1(kk));
                elseif dtype==2, % bi_square weights
                    wt = zeros(n,1);
                    nzip = find(d<=dmax);
                    wt(nzip,1)=(1-(d(nzip,1)/dmax).^2).^2;
                end
                wt = sqrt(wt);
                % computational trick to speed things up
                % use non-zero wt to pull out y,x observations
                nzip=find(wt>=0.01);
                ys=y1(nzip,1).*wt(nzip,1);
                xs=matmul(x(nzip,:),wt(nzip,1));
                xpxi=invpd(xs'*xs);
                b=xpxi*xs'*ys;
                GRIDP(i,j)=VAR*b;
                % compute predicted values
                GRIDP(i,j)=GRIDP_index(i,j)*GRIDP(i,j);
                GRIDC0(i,j)=b(1);GRIDCX(i,j)=b(2);
                GRIDCY(i,j)=b(3);GRIDCH(i,j)=b(4);
            end
        end
        model='GWR';
        GRIDP_index(judge_matrix)=-9999;
        GRIDP(judge_matrix)=-9999;
        GRIDC0(judge_matrix)=-9999;GRIDCX(judge_matrix)=-9999;
        GRIDCY(judge_matrix)=-9999;GRIDCH(judge_matrix)=-9999;
        path_pre='D:\workststion\matlab\20190612GWR\mergepre_test_1989to2005\PRE\';
        path_par='D:\workststion\matlab\20190612GWR\mergepre_test_1989to2005\ARG\';
        name1=strcat(path_pre,model,num2str(DATE(kk)),'_index.txt');
        fid=fopen(name1,'a+');
        fprintf(fid,'%-16s %d\r\n','ncols',ncols);
        fprintf(fid,'%-16s %d\r\n','nrows',nrows);
        fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner*1000);
        fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner*1000);
        fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize*1000);
%         fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner);
%         fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner);
%         fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize);
        fprintf(fid,'%-16s %10.3f\r\n','NODATA_value',NODATA_value);
        fclose(fid);
        dlmwrite(name1,GRIDP_index,'-append','precision','%10.3f','delimiter','\t','newline','pc');
        
        name2=strcat(path_pre,model,num2str(DATE(kk)),'.txt');
        fid=fopen(name2,'a+');
        fprintf(fid,'%-16s %d\r\n','ncols',ncols);
        fprintf(fid,'%-16s %d\r\n','nrows',nrows);
        fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner*1000);
        fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner*1000);
        fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize*1000);
%         fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner);
%         fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner);
%         fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize);
        fprintf(fid,'%-16s %10.3f\r\n','NODATA_value',NODATA_value);
        fclose(fid);
        dlmwrite(name2,GRIDP,'-append','precision','%10.3f','delimiter','\t','newline','pc');
        
        name3=strcat(path_par,model,num2str(DATE(kk)),'_par_c0.txt');
        fid=fopen(name3,'a+');
        fprintf(fid,'%-16s %d\r\n','ncols',ncols);
        fprintf(fid,'%-16s %d\r\n','nrows',nrows);
        fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner*1000);
        fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner*1000);
        fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize*1000);
%         fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner);
%         fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner);
%         fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize);
        fprintf(fid,'%-16s %10.3f\r\n','NODATA_value',NODATA_value);
        fclose(fid);
        dlmwrite(name3,GRIDC0,'-append','precision','%10.3f','delimiter','\t','newline','pc');
        
        name4=strcat(path_par,model,num2str(DATE(kk)),'_par_x.txt');
        fid=fopen(name4,'a+');
        fprintf(fid,'%-16s %d\r\n','ncols',ncols);
        fprintf(fid,'%-16s %d\r\n','nrows',nrows);
        fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner*1000);
        fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner*1000);
        fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize*1000);
%         fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner);
%         fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner);
%         fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize);
        fprintf(fid,'%-16s %10.3f\r\n','NODATA_value',NODATA_value);
        fclose(fid);
        dlmwrite(name4,GRIDCX,'-append','precision','%10.3f','delimiter','\t','newline','pc');
        
        name5=strcat(path_par,model,num2str(DATE(kk)),'_par_y.txt');
        fid=fopen(name5,'a+');
        fprintf(fid,'%-16s %d\r\n','ncols',ncols);
        fprintf(fid,'%-16s %d\r\n','nrows',nrows);
        fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner*1000);
        fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner*1000);
        fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize*1000);
%         fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner);
%         fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner);
%         fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize);
        fprintf(fid,'%-16s %10.3f\r\n','NODATA_value',NODATA_value);
        fclose(fid);
        dlmwrite(name5,GRIDCY,'-append','precision','%10.3f','delimiter','\t','newline','pc');
        
        name6=strcat(path_par,model,num2str(DATE(kk)),'_par_h.txt');
        fid=fopen(name6,'a+');
        fprintf(fid,'%-16s %d\r\n','ncols',ncols);
        fprintf(fid,'%-16s %d\r\n','nrows',nrows);
        fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner*1000);
        fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner*1000);
        fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize*1000);
%         fprintf(fid,'%-16s %f\r\n','xllcorner',xllcorner);
%         fprintf(fid,'%-16s %f\r\n','yllcorner',yllcorner);
%         fprintf(fid,'%-16s %10.3f\r\n','cellsize',cellsize);
        fprintf(fid,'%-16s %10.3f\r\n','NODATA_value',NODATA_value);
        fclose(fid);
        dlmwrite(name6,GRIDCH,'-append','precision','%10.3f','delimiter','\t','newline','pc');
        
        name1=strcat(model,num2str(DATE(kk)),'.txt');
        fprintf(1,'finished day_list=%d\n',kk);
    end
end
    fprintf(1,'=====================GWR��ֵ����===================\n');