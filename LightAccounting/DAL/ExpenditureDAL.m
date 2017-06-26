//
//  ExpenditureDAL.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/21.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "ExpenditureDAL.h"

@implementation ExpenditureDAL

static NSString *familycachestring = @"familycachestring";

static ExpenditureDAL *instance = nil;

+(ExpenditureDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

/**
 获取消费列表
 
 @param start 开始时间
 @param end 结束时间
 @param categoryid 类别
 @param minspend 最低消费
 @param maxspend 最高消费
 @return 消费列表
 */
-(NSArray *)getExpenditure:(NSDate*)start end:(NSDate *)end categoryid:(NSString *)categoryid minspend:(NSString*)minspend maxspend:(NSString*)maxspend{
    NSString *sql = [NSString stringWithFormat:@"SELECT A.EID,IFNULL(A.EVALUE,0) AS EVALUE,A.CID,A.FID,A.CREATETIME,A.EYEAR,A.EMONTH,A.EDAY,A.IMARK,A.PID,A.BDX,A.BDY,A.BDADDRESS,A.PHOTO1,\
                     C.CNAME,C.CCOLOR\
                     FROM BUS_EXPENDITURE A\
                     INNER JOIN BASE_FAMILY B ON A.FID=B.FID\
                     INNER JOIN BASE_CATEGORY C ON A.CID=C.CID\
                     WHERE C.ISVALID = 1 "];
    if (start!=nil) {
        sql = [sql stringByAppendingFormat:@" AND A.CREATETIME >= '%@' ",[start formatWithCode:dateformat_08]];
    }
    if(end!=nil){
        sql = [sql stringByAppendingFormat:@" AND A.CREATETIME <= '%@' ",[end formatWithCode:dateformat_09]];
    }
    if(![CommonFunc isBlankString:categoryid]){
        sql = [sql stringByAppendingFormat:@" AND C.CID='%@' ",categoryid];
    }
    if(![CommonFunc isBlankString:minspend]){
        sql = [sql stringByAppendingFormat:@" AND A.EVALUE>%f ",[minspend doubleValue]];
    }
    if(![CommonFunc isBlankString:maxspend]){
        sql = [sql stringByAppendingFormat:@" AND A.EVALUE<%f ",[maxspend doubleValue]];
    }
    sql = [sql stringByAppendingString:@" ORDER BY A.CREATETIME DESC "];
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    return array;
}

-(NSArray *)getAccountDetail:(NSDate*)start end:(NSDate *)end categoryid:(NSString *)categoryid minspend:(NSString*)minspend maxspend:(NSString*)maxspend{
    NSString *sql = [NSString stringWithFormat:@"SELECT A.EID,IFNULL(A.EVALUE,0) AS EVALUE,A.CID,A.FID,A.CREATETIME,A.EYEAR,A.EMONTH,A.EDAY,A.IMARK,A.PID,A.BDX,A.BDY,A.BDADDRESS,A.PHOTO1,\
                     C.CNAME,C.CCOLOR\
                     FROM BUS_EXPENDITURE A\
                     INNER JOIN BASE_FAMILY B ON A.FID=B.FID\
                     INNER JOIN BASE_CATEGORY C ON A.CID=C.CID\
                     WHERE C.ISVALID = 1 "];
    if (start!=nil) {
        sql = [sql stringByAppendingFormat:@" AND A.CREATETIME >= '%@' ",[start formatWithCode:dateformat_08]];
    }
    if(end!=nil){
        sql = [sql stringByAppendingFormat:@" AND A.CREATETIME <= '%@' ",[end formatWithCode:dateformat_09]];
    }
    if(![CommonFunc isBlankString:categoryid]){
        sql = [sql stringByAppendingFormat:@" AND C.CID='%@' ",categoryid];
    }
    if(![CommonFunc isBlankString:minspend]){
        sql = [sql stringByAppendingFormat:@" AND A.EVALUE>%f ",[minspend doubleValue]];
    }
    if(![CommonFunc isBlankString:maxspend]){
        sql = [sql stringByAppendingFormat:@" AND A.EVALUE<%f ",[maxspend doubleValue]];
    }
    sql = [sql stringByAppendingString:@" ORDER BY A.CREATETIME DESC "];
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    return array;
}

/**
 获取消费汇总

 @param year <#year description#>
 @return <#return value description#>
 */
-(NSArray *)getExpenditureByMonth:(NSString *)year{
    FamilyPerson *person;
    
    NSData *data = [[StoreUserDefault instance] getDataWithNSData:familycachestring];
    
    if (data!=nil) {
        person = [NSKeyedUnarchiver unarchiveObjectWithData:data] ;
    }else{
        NSArray *array = [[FamilyPersonDAL Instance] getFamilyPersons];
        if (array!=nil && array.count>0) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[array objectAtIndex:0]];
            
            [[StoreUserDefault instance] setData:familycachestring data:data];
            person = [array objectAtIndex:0];
        }
    }
    
    NSString *expendsql = [NSString stringWithFormat:@"SELECT SUM(EVALUE) AS EVALUE,EMONTH FROM BUS_EXPENDITURE WHERE EYEAR='%@' AND FID='%@' GROUP BY EMONTH",year,person.fid];
    
    NSMutableArray *array = [[FmdbHelper Instance] querySql:expendsql];
    return array;
}


