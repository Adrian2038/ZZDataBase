//
//  ViewController.m
//  ZZDataBase
//
//  Created by Dengquan Zhu on 15/8/14.
//  Copyright (c) 2015年 Zhu Dengquan. All rights reserved.
//

#import "ViewController.h"

#import "FMDatabase.h"

#define InfoTable @"InfoTable"

#define SId @"Id"
#define SName @"name"
#define SAge  @"age"
#define SAddress @"address"

@interface ViewController ()

{
  FMDatabase *db;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  db = [FMDatabase databaseWithPath:@"/Users/zhudengquan/Desktop/info.db"];
  
  if (![db open]) {
    NSLog(@"db can't open");
    return;
  }
  
//  [self creatTable];
//  [self addData];
  [self queryData];
  
  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
}

- (void)creatTable
{
  if ([db open]) {
    NSString *sqlCreateTable = [NSString stringWithFormat:
                                @"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, \
                                '%@' TEXT, '%@' INTEGER, '%@', TEXT)",
                                InfoTable, SId, SName, SAge, SAddress];
    BOOL res = [db executeUpdate:sqlCreateTable];
    
    if (res) {
      NSLog(@"success to creating db infoTable");
    }
    else {
      NSLog(@"error to creating db infoTable");
    }
    
    [db close];
  }
}

- (void)addData
{
  if ([db open]) {
    NSString *insertSql1 = [NSString stringWithFormat:
                            @"INSERT INTO '%@'('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                            InfoTable, SName, SAge, SAddress, @"朱邓全", @"100", @"北京"];
    BOOL res = [db executeUpdate:insertSql1];
    
    NSString *insertSql2 = [NSString stringWithFormat:
                            @"INSERT INTO '%@'('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                            InfoTable, SName, SAge, SAddress, @"朱邓诚", @"90", @"上海"];
    BOOL res2 = [db executeUpdate:insertSql2];
    
    if (res && res2) {
      NSLog(@"success to insert data to InfoTable");
    }
    else {
      NSLog(@"error to insert data to InfoTable");
    }
    
    [db close];
  }
}

- (void)queryData
{
  if ([db open]) {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", InfoTable];
    
    FMResultSet *rs = [db executeQuery:sql];
    
    while ([rs next]) {
      int Id = [rs intForColumn:SId];
      
      NSString *name = [rs stringForColumn:SName];
      NSString *age = [rs stringForColumn:SAge];
      NSString *address = [rs stringForColumn:SAddress];
      
      NSLog(@"\n Id = %d, \n name = %@,\n age = %@,\n address = %@", Id, name, age, address);
    }
    [db close];
  }
}


@end
