//
//  CountDownBar.h
//  CountDownBar
//
//  Created by jpz on 2019/4/20.
//  Copyright © 2019 jpz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^touchBlock)(void);

@interface CountDownBar : UIView

/**
 倒计时时间
 */
@property(nonatomic,assign)CGFloat time;
@property (nonatomic, copy) touchBlock touchBlock;
- (void)startAnimation;
@end

NS_ASSUME_NONNULL_END