/**
 更新消费照片

 @param eid 消费主键
 @param photo 照片路径（名称）
 @return 是否执行成功
 */
-(BOOL)updateExpenditurePhoto:(NSString *)eid photo:(NSString *)photo{
    
    NSString *sql = [NSString stringWithFormat:@" UPDATE BUS_EXPENDITURE SET PHOTO1='%@' WHERE EID='%@' ",photo,eid];
    
    BOOL result = [[FmdbHelper Instance] executeSql:sql];
    
    return result;
}

/*
 *---------------------------插入消费---------------------------------------------*
 */
-(BOOL)addExpenditure:(NewExpendModel *)model{
    
    model.eyear = [NSString stringWithFormat:@"%ld",(long)[model.createtime year]];
    model.emonth = [NSString stringWithFormat:@"%ld",(long)[model.createtime month]];
    model.eday = [NSString stringWithFormat:@"%ld",(long)[model.createtime day]];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO BUS_EXPENDITURE(EID,EVALUE,CID,FID,PID,CREATETIME,EYEAR,EMONTH,EDAY,IMARK,BDX,BDY,BDADDRESS,OUTBUDGET,ISPRIVATE) VALUES('%@',%f,'%@','%@','','%@','%@','%@','%@','%@','%@','%@','%@',%d,%d)",model.eid,[model.evalue floatValue],model.cid,model.fid,[model.createtime formatWithCode:@"yyyy-MM-dd"],model.eyear,model.emonth,model.eday,[model.imark replaceSqlString],model.bdx,model.bdy,model.bdaddress,model.outbudget,model.isprivate];
    
    NSString *sqlupdate = [NSString stringWithFormat:@"UPDATE APP_CONFIGURATION SET LASTDATE='%@'",model.createtime];
    
    NSArray *sqlArray = [[NSArray alloc] initWithObjects:sql,sqlupdate, nil];
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:sqlArray];
    
    return result;
}
/*
 *---------------------------修改消费---------------------------------------------*
 */
