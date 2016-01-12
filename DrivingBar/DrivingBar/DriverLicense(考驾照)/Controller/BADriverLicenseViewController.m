//
//  BADriverLicenseViewController.m
//  优优
//
//  Created by boai on 15/12/7.
//  Copyright © 2015年 yueqian. All rights reserved.
//

#import "BADriverLicenseViewController.h"
#import "BAPDCView.h"
#import "public.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "BATestDataFromDataBase.h"

@interface BADriverLicenseViewController ()

@end

@implementation BADriverLicenseViewController

- (void)viewWillAppear:(BOOL)animated
{
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationController.navigationBar.barTintColor = RGB_BACKGROUND_COLOR_BLUE;
    [self.navigationController.navigationBar setTranslucent:NO];
    //导航栏标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"考驾照";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.view.backgroundColor = [UIColor clearColor];
    //  self.navigationItem.titleView = titleLabel;
    self.tabBarController.navigationItem.titleView = titleLabel;
    //  NSLog(@"view will appear");


    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *path = [document stringByAppendingPathComponent:@"youyou.sqlite"];
    self.paths = path;
    NSLog(@"数据库路径：%@", self.paths);

    //注意以上三句话是获取数据库路径必不可少的，在viewDidload之前就已经准备好了
    self.nameArray = [[NSMutableArray alloc]init];
    self.ageArray = [[NSMutableArray alloc]init];
    self.IDArray = [[NSMutableArray alloc]init];
    [self creatSqlite];
//    [self getAllDatabase];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpPDCView];
    
}

- (void)setUpPDCView
{
    BAPDCView *pv = [[BAPDCView alloc] initWithSize:self.view.frame.size at:self.view];
    
    [pv selected:^(NSIndexPath *indexPath, UITableView *tableView, UITableViewCell *cell){
        
    }];
}

- (void)creatSqlite
{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.paths]) {
        NSLog(@"表不存在，创建表");
        FMDatabase *db =[FMDatabase databaseWithPath:self.paths];
        NSLog(@"数据库路径：%@", self.paths);

        if ([db open]) {
            NSString *sql = @"CREATE TABLE 'youyou'('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' VARCHAR(20),'age' VARCHAR(20),'idcode' VARCHAR(30))    ";//sql语句
            BOOL success = [db executeUpdate:sql];
            if (!success) {
                NSLog(@"error when create table ");
            }else{
                NSLog(@"create table succeed");
            }
            [db close];
        }else{
            NSLog(@"database open error");
        }
    }
}

// 从数据库中获得所有数据
- (void)getAllDatabase
{
    FMDatabase *db = [FMDatabase databaseWithPath:self.paths];
    if ([db open])
    {
        NSString *sql = @"SELECT * FROM youyou";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            NSString *name = [rs stringForColumn:@"name"];
            NSString *age = [rs stringForColumn:@"age"];
            NSString *ID = [rs stringForColumn:@"idcode"];
            
            [self.nameArray addObject:name];
            [self.ageArray addObject:age];
            [self.IDArray addObject:ID];
        }
        [[BATestDataFromDataBase shareFromDataBase].nameArrayFromTable arrayByAddingObjectsFromArray:self.nameArray];
        NSLog(@"self.nameArray==%@",self.nameArray);
        [db close];
//        [self.tableView reloadData];
    }
}

// 添加数据到数据库
//- (void)addNewUserInfo
//{
//    FMDatabase *db = [[FMDatabase alloc]initWithPath:self.dbPath];
//    if ([db open]) {
//        
//        if (_nameTextField.text.length == 0||_ageTextField.text.length == 0||_IDTextField.text.length == 0){
//            
//            [XFNotices noticesWithTitle:@"请完成填写信息" Time:1.5 View:self.view Style:(XFNoticesStyleFail)];
//        }else{
//            NSLog(@"姓名==%@,年龄==%@,ID==%@",_nameTextField.text,_ageTextField.text,_IDTextField.text);
//            NSString *sql= nil;
//            if (self.operateType == 0){//执行插入操作
//                sql = @"INSERT INTO USER (name,age,idcode) VALUES (?,?,?) ";
//            }else if(_operateType == 1)//执行更新操作
//            {
//                sql = @"UPDATE USER  SET name = ? , age = ? where idcode = ?";
//                
//            }
//            
//            BOOL res = [db executeUpdate:sql,_nameTextField.text,_ageTextField.text,_IDTextField.text];
//            if (!res) {
//                [XFNotices noticesWithTitle:@"数据插入错误" Time:1.5 View:self.view Style:(XFNoticesStyleFail)];
//            }else{
//                [XFNotices noticesWithTitle:@"数据插入成功" Time:1.5 View:self.view Style:(XFNoticesStyleFail)];
//            }
//        }
//    }else{
//        NSLog(@"数据库打开失败") ;
//    }
//    if (operateType1 == 0)//如果是添加就留在该页，如果是修改就跳回上一页
//    {
//        [_nameTextField resignFirstResponder];
//        [_ageTextField resignFirstResponder];
//        [_IDTextField resignFirstResponder];
//        _nameTextField.text = @"";
//        _ageTextField.text = @"";
//        _IDTextField.text = @"";
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    [db close];
//}

@end
