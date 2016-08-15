//
//  ViewController.m
//  AnimatedShowLabel
//
//  Created by Cobb on 16/6/22.
//  Copyright © 2016年 Cobb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/**
 * 发送礼物combo连击数
 */
@property (nonatomic,readwrite,strong) UILabel *giftComboLabel;

@property (nonatomic,readwrite,strong) NSTimer *displayTimer;//用于显示礼物动画视图的timer

@property (nonatomic,readwrite,assign) NSInteger upComboNumber;//当前显示的上方视图combo的数值

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.giftComboLabel = ({
        _giftComboLabel = [[UILabel alloc]init];
        _giftComboLabel.backgroundColor = [UIColor clearColor];
        _giftComboLabel.textAlignment = NSTextAlignmentCenter;
        _giftComboLabel.numberOfLines = 1;
        _giftComboLabel;
    });//发送礼物combo连击数
    
    self.giftComboLabel.frame = CGRectMake(120, 100, 75, 30);
    [self.view addSubview:self.giftComboLabel];

    self.displayTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(dislplayGiftViews) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.displayTimer forMode:NSRunLoopCommonModes];
}

#pragma mark - 轮询显示消息
/**
 * @brief 定时轮询礼物消息池子
 */
- (void)dislplayGiftViews
{
    if (self.upComboNumber == 40) {
        self.upComboNumber = 0;
    }
    self.upComboNumber++;
    [self animatedShowComboNumber:self.upComboNumber+1 Completion:^(){
//        [self removeUpOrDownView:YES];//移除
    }];
}


/**
 * @brief 设置combo的数目
 */
- (void)setComboNumber:(NSString *)text
{
    self.giftComboLabel.attributedText = [[NSAttributedString alloc]
                                          initWithString:text
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:35],
                                                       NSStrokeWidthAttributeName: @-3.0,
                                                       NSStrokeColorAttributeName:[UIColor colorWithRed:220.0/255 green:227.0/255 blue:94.0/255 alpha:1.0f],
                                                       NSForegroundColorAttributeName:[UIColor colorWithRed:58.0/255 green:200.0/255 blue:205.0/255 alpha:1.0f]
                                                       }];
}

/**
 * @brief 动画设置combo
 */
- (void)animatedShowComboNumber:(NSInteger)number Completion:(void (^)(void))comletion
{
    [self setComboNumber:[NSString stringWithFormat:@"X %ld",(long)number]];
    
    //    //弹簧缩放动画
    //    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.35 initialSpringVelocity:1.0 / 0.85 options:UIViewAnimationOptionCurveEaseIn animations:^{
    //        self.giftComboLabel.transform = CGAffineTransformScale(self.giftComboLabel.transform,2.0f, 2.0f);
    //    } completion:^(BOOL finished) {
    //        [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.35 initialSpringVelocity:1.0 / 0.85 options:UIViewAnimationOptionCurveEaseOut animations:^{
    //            self.giftComboLabel.transform = CGAffineTransformScale(self.giftComboLabel.transform,1/2.0f, 1/2.0f);
    //        } completion:^(BOOL finished) {
    //            if (comletion){
    //                comletion();
    //            }
    //        }];
    //    }];
    
    //弹簧缩放动画
    self.giftComboLabel.transform = CGAffineTransformMakeScale(6.0, 6.0);
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.giftComboLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        if (comletion){
            comletion();
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