-(BOOL)updateExpenditure:(NSString *)eid evalue:(double)evalue oldvalue:(double)oldvalue cid:(NSString *)cid fid:(NSString *)fid pid:(NSString *)pid createtime:(NSString *)createtime eyear:(NSString *)eyear emonth:(NSString *)emonth eday:(NSString *)eday imark:(NSString *)imark bdx:(NSString *)bdx bdy:(NSString *)bdy address:(NSString *)address{
    
    double disnumber = evalue - oldvalue;
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE BUS_EXPENDITURE SET EVALUE=%f,CID='%@',FID='%@',PID='%@',CREATETIME='%@',EYEAR='%@',EMONTH='%@',EDAY='%@',IMARK='%@',BDX='%@',BDY='%@',BDADDRESS='%@' WHERE EID='%@'",evalue,cid,fid,pid,createtime,eyear,emonth,eday,imark,bdx,bdy,address,eid];
    
    NSString *updatePackageSql = [NSString stringWithFormat:@" UPDATE BASE_PACKAGE SET PVALUE = PVALUE-%f WHERE PID='%@' ",disnumber,pid];
    
    NSArray *sqlArray = [[NSArray alloc] initWithObjects:sql,updatePackageSql, nil];
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:sqlArray];
    
    return result;
}
/*
 *---------------------------获取支出详细信息---------------------------------------------*
 */
-(NSMutableArray*)getExpenditureDetail:(NSString*)cid sort:(NSInteger)sort start:(NSDate*)start end:(NSDate*)end{
    NSString *sortField = @"A.CREATETIME";
    if (sort == 0) {
        sortField = @"A.CREATETIME";
    }else if (sort == 1){
        sortField = @"A.EVALUE";
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT A.EID,A.PID,A.EVALUE,A.CREATETIME,A.IMARK,\
                     B.PNAME,B.PCOLOR \
                     FROM BUS_EXPENDITURE A \
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
 *-----------获取消费收入汇总-------------*
 */
-(NSDictionary*)getTotal:(NSString*)cid start:(NSDate*)start end:(NSDate*)end{
    NSString *sql = [NSString stringWithFormat:@"SELECT ifnull(SUM(EVALUE),0) AS MONEY,B.CNAME AS NAME FROM\
                     BUS_EXPENDITURE A INNER JOIN BASE_CATEGORY B ON A.CID = B.CID\
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

/*
 *-----------获取支出详细-------------*
 */
-(BusExpenditure*)getExpendDetail:(NSString*)eid{
    NSString *sql = [NSString stringWithFormat:@"SELECT EID,EVALUE,CID,FID,CREATETIME,EYEAR,EMONTH,EDAY,IMARK,PID,BDX,BDY,BDADDRESS FROM BUS_EXPENDITURE WHERE EID='%@'",eid];
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    if (array!=nil && array.count>0) {
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[BusExpenditure class] fromJSONArray:array error:nil];
        if (modelArray!=nil && modelArray.count>0) {
            return [modelArray objectAtIndex:0];
        }
    }
    return nil;
}

/*
 *---------------------------删除消费---------------------------------------------*
 */
-(BOOL)deleteExpenditure:(NSString *)eid pid:(NSString*)pid evalue:(double)evalue{
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM BUS_EXPENDITURE WHERE EID='%@'",eid];
    
    NSString *updatePackageSql = [NSString stringWithFormat:@" UPDATE BASE_PACKAGE SET PVALUE = PVALUE+%f WHERE PID='%@' ",evalue,pid];
    
    NSArray *sqlArray = [[NSArray alloc] initWithObjects:sql,updatePackageSql, nil];
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:sqlArray];
    
    return result;
}

/*
 *---------------------------获取消费汇总---------------------------------------------*
 */
-(NSMutableArray*)SelectExpenditure:(NSDate*)start end:(NSDate*)end{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT A.SUMVALUE,B.CID,B.CNAME FROM (SELECT IFNULL(SUM(A.EVALUE),0) AS SUMVALUE,A.CID FROM BUS_EXPENDITURE A WHERE A.CREATETIME>='%@' AND A.CREATETIME<='%@' GROUP BY A.CID) A INNER JOIN BASE_CATEGORY B ON A.CID=B.CID WHERE B.ISVALID=1 ORDER BY A.SUMVALUE DESC",[start formatWithCode:dateformat_08],[end formatWithCode:dateformat_09]];
    
    NSMutableArray *result = [[FmdbHelper Instance] querySql:sql];
    
    return result;
}

@end
