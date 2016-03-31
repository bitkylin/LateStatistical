%数据列命名
attlog.Properties.VariableNames{1} = 'id';
attlog.Properties.VariableNames{2} = 'rawData';
%时间日期字符串转化为向量格式
rawData=datevec(attlog.rawData);
%数据列排序
resultData(1:size(rawData,1),1)=attlog.id;
resultData(1:end,2:7)=rawData(1:end,1:6);
clear attlog rawData;
%数据重排列
resultData=sortrows(resultData);
%统计8:30之前，列为第8行
resultData(1:size(resultData,1),8)=( resultData(1:end,5)==8 &  resultData(1:end,6) <= 30) | (resultData(1:end,5)<8 ) ;
%统计10:00-14:30，列为第9行
resultData(1:size(resultData,1),9)=( resultData(1:end,5)>=10 &  resultData(1:end,5) < 14) | (resultData(1:end,5)==14 &  resultData(1:end,6) <= 30) ;
%统计16:00-19:00，列为第10行
resultData(1:size(resultData,1),10)=( resultData(1:end,5)>=16 &  resultData(1:end,5) < 19) | (resultData(1:end,5)==19 &  resultData(1:end,6) == 0) ;
%统计21:00之后，列为第11行
resultData(1:size(resultData,1),11)= resultData(1:end,5)>=21 ;
%欲删除的列表项，列为第12行
resultData(1:size(resultData,1),12)=resultData(1:size(resultData,1),8)+resultData(1:size(resultData,1),9)+resultData(1:size(resultData,1),10)+resultData(1:size(resultData,1),11);
%统计年份：2015年3月之前，列为第13行
resultData(1:size(resultData,1),13)= resultData(1:end,2)<2016 | (  resultData(1:end,2)==2016 &  resultData(1:end,3)<3 ) ;
%数据处理（列表项删除操作）
clippedData  = obtainYearMonth( resultData );
clippedData =obtainOnTime(clippedData );
clippedData(:,8:13)=[];
%数据输出
%outData = clippedData(:,1);
nameId=clippedData(:,1);
day=datestr(clippedData(:,2:7),'yyyy-mm-dd');
time=datestr(clippedData(:,2:7),'HH:MM:SS');
outData=table(nameId,day,time);
%统计每个人的迟到次数
count=histcounts(nameId)';
nameStr={'管理员';'李宗敏';'栾岳震';'宋梓槊';'王泰麟';'周强';'王猛';'空';'王焱';'黄三';'龙琴';'刘忠奇';'刘艳钊';'胡斯';'邓高峰';'刘少飞';'黄亚飞';'李明亮';'冯帅';'余马超'};
countLate = table(nameStr,count,'RowNames',nameStr);
%扫尾工作
clear resultData clippedData nameId day time count nameStr;
writetable(outData,'统计的详细迟到信息.xlsx');
writetable(countLate,'统计的迟到次数.xlsx');