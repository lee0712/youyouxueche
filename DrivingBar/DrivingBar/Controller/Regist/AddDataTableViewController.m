//
//  MyPageTableViewController.m
//  DrivingBar
//
//  Created by admin on 15/12/2.
//  Copyright © 2015年 admin. All rights reserved.
//
#import "public.h"
#import "Util.h"
#import "UIImageView+WebCache.h"
#import "UIColor+HEX.h"
#import "NJImageCropperViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AddDataTableViewController.h"
#import "NickNameViewController.h"
#import "TrainerTableViewController.h"
#import "TLCityPickerController.h"
#import "SignViewController.h"
#import "AFNetworking.h"
#import "MenuViewController.h"

#define ORIGINAL_MAX_WIDTH 640.0f
//actionsheet编号
#define ACTIONSHEET_PORTRAIT 1
#define ACTIONSHEET_SEX 2

@interface AddDataTableViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,NJImageCropperDelegate,TLCityPickerDelegate>{
    UIImageView *userImageView;
    NSString *nickName;
    NSString *sex;
    NSString *region;
    NSString *teacher;
    NSString *sign;
    long g_bit_len;
}
@property (nonatomic, strong) NSMutableArray *tableDataSource;

@end

@implementation AddDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self setHeadView];
    [self setFootView];
    
    self.tableDataSource = [[NSMutableArray alloc]init];
    [self.tableDataSource addObject:@"头像"];
    [self.tableDataSource addObject:@"昵称"];
    [self.tableDataSource addObject:@"性别"];
    [self.tableDataSource addObject:@"地区"];
    [self.tableDataSource addObject:@"教练"];
    [self.tableDataSource addObject:@"签名"];
    
    self.tableView.scrollEnabled = NO;
    [self getData];
    [self.tableView reloadData];
}

-(void)getData{
    
    userImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"default_user_im"]];
    nickName = @"";
    sex = @"";
    region = @"";
    teacher = @"";
    sign = @"";
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"GetUserForm" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"sessionId"];
    [parameters setObject:g_userId forKey:@"User_Id"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        
        if ([[revDic objectForKey:@"result"] intValue] != 1) {
            NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
            return;
        }else{
            NSDictionary *userDic = [revDic objectForKey:@"userinfoform"];
            
            if (![[userDic objectForKey:@"photo"]isEqual: [NSNull null]]) {
                NSString *tmpUrl = [userDic objectForKey:@"photo"];
                NSString *nsUrl = [[NSString alloc]initWithFormat:@"%@%@",HTTP_IMG_URL_NSSTRING,tmpUrl];
                NSURL *imUrl = [[NSURL alloc]initWithString:nsUrl];
                g_userImUrl = imUrl;
                [userImageView sd_setImageWithURL:imUrl];
            }
            
            if (![[userDic objectForKey:@"nickName"]isEqual: [NSNull null]]) {
                nickName = [userDic objectForKey:@"nickName"];
            }
            if (![[userDic objectForKey:@"cityName"]isEqual: [NSNull null]]) {
                region = [userDic objectForKey:@"cityName"];
            }
            if (![[userDic objectForKey:@"sex"]isEqual: [NSNull null]]) {
                sex = [userDic objectForKey:@"sex"];
            }
            if (![[userDic objectForKey:@"tranerName"]isEqual: [NSNull null]]) {
                teacher = [userDic objectForKey:@"tranerName"];
            }
            if (![[userDic objectForKey:@"signName"]isEqual: [NSNull null]]) {
                sign = [userDic objectForKey:@"signName"];
            }
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];

}

