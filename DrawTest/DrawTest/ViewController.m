//
//  ViewController.m
//  DrawTest
//
//  Created by Mike on 2016/12/30.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "CGDrawView.h"
#import "UIView+EffectiveCorner.h"

#import "PQWipeView.h"
#import "UIImage+PQImage.h"
@interface ViewController ()
{
    UIImage *_image;
}
@property (nonatomic,strong) PQWipeView * wipeView;
@property (nonatomic,strong) UIImageView * imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DrawView *view = [[DrawView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    view.backgroundColor = [UIColor grayColor];
    [view addcornerWithRadius:50];
    [self.view addSubview:view];
    
//    CGDrawView *view = [[CGDrawView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
//    view.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:view];
    
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.view.backgroundColor = [UIColor whiteColor];
//    //添加一个右按钮
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定裁剪" style:UIBarButtonItemStylePlain target:self action:@selector(cutFinish)];
//    
//    _image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back.jpg" ofType:nil]];
//    //添加一个背景图片
//    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
//    imgView.image = _image;
//    [self.view addSubview:imgView];
//    self.imgView = imgView;
//    self.imgView.userInteractionEnabled = YES;
//    
//    _wipeView = [[[NSBundle mainBundle]loadNibNamed:@"PQWipeView" owner:self options:nil] firstObject];
//    [self.imgView addSubview:_wipeView];
}
- (void)cutFinish{
    
    [UIImage pq_cutScreenWithView:self.imgView cutFrame:self.wipeView.frame successBlock:^(UIImage * _Nullable image, NSData * _Nullable imagedata) {
        if (image) {
            NSLog(@"截取成功");
            NSString * path = [NSString stringWithFormat:@"%@/Documents/cutSome.jpg",NSHomeDirectory()];
            
            if( [imagedata writeToFile:path atomically:YES]){
                NSLog(@"保存成功%@",path);
            }
            
            self.imgView.hidden = YES;
            
            UIImageView *imagev = [[UIImageView alloc]initWithImage:image];
            imagev.frame = CGRectMake(0, 64, image.size.width, image.size.height);
            [self.view addSubview:imagev];
        }
    }];
    
}




@end
