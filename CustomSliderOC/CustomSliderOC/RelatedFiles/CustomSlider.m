//
//  CustomSlider.m
//  CustomSliderOC
//
//  Created by travelsky on 2018/4/13.
//  Copyright © 2018年 wangdicen. All rights reserved.
//

#import "CustomSlider.h"

@implementation CustomSlider
{
    float previousValue;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (id)slider
{
    CustomSlider *slider = [[CustomSlider alloc] initWithFrame:(CGRect){.size = {200.0f, 40.f}}];
    return slider;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        previousValue = CGFLOAT_MIN;
        self.value = 0.0f;
        
        [self setThumbImage:[self simpleThumb] forState:UIControlStateNormal];
        
//        [self addTarget:self action:@selector(startDrag:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(updateThumb) forControlEvents:UIControlEventValueChanged];
//        [self addTarget:self action:@selector(endDrag:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
    
    return self;
}

- (void)updateThumb
{
    if ((self.value < 0.98) && (ABS(self.value - previousValue) < 0.1f)) return;
    
    UIImage *customimg = [self thumbWithLevel:self.value];
    [self setThumbImage:customimg forState: UIControlStateHighlighted];
    previousValue = self.value;
}




-(UIImage *)thumbWithLevel:(float)alevel
{
    float INSET_AMT = 1.5f;
    CGRect baseRect = CGRectMake(0.f, 0.f, 40.f, 100.f);
    CGRect thumbRect = CGRectMake(0.f, 40.f, 40.f, 20.f);
    
    UIGraphicsBeginImageContext(baseRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor darkGrayColor] setFill];
    CGContextAddRect(context, CGRectInset(thumbRect, INSET_AMT, INSET_AMT));
    CGContextFillPath(context);
    
    [[UIColor whiteColor] setStroke];
    CGContextSetLineWidth(context, 2.0f);
    CGContextAddRect(context, CGRectInset(thumbRect, 2.0f * INSET_AMT, 2.0f * INSET_AMT));
    CGContextStrokePath(context);
    
    CGRect ellipseRect = CGRectMake(0.0, 0.0f, 40.0f, 40.f);
    [[UIColor colorWithWhite:alevel alpha:1.0f] setFill];
    CGContextAddEllipseInRect(context, ellipseRect);
    CGContextFillPath(context);
    
    NSString *numstring = [NSString stringWithFormat:@"%0.1f",alevel];
    UIColor *textColor = (alevel > 0.5) ? [UIColor blackColor]: [UIColor whiteColor];
    UIFont *font = [UIFont fontWithName:@"Georgia" size:20.f];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attr = @{NSFontAttributeName:font,
                           NSParagraphStyleAttributeName:style,
                           NSForegroundColorAttributeName:textColor
                           };
    [numstring drawInRect:CGRectInset(ellipseRect, 0.0f, 6.0f) withAttributes:attr];
    
    
    [[UIColor grayColor] setStroke];
    CGContextSetLineWidth(context, 3.0f);
    CGContextAddEllipseInRect(context, CGRectInset(ellipseRect, 2.0f, 2.0f));
    CGContextStrokePath(context);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

- (UIImage *)simpleThumb
{
    float INSET_AMT = 1.5f;
    CGRect baseRect = CGRectMake(0.0f, 0.0f, 40.0f, 100.0f);
    CGRect thumbRect = CGRectMake(0.0f, 40.0f, 40.0f, 20.0f);
    
    UIGraphicsBeginImageContext(baseRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Create a filled rect for the thumb
    [[UIColor darkGrayColor] setFill];
    CGContextAddRect(context, CGRectInset(thumbRect, INSET_AMT, INSET_AMT));
    CGContextFillPath(context);
    
    // Outline the thumb
    [[UIColor whiteColor] setStroke];
    CGContextSetLineWidth(context, 2.0f);
    CGContextAddRect(context, CGRectInset(thumbRect, 2.0f * INSET_AMT, 2.0f * INSET_AMT));
    CGContextStrokePath(context);
    
    // Retrieve the thumb
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;

}


@end