-(void)initNavi {
    self.view.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = NSLocalizedString(@"个人资料", nil);
    titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    //left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(screen_width-70, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height/4, BACK_IM_WIDTH, self.navigationController.navigationBar.frame.size.height/2)];
    [leftButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_im"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}
//设置头部
- (void)setHeadView {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 10)];
    headView.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
    self.tableView.tableHeaderView = headView;
}
//设置尾部
- (void)setFootView {
   
    if (self.ifFirst || UI_DEBUG_NO_NETWORK) {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 70)];
        footView.backgroundColor = RGB_BACKGROUND_COLOR_GRAY;
        //login button
        UIButton *loginBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [loginBt.layer setCornerRadius:5.0f];
        loginBt.frame = CGRectMake(25, 10, screen_width - 50, 50);
        loginBt.backgroundColor = [UIColor colorWithRGBHEX:BACKGROUND_COLOR_BLUE alpha:1.0f];
        [loginBt setTitle:NSLocalizedString(@"进入优优", nil) forState:UIControlStateNormal];
        [loginBt addTarget:self action:@selector(getIn:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:loginBt];
        self.tableView.tableFooterView = footView;
    }else {
        self.tableView.tableFooterView = [[UIView alloc]init];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TopAPs";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *title = [self.tableDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    
    switch (indexPath.row) {
        case 0:{
            cell.accessoryView = userImageView;
            [cell.accessoryView.layer setCornerRadius:CGRectGetHeight([cell.accessoryView bounds]) / 2];
            cell.accessoryView.layer.masksToBounds = YES;
            break;
        }
        case 1:{
            cell.detailTextLabel.text = nickName;
            break;
        }
        case 2:{
            cell.detailTextLabel.text = sex;
            break;
        }
        case 3:{
            cell.detailTextLabel.text = region;
            break;
        }
        case 4:{
            cell.detailTextLabel.text = teacher;
            break;
        }
        case 5:{
            cell.detailTextLabel.text = sign;
            break;
        }
        default:
            break;
    }
    
    //    cell.imageView.image = [UIImage imageNamed:[self.tableDataImname objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
          //  [self editPortrait];
            [self takePictureClick];
            break;
        }
            //昵称
        case 1:{
            NickNameViewController *nextVC = [[NickNameViewController alloc] init];
            nextVC.nickName = nickName;
            nextVC.delegate = self;
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
            //性别
        case 2:{
            [self editSex];
            break;
        }
            //城市
        case 3:{
            TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
            [cityPickerVC setDelegate:self];
            //默认显示广州市，启动gps后更新此数据
            cityPickerVC.locationCityID = @"300110000";
            //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
            cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
            
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
                
            }];
            break;
        }
        case 4:{
            TrainerTableViewController *nextVC = [[TrainerTableViewController alloc] init];
            nextVC.delegate = self;
            NSLog(@"here");
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 5:{
            SignViewController *nextVC = [[SignViewController alloc] init];
            nextVC.delegate = self;
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        default:
            break;
    }
}

//从相册获取图片
-(void)takePictureClick
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择文件来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"本地相簿",nil];
    actionSheet.tag = ACTIONSHEET_PORTRAIT;
    [actionSheet showInView:self.view];
    
}



- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    choiceSheet.tag = ACTIONSHEET_PORTRAIT;
    [choiceSheet showInView:self.view];
}
- (void)editSex{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"男", @"女", nil];
    choiceSheet.tag = ACTIONSHEET_SEX;
    [choiceSheet showInView:self.view];
}


