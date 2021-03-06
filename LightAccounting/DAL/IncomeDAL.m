//
//  IncomeDAL.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/29.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "IncomeDAL.h"

@implementation IncomeDAL

static NSString *familycachestring = @"familycachestring";

static IncomeDAL *instance = nil;

+(IncomeDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

/*
 *---------------------------插入收入---------------------------------------------*
 */
-(BOOL)addIncome:(NewExpendModel *)model{
    
    model.eyear = [NSString stringWithFormat:@"%ld",(long)[model.createtime year]];
    model.emonth = [NSString stringWithFormat:@"%ld",(long)[model.createtime month]];
    model.eday = [NSString stringWithFormat:@"%ld",(long)[model.createtime day]];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO BUS_INCOME(IID,CID,FID,PID,IVALUE,CREATETIME,IYEAR,IMONTH,IDAY,IMARK,ISPRIVATE) VALUES('%@','%@','%@','%@','%f','%@','%@','%@','%@','%@',%d) ",model.eid,model.cid,model.fid,@"",[model.evalue floatValue],[model.createtime formatWithCode:@"yyyy-MM-dd"],model.eyear,model.emonth,model.eday,[model.imark replaceSqlString],model.isprivate];
    
    NSString *sqlupdate = [NSString stringWithFormat:@"UPDATE APP_CONFIGURATION SET LASTDATE='%@'",[model.createtime formatWithCode:@"yyyy-MM-dd HH:mm:ss"]];
    
    NSArray *sqlArray = [[NSArray alloc] initWithObjects:sql,sqlupdate, nil];
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:sqlArray];
    
    return result;
}
/*
 *---------------------------修改收入---------------------------------------------*
 */
-(BOOL)updateIncome:(NSString *)eid evalue:(double)evalue oldvalue:(double)oldvalue cid:(NSString *)cid fid:(NSString *)fid pid:(NSString *)pid createtime:(NSString *)createtime eyear:(NSString *)eyear emonth:(NSString *)emonth eday:(NSString *)eday imark:(NSString *)imark{
    
    double disnumber = evalue - oldvalue;
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE BUS_INCOME SET CID='%@',FID='%@',PID='%@',IVALUE=%f,CREATETIME='%@',IYEAR='%@',IMONTH='%@',IDAY='%@',IMARK='%@' WHERE IID='%@'",cid,fid,pid,evalue,createtime,eyear,emonth,eday,imark,eid];
    
    NSString *updatePackageSql = [NSString stringWithFormat:@" UPDATE BASE_PACKAGE SET PVALUE = PVALUE+%f WHERE PID='%@' ",disnumber,pid];
    
    NSArray *sqlArray = [[NSArray alloc] initWithObjects:sql,updatePackageSql, nil];
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:sqlArray];
    
    return result;
}

/*
 *---------------------------获取收入详细信息---------------------------------------------*
 */
/*
 *---------------------------获取支出详细信息---------------------------------------------*
 */
-(NSMutableArray*)getIncomeDetail:(NSString*)cid sort:(NSInteger)sort start:(NSDate*)start end:(NSDate*)end{
    NSString *sortField = @"A.CREATETIME";
    if (sort == 0) {
        sortField = @"A.CREATETIME";
    }else if (sort == 1){
        sortField = @"A.EVALUE";
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT A.IID AS EID,A.PID,A.IVALUE AS EVALUE,A.CREATETIME,A.IMARK,\
                     B.PNAME,B.PCOLOR \
                     FROM BUS_INCOME A \
                     INNER JOIN BASE_PACKAGE B ON A.PID = B.PID \
                     WHERE A.CREATETIME>='%@' AND A.CREATETIME<='%@'",[start formatWithCode:dateformat_08],[end formatWithCode:dateformat_09]];
    if (![cid isBlankString]) {
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@" AND A.CID='%@' ",cid]];
    }
    sql = [sql stringByAppendingString:[NSString stringWithFormat:@" ORDER BY %@ DESC ",sortField]];
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    NSArray *result = [MTLJSONAdapter modelsOfClass:[SpendDetail class] fromJSONArray:array error:nil];
    return [result mutableCopy];
}
/*
 *-----------获取收入汇总-------------*
 */
-(NSDictionary*)getTotal:(NSString*)cid start:(NSDate*)start end:(NSDate*)end{
    NSString *sql = [NSString stringWithFormat:@"SELECT ifnull(SUM(IVALUE),0) AS MONEY,B.CNAME AS NAME FROM\
                     BUS_INCOME A INNER JOIN BASE_CATEGORY B ON A.CID = B.CID\
                     WHERE B.ISVALID=1 AND A.CREATETIME>='%@' AND A.CREATETIME<='%@'",[start formatWithCode:dateformat_08],[end formatWithCode:dateformat_09]];
    if (![cid isBlankString]) {
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@" AND A.CID='%@' ",cid]];
    }
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    if (array!=nil && array.count>0) {
        return [array objectAtIndex:0];
    }
    return nil;
}

