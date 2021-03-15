//
//  ViewController.m
//  JYFormHelper
//
//  Created by JackYoung on 2021/1/31.
//

#import "ViewController.h"
#import "JYFormViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, kStatusBarHeight + kNavBarHeight, 100, 100)];
    [button addTarget:self action:@selector(onButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = UIColor.blueColor;
}

- (void)onButtonTouched {
//    [SVProgressHUD showSuccessWithStatus:@"JackYoung"];
//    return;
    JYFormViewController *viewController = [[JYFormViewController alloc] init];
    viewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:viewController animated:true completion:nil];
}


@end
