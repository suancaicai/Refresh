//
//  MMCircleView.m
//  CatRefresh
//
//  Created by yumingming on 16/2/17.
//  Copyright © 2016年 MM. All rights reserved.
//

#import "MMCircleView.h"

@implementation MMCircleView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;

}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



-(void)setProgress:(double)progress{
    if (progress >= 1) {
        progress = 1;
    }
    _progress = progress;

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code


    CGContextRef content = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(content, 0.7);
    CGContextSetLineCap(content, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(content, [UIColor redColor].CGColor);


    CGFloat starAngle = M_PI * 1.5;
    CGFloat step = - M_PI * self.progress;

    CGSize size = self.bounds.size;
    CGContextAddArc(content, size.width/2, size.height/2, size.width/2 - 2, starAngle, starAngle + step, 1);
    CGContextStrokePath(content);

    CGContextAddArc(content, size.width/2, size.height/2, size.width/2 - 2, starAngle, starAngle - step, 0);
    CGContextStrokePath(content);


    


    CGContextSetLineWidth(content, 3.0);
    CGContextSetLineCap(content, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(content, [UIColor whiteColor].CGColor);

    CGContextMoveToPoint(content, 0, 0);
    CGContextAddLineToPoint(content,self.frame.size.width,self.frame.size.height);
    CGContextStrokePath(content);
    CGContextMoveToPoint(content, 0, self.frame.size.height);
    CGContextAddLineToPoint(content,self.frame.size.width,0);
    CGContextStrokePath(content);
}

@end