/**
 获取年度收入汇总

 @param year <#year description#>
 @param categoryids <#categoryids description#>
 @param minspend <#minspend description#>
 @param maxspend <#maxspend description#>
 @param outlet <#outlet description#>
 @param isprivate <#isprivate description#>
 @return <#return value description#>
 */
-(NSArray *)getIncomeByYear:(NSString *)year categoryid:(NSArray<NSString *>*)categoryids minspend:(NSString*)minspend maxspend:(NSString*)maxspend isprivate:(BOOL)isprivate{
    NSString *sql = [NSString stringWithFormat:@"SELECT CREATETIME,SUM(A.EVALUE) AS EVALUE FROM (\
                     SELECT IFNULL(A.IVALUE,0) AS EVALUE,substr(A.CREATETIME,0,7) AS CREATETIME\
                     FROM BUS_INCOME A\
                     INNER JOIN BASE_FAMILY B ON A.FID=B.FID\
                     INNER JOIN BASE_CATEGORY C ON A.CID=C.CID\
                     WHERE C.ISVALID = 1 AND A.CREATETIME GLOB '%@*' ",year];
    
    NSData *data = [[StoreUserDefault instance] getDataWithNSData:familycachestring];
    
    if (data!=nil) {
        FamilyPerson *person = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (person!=nil) {
            sql = [sql stringByAppendingFormat:@" AND A.FID='%@' ",person.fid];
        }
    }
    if (isprivate) {

    }else{
        sql = [sql stringByAppendingString:@" AND A.ISPRIVATE!=1 "];
    }
    if(categoryids!=nil && categoryids.count>0){
        NSString *cids = @"";
        for (NSString *str in categoryids) {
            cids = [cids stringByAppendingFormat:@"'%@',",str];
        }
        cids = [cids substringToIndex:([cids length]-1)];
        sql = [sql stringByAppendingFormat:@" AND C.CID IN (%@)",cids];
    }
    if(![CommonFunc isBlankString:minspend]){
        sql = [sql stringByAppendingFormat:@" AND A.EVALUE>%f ",[minspend doubleValue]];
    }
    if(![CommonFunc isBlankString:maxspend]){
        sql = [sql stringByAppendingFormat:@" AND A.EVALUE<%f ",[maxspend doubleValue]];
    }
    
    sql = [sql stringByAppendingString:@") A WHERE 1=1 GROUP BY A.CREATETIME"];
    
    NSMutableArray *array = [[FmdbHelper Instance] querySql:sql];
    return array;
}

/*
 *-----------获取支出详细-------------*
 */
-(BusIncome*)getIncomeDetail:(NSString*)iid{
    NSString *sql = [NSString stringWithFormat:@"SELECT IID,IVALUE,CID,FID,CREATETIME,IYEAR,IMONTH,IDAY,IMARK,PID FROM BUS_INCOME WHERE IID='%@'",iid];
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    if (array!=nil && array.count>0) {
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[BusIncome class] fromJSONArray:array error:nil];
        if (modelArray!=nil && modelArray.count>0) {
            return [modelArray objectAtIndex:0];
        }
    }
    return nil;
}

/*
 *---------------------------删除收入---------------------------------------------*
 */
-(BOOL)deleteIncome:(NSString *)eid{
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM BUS_INCOME WHERE IID='%@'",eid];
    
//    NSString *updatePackageSql = [NSString stringWithFormat:@" UPDATE BASE_PACKAGE SET PVALUE = PVALUE-%f WHERE PID='%@' ",evalue,pid];
    
    NSArray *sqlArray = [[NSArray alloc] initWithObjects:sql, nil];
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:sqlArray];
    
    return result;
}

/*
 *---------------------------获取消费汇总---------------------------------------------*
 */
-(NSMutableArray*)SelectIncome:(NSDate*)start end:(NSDate*)end{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT A.SUMVALUE,B.CID,B.CNAME FROM (SELECT IFNULL(SUM(A.IVALUE),0) AS SUMVALUE,A.CID FROM BUS_INCOME A WHERE A.CREATETIME>='%@' AND A.CREATETIME<='%@' GROUP BY A.CID) A INNER JOIN BASE_CATEGORY B ON A.CID=B.CID WHERE B.ISVALID=1 ORDER BY A.SUMVALUE DESC",[start formatWithCode:dateformat_08],[end formatWithCode:dateformat_09]];
    
    NSMutableArray *result = [[FmdbHelper Instance] querySql:sql];
    
    return result;
}

@end
