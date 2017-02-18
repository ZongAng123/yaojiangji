//
//  ViewController.m
//  摇奖机(点击抽奖)
//
//  Created by 纵昂 on 2017/2/18.
//  Copyright © 2017年 纵昂. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) UIButton * startButton;
@property (nonatomic, strong) UILabel * labelza1;
@property (nonatomic, strong) UILabel * labelza2;
@property (nonatomic, strong) UILabel * labelza3;
@end

@implementation ViewController
- (NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.labelza1=[[UILabel alloc]initWithFrame:CGRectMake(77, 111, 50, 41)];
    self.labelza2=[[UILabel alloc]initWithFrame:CGRectMake(167, 111, 50, 41)];
    self.labelza3=[[UILabel alloc]initWithFrame:CGRectMake(240, 111, 50, 41)];
    _labelza1.backgroundColor=[UIColor yellowColor];
     _labelza2.backgroundColor=[UIColor yellowColor];
     _labelza3.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:_labelza1];
    [self.view addSubview:_labelza2];
    [self.view addSubview:_labelza3];
    
    
    self.startButton =[[UIButton alloc]initWithFrame:CGRectMake(140, 204, 106, 50)];
    _startButton.backgroundColor =[UIColor redColor];
    [_startButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_startButton setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:_startButton];
    
}
-(void)login{
    
    if (self.queue.operationCount == 0) {
        [self.queue addOperationWithBlock:^{
            [self demo];
        }];
        self.queue.suspended = NO;
        [self.startButton setTitle:@"暂停" forState:UIControlStateNormal];
        
        
    }else if(!self.queue.isSuspended) {
        //如果是暂停，则改成继续
        self.queue.suspended = YES;
        [self.startButton setTitle:@"继续" forState:UIControlStateNormal];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%zd",self.queue.operationCount);
}

//
- (void)demo {
    while (!self.queue.isSuspended) {
        
        [NSThread sleepForTimeInterval:0.05];
        //产生随机数  [0,10)
        int number1 = arc4random_uniform(10);
        int number2 = arc4random_uniform(10);
        int number3 = arc4random_uniform(10);
        
        //回到主线程,更新Label
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.labelza1.text = [NSString stringWithFormat:@"%d",number1];
            self.labelza2.text = [NSString stringWithFormat:@"%d",number2];
            self.labelza3.text = [NSString stringWithFormat:@"%d",number3];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
