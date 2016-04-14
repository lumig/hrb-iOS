//
//  UserMessageDataBase.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/11.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "UserMessageDataBase.h"

@implementation UserMessageDataBase
static UserMessageDataBase *g_userMessageDataBase;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _db = [SDBManager defaultDBManager].dataBase;
    }
    return self;
}

+ (UserMessageDataBase *)shareUserMessageDataBase
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_userMessageDataBase = [[self alloc] init];
    });
    return g_userMessageDataBase;

}


- (void)createUserMessageDataBase
{
    FMResultSet *set = [_db executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",@"UserMessageTable"]];
    
    [set next];
    
    NSInteger count = [set intForColumnIndex:0];
    
    BOOL existTable = !!count;
    
    if (existTable)
    {
    }
    else
    {
        NSString * sql = @"CREATE TABLE UserMessageTable (uid INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, username VARCHAR(11) ,password VARCHAR(50))";
        
        BOOL res = [_db executeUpdate:sql];
        
        if (!res)
        {
            NSLog(@"UserMessageTable数据库创建失败");
        }
    }
    
}


- (void)addUserMessage:(UserInfo *)info
{
    if (!info.username) {
        return;
    }
    
    if ([self findUserMessageWithUsername:info.username]) {
        return;
    }
    
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO UserMessageTable"];
    NSMutableString * keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString * values = [NSMutableString stringWithFormat:@" ( "];
    NSMutableArray * arguments = [[NSMutableArray alloc]init];
    
    if (info.username) {
        [keys appendString:@"username,"];
        [values appendString:@"?,"];
        [arguments addObject:info.username];
    }

    if (info.password) {
        [keys appendString:@"password,"];
        [values appendString:@"?,"];
        [arguments addObject:info.password];
    }
    
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
     [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
     [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
    
    [_db executeUpdate:query withArgumentsInArray:arguments];
}


- (void)updataUserMessageWithUser:(UserInfo *)info
{
    if (!info.username) {
        return;
    }
    
    NSString * query = @"UPDATE UserMessageTable SET";
    NSMutableString * temp = [[NSMutableString alloc] init];
    
    if (info.password)
    {
        [temp appendFormat:@" password = '%@',",info.password];
    }
    
    [temp appendString:@")"];
    query = [query stringByAppendingFormat:@"%@ WHERE username = '%@'",[temp stringByReplacingOccurrencesOfString:@",)" withString:@""],info.username];
    
    [_db executeUpdate:query];
}

- (UserInfo *)findUserMessageWithUsername:(NSString *)username
{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM UserMessageTable WHERE username = '%@'",username];
    FMResultSet * rs = [_db executeQuery:query];
    
    while ([rs next])
    {
        UserInfo *info = [[UserInfo alloc]init];
        info.username = [rs stringForColumn:@"username"];
        info.password = [rs stringForColumn:@"password"];
        
        return info;
    }
    [rs close];
    
    return nil;
}

@end