#pragma mark actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (actionSheet.tag) {
        case ACTIONSHEET_PORTRAIT:{
            if (buttonIndex == 0) {
//                // 拍照
//                if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
//                    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//                    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
//                    if ([self isFrontCameraAvailable]) {
//                        controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//                    }
//                    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
//                    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
//                    controller.mediaTypes = mediaTypes;
//                    controller.delegate = self;
//                    [self presentViewController:controller
//                                       animated:YES
//                                     completion:^(void){
//                                         NSLog(@"Picker View Controller is presented");
//                                     }];
//                }
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePicker animated:YES completion:nil];
                
            } else if (buttonIndex == 1) {
//                // 从相册中选取
//                if ([self isPhotoLibraryAvailable]) {
//                    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//                    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
//                    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
//                    controller.mediaTypes = mediaTypes;
//                    controller.delegate = self;
//                    [self presentViewController:controller
//                                       animated:YES
//                                     completion:^(void){
//                                         NSLog(@"Picker View Controller is presented");
//                                     }];
//                }
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }

            break;
        }
        case ACTIONSHEET_SEX:{
            if (buttonIndex == 0) {
                sex = @"男";
            } else if (buttonIndex == 1) {
                sex = @"女";
            }
            
            AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
            
            NSString *url = HTTP_POST_URL_NSSTRING;
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:@"UpdateUserSex" forKey:@"cmd"];
            [parameters setObject:g_sessionId forKey:@"sessionId"];
            [parameters setObject:g_userId forKey:@"User_Id"];
            [parameters setObject:sex forKey:@"Sex"];
            NSLog(@"url:%@",url);
            NSLog(@"parameters:%@",parameters);
            [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"https post ok,object:%@",responseObject);
                NSDictionary *revDic = (NSDictionary*)responseObject;
                
                if ([[revDic objectForKey:@"result"] intValue] != 1) {
                    NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
                    return;
                }else{
                
                    [self.tableView reloadData];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"https post fail, error: %@",error);
            }];
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - TLCityPickerDelegate
//选择城市回调
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{

    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"UpdateLocation" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"sessionId"];
    [parameters setObject:g_userId forKey:@"User_Id"];
    [parameters setObject:city.cityName forKey:@"City_Name"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        
        if ([[revDic objectForKey:@"result"] intValue] != 1) {
            NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
            return;
        }else{
            region = city.cityName;
            [self.tableView reloadData];
            
           // [MenuViewController getData];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:region forKey:@"city"];
            [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
    
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)finish:(id)sender {
    NSLog(@"adddata finish");
    [self dismissViewControllerAnimated:YES completion:nil];
}
//进入优优
-(void)getIn:(id)sender {
   
    UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *mainViewController = [mainstoryboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self presentViewController:mainViewController animated:YES completion:nil];

}
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(NJImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
 
    
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    loginManager.requestSerializer = [AFHTTPRequestSerializer serializer];
   // loginManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //loginManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSLog(@"上传图片");
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"UpdateUserPhoto" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"SessionId"];
    [parameters setObject:g_userId forKey:@"User_Id"];
    
  
    float imhight = 100.0f;
    float imwidth = 100.0f;
    NSString *encodedImageStr;
    UIImage *newEditedImage;
    do {
        NSLog(@"imhight----%f",imwidth);
        imhight = imhight*0.95;
        imwidth = imwidth*0.95;
        newEditedImage = [self OriginImage: editedImage scaleToSize:CGSizeMake(imwidth, imhight)];

        const char *imbitmap = (const char*)[self convertUIImageToBitmapRGBA8:newEditedImage];
        //    NSLog(@"---imbit --%s",imbitmap);
        //    char *a="abc";
        //    NSString *tpstr = [NSString stringWithCString:imbitmap];
        //    NSLog(@"----tpstr---%@",tpstr);
        //    NSData *data = [tpstr dataUsingEncoding:NSUTF8StringEncoding];
        //
        //  NSData *data = [NSData dataWithBytes:imbitmap length:g_bit_len];
        NSData *data=UIImagePNGRepresentation(newEditedImage);
       // NSLog(@"data-----%@",data);
        //NSData *data = UIImageJPEGRepresentation(editedImage, 1.0f);
        encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }while (encodedImageStr.length >6000);
   
   // NSLog(@"imstr---%@",encodedImageStr);
//    NSData *imageData = UIImageJPEGRepresentation(editedImage, 1);
//    NSData *imagebase64Data = [imageData base64EncodedDataWithOptions:0];

    [parameters setObject:encodedImageStr forKey:@"Photo"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@", str];
    
    [parameters setObject:fileName forKey:@"filename"];
    NSLog(@"begin");
    
    
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:");
        //NSString *revOb =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        
        if ([[revDic objectForKey:@"result"] intValue] != 1) {
            //NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
            return;
        }else{
            userImageView.image = newEditedImage;
            
            //[MenuViewController getData];
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];

    
   
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(NJImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [picker dismissViewControllerAnimated:YES completion:^() {
//        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//        portraitImg = [self imageByScalingToMaxSize:portraitImg];
//        // 裁剪
//        NJImageCropperViewController *imgEditorVC = [[NJImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
//        imgEditorVC.delegate = self;
//        [self presentViewController:imgEditorVC animated:YES completion:^{
//            // TO DO
//        }];
//    }];
//}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    
 
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)saveImage:(UIImage *)image {
    //    NSLog(@"保存头像！");
    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    //    [userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
   //userImageView.image = selfPhoto;
    
    
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    loginManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // loginManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //loginManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSLog(@"上传图片");
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"UpdateUserPhoto" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"SessionId"];
    [parameters setObject:g_userId forKey:@"User_Id"];
    
    float imhight = 100.0f;
    float imwidth = 100.0f;
    NSString *encodedImageStr;
    UIImage *newEditedImage;
    do {
        NSLog(@"imhight----%f",imwidth);
        imhight = imhight*0.95;
        imwidth = imwidth*0.95;
        newEditedImage = [self OriginImage: selfPhoto scaleToSize:CGSizeMake(imwidth, imhight)];
        
        const char *imbitmap = (const char*)[self convertUIImageToBitmapRGBA8:newEditedImage];
        //    NSLog(@"---imbit --%s",imbitmap);
        //    char *a="abc";
        //    NSString *tpstr = [NSString stringWithCString:imbitmap];
        //    NSLog(@"----tpstr---%@",tpstr);
        //    NSData *data = [tpstr dataUsingEncoding:NSUTF8StringEncoding];
        //
        //  NSData *data = [NSData dataWithBytes:imbitmap length:g_bit_len];
        NSData *data=UIImagePNGRepresentation(newEditedImage);
        // NSLog(@"data-----%@",data);
        //NSData *data = UIImageJPEGRepresentation(editedImage, 1.0f);
        encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }while (encodedImageStr.length >6000);
    
    // NSLog(@"imstr---%@",encodedImageStr);
    //    NSData *imageData = UIImageJPEGRepresentation(editedImage, 1);
    //    NSData *imagebase64Data = [imageData base64EncodedDataWithOptions:0];
    
    [parameters setObject:encodedImageStr forKey:@"Photo"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@", str];
    
    [parameters setObject:fileName forKey:@"filename"];
    NSLog(@"begin");
 
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:");
        //NSString *revOb =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        
        if ([[revDic objectForKey:@"result"] intValue] != 1) {
            //NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
            return;
        }else{
            userImageView.image = newEditedImage;
            
           // [MenuViewController getData];
            [self.tableView reloadData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_MENU"
                                                                object:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
    
 
    
}
//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissViewControllerAnimated:YES completion:^(){
//    }];
//}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

//pass value delegate
-(void)passNickName:(NSString*)value {
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"UpdateUserNick_Name" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"sessionId"];
    [parameters setObject:g_userId forKey:@"User_Id"];
     [parameters setObject:value forKey:@"Nick_Name"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        
        if ([[revDic objectForKey:@"result"] intValue] != 1) {
            NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
            return;
        }else{
            nickName = value;
            
           // [MenuViewController getData];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_MENU"
                                                                object:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
    
    
}
//trainer value delegate
-(void)passTrainer:(NSString*)value {
    
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"UpdateTranerer" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"sessionId"];
    [parameters setObject:g_userId forKey:@"User_Id"];
    [parameters setObject:value forKey:@"TranerName"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        
        if ([[revDic objectForKey:@"result"] intValue] != 1) {
            NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
            return;
        }else{
            
            teacher = value;
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
    
   
}
//sign value delegate
-(void)passSign:(NSString*)value {
    
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc]init];
    
    NSString *url = HTTP_POST_URL_NSSTRING;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"UpdateUserSign_Name" forKey:@"cmd"];
    [parameters setObject:g_sessionId forKey:@"sessionId"];
    [parameters setObject:g_userId forKey:@"User_Id"];
    [parameters setObject:value forKey:@"Sign_Name"];
    NSLog(@"url:%@",url);
    NSLog(@"parameters:%@",parameters);
    [loginManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"https post ok,object:%@",responseObject);
        NSDictionary *revDic = (NSDictionary*)responseObject;
        
        if ([[revDic objectForKey:@"result"] intValue] != 1) {
            NSLog(@"set failed,msg:%@",[revDic objectForKey:@"msg"]);
            return;
        }else{
            
            sign = value;
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"https post fail, error: %@",error);
    }];
}

- (BOOL) imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}
- (NSString *) image2DataURL: (UIImage *) image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 1.0f);
        mimeType = @"image/jpeg";
    }
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: 0]];  
}
//缩小图片
-(UIImage*)  OriginImage:(UIImage *)image   scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;  
}
- (NSString *)HTTPBodyWithParameters:(NSDictionary *)parameters
{
    NSMutableArray *parametersArray = [[NSMutableArray alloc]init];
    
    for (NSString *key in [parameters allKeys]) {
        id value = [parameters objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [parametersArray addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
        }
        
    }
    
    return [parametersArray componentsJoinedByString:@"&"];
}

- (unsigned char *) convertUIImageToBitmapRGBA8:(UIImage *) image {
    
    CGImageRef imageRef = image.CGImage;
    
    // Create a bitmap context to draw the uiimage into
    CGContextRef context = [self newBitmapRGBA8ContextFromImage:imageRef];
    
    if(!context) {
        return NULL;
    }
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // Draw image into the context to get the raw image data
    CGContextDrawImage(context, rect, imageRef);
    
    // Get a pointer to the data
    unsigned char *bitmapData = (unsigned char *)CGBitmapContextGetData(context);
    
    // Copy the data and release the memory (return memory allocated with new)
    size_t bytesPerRow = CGBitmapContextGetBytesPerRow(context);
    size_t bufferLength = bytesPerRow * height;
    g_bit_len = bufferLength;
    unsigned char *newBitmap = NULL;
    
    if(bitmapData) {
        newBitmap = (unsigned char *)malloc(sizeof(unsigned char) * bytesPerRow * height);
        
        if(newBitmap) {    // Copy the data
            for(int i = 0; i < bufferLength; ++i) {
                newBitmap[i] = bitmapData[i];
            }
        }
        
        free(bitmapData);
        
    } else {
        NSLog(@"Error getting bitmap pixel data\n");
    }
    
    CGContextRelease(context);
    //NSLog(@"+++++bitmap %s",newBitmap);
    return newBitmap;
}
- (CGContextRef) newBitmapRGBA8ContextFromImage:(CGImageRef) image {
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    uint32_t *bitmapData;
    
    size_t bitsPerPixel = 32;
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = bitsPerPixel / bitsPerComponent;
    
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    
    size_t bytesPerRow = width * bytesPerPixel;
    size_t bufferLength = bytesPerRow * height;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if(!colorSpace) {
        NSLog(@"Error allocating color space RGB\n");
        return NULL;
    }
    
    // Allocate memory for image data
    bitmapData = (uint32_t *)malloc(bufferLength);
    
    if(!bitmapData) {
        NSLog(@"Error allocating memory for bitmap\n");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }
    
    //Create bitmap context
    
    context = CGBitmapContextCreate(bitmapData,
                                    width,
                                    height,
                                    bitsPerComponent,
                                    bytesPerRow,
                                    colorSpace,
                                    kCGImageAlphaPremultipliedLast);    // RGBA
    if(!context) {
        free(bitmapData);
        NSLog(@"Bitmap context not created");
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

- (UIImage *) convertBitmapRGBA8ToUIImage:(unsigned char *) buffer
                                withWidth:(int) width
                               withHeight:(int) height {
    
    
    size_t bufferLength = width * height * 4;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer, bufferLength, NULL);
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = 4 * width;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    if(colorSpaceRef == NULL) {
        NSLog(@"Error allocating color space");
        CGDataProviderRelease(provider);
        return nil;
    }
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    CGImageRef iref = CGImageCreate(width,
                                    height,
                                    bitsPerComponent,
                                    bitsPerPixel,
                                    bytesPerRow,
                                    colorSpaceRef,
                                    bitmapInfo,
                                    provider,    // data provider
                                    NULL,        // decode
                                    YES,            // should interpolate
                                    renderingIntent);
    
    uint32_t* pixels = (uint32_t*)malloc(bufferLength);
    
    if(pixels == NULL) {
        NSLog(@"Error: Memory not allocated for bitmap");
        CGDataProviderRelease(provider);
        CGColorSpaceRelease(colorSpaceRef);
        CGImageRelease(iref);
        return nil;
    }
    
    CGContextRef context = CGBitmapContextCreate(pixels,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpaceRef,
                                                 bitmapInfo);
    
    if(context == NULL) {
        NSLog(@"Error context not created");
        free(pixels);
    }
    
    UIImage *image = nil;
    if(context) {
        
        CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), iref);
        
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        
        // Support both iPad 3.2 and iPhone 4 Retina displays with the correct scale
        if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
            float scale = [[UIScreen mainScreen] scale];
            image = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
        } else {
            image = [UIImage imageWithCGImage:imageRef];
        }
        
        CGImageRelease(imageRef);
        CGContextRelease(context);
    }
    
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(iref);
    CGDataProviderRelease(provider);
    
    if(pixels) {
        free(pixels);
    }
    return image;
}
@end
