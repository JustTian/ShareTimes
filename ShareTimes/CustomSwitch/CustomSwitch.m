//
//  CustomSwitch.m
//  shiyan3
//
//  Created by 传晟 on 14-4-8.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomSwitch.h"
#import <QuartzCore/QuartzCore.h>
#import "SwitchOfMapper.h"

@interface CustomSwitch(){
    UIView *backGround;
    UIView *knob;
    UIImageView *onImageView;
    UIImageView *offImageView;
    double startTime;
    BOOL isAnimating;
    
}
-(void)showOn:(BOOL)animated;
-(void)showOff:(BOOL)animated;
-(void)customSetup;
@end

@implementation CustomSwitch

@synthesize inactiveColor, activeColor, onColor, borderColor, knobColor, shadowColor;
@synthesize onImage, offImage;
@synthesize isRounded;
@synthesize on;

+(CustomSwitch *)loadCustomLabelFromMode:(NSDictionary *)dictionary{
    SwitchOfMapper *switchMapper = [[SwitchOfMapper alloc]initWithDictionary:dictionary];
    
    CustomSwitch *wSwitch = [[CustomSwitch alloc]init];
    CGRect frameRect = [wSwitch rectFromModelJSON:switchMapper];
    wSwitch.frame = frameRect;
    
    wSwitch.on = [wSwitch boolFromJSON:[switchMapper.isOn integerValue]];
    
    wSwitch.isRounded = [wSwitch boolFromJSON:[switchMapper.isRound integerValue]];
    
    wSwitch.borderColor = [wSwitch colorFromJSONnum:[switchMapper.borderColor integerValue]];
    
    wSwitch.inactiveColor = [wSwitch colorFromJSONnum:[switchMapper.inactiveColor integerValue]];
    
    wSwitch.activeColor = [wSwitch colorFromJSONnum:[switchMapper.activeColor integerValue]];
    
    wSwitch.onColor = [wSwitch colorFromJSONnum:[switchMapper.onColor integerValue]];
    
    wSwitch.shadowColor = [wSwitch colorFromJSONnum:[switchMapper.shadowColor integerValue]];
    
    if ([wSwitch boolFromJSON:[switchMapper.isImage integerValue]]) {
        wSwitch.onImage = [wSwitch imageFromJSON:switchMapper.onImage];
        wSwitch.offImage = [wSwitch imageFromJSON:switchMapper.offImage];
    
    }
    
    wSwitch.tag = [switchMapper.tag integerValue];
    
    return wSwitch;
}

-(id)init{
    self = [super initWithFrame:CGRectMake(0, 0, 50, 30)];
    if (self) {
        [self customSetup];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customSetup];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    CGRect initFrame;
    if (CGRectIsEmpty(frame)) {
        initFrame  = CGRectMake(0, 0, 50, 30);
    }else{
        initFrame  = frame;
    }
    self = [super initWithFrame:initFrame];
    if (self) {
        [self customSetup];
    }
    return self;
}

-(void)customSetup{
    self.on = NO;
    self.isRounded = YES;
    self.inactiveColor = [UIColor clearColor];
    self.activeColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1];
    self.onColor = [UIColor colorWithRed:0.30f green:0.85f blue:0.39f alpha:1];
    self.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.91f alpha:1];
    self.knobColor = [UIColor whiteColor];
    self.shadowColor = [UIColor grayColor];
    
    backGround =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backGround.backgroundColor = [UIColor clearColor];
    backGround.layer.cornerRadius = self.frame.size.height * 0.5;
    backGround.layer.borderColor = [self.borderColor CGColor];
    backGround.layer.borderWidth = 1.1;
    backGround.userInteractionEnabled = NO;
    [self addSubview:backGround];
    
    onImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    onImageView.alpha = 0;
    onImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:onImageView];
    
    offImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    offImageView.alpha = 1.0;
    offImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:offImageView];
    
    knob = [[UIView alloc]initWithFrame:CGRectMake(1.1, 1.1, self.frame.size.height-2.2, self.frame.size.height-2.2)];
    knob.backgroundColor = self.knobColor;
    knob.layer.cornerRadius = self.frame.size.height *0.5 - 1;
    knob.layer.shadowColor = [self.shadowColor CGColor];
    knob.layer.shadowRadius = 1.0;
    knob.layer.shadowOpacity = 0.5;
    knob.layer.shadowOffset = CGSizeMake(0, 1);
    knob.layer.masksToBounds = NO;
    knob.userInteractionEnabled = NO;
    [self addSubview:knob];
    
    isAnimating = NO;
}

#pragma mark touchMethords
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    startTime = [[NSDate date]timeIntervalSince1970];
    CGFloat activeKnobWidth = self.bounds.size.height + 3;
    isAnimating = YES;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
        if (self.on) {
            knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth +1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            backGround.backgroundColor= self.onColor;
        }else{
            knob.frame = CGRectMake(knob.frame.origin.x,knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            backGround.backgroundColor = self.activeColor;
        }
    } completion:^(BOOL finished){
        isAnimating = NO;
    }];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint lastPint = [touch locationInView:self];
    if (lastPint.x > self.bounds.size.width * 0.5) {
        [self showOn:YES];
    }else{
        [self showOff:YES];
    }
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    double endTime = [[NSDate date] timeIntervalSince1970];
    double diffrence = endTime - startTime;
    BOOL previousValue = self.on;
    
    if (diffrence <= 0.2) {
        CGFloat normalKnobWidth = self.bounds.size.height - 2;
        knob.frame = CGRectMake(knob.frame.origin.x, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
        [self setOn:!self.on animated:YES];
    }else{
        CGPoint lastPoint = [touch locationInView:self];
        if (lastPoint.x > self.bounds.size.width * 0.5) {
            [self setOn:YES animated:YES];
        }else{
            [self setOn:NO animated:YES];
        }
    }
    if (previousValue !=self.on) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    if (self.on)
        [self showOn:YES];
    else
        [self showOff:YES];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!isAnimating) {
        CGRect frame = self.frame;
        
        // background
        backGround.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        backGround.layer.cornerRadius = self.isRounded ? frame.size.height * 0.5 : 2;
        
        // images
        onImageView.frame = CGRectMake(0, 0, frame.size.width - frame.size.height, frame.size.height);
        offImageView.frame = CGRectMake(frame.size.height, 0, frame.size.width - frame.size.height, frame.size.height);
        
        // knob
        CGFloat normalKnobWidth = frame.size.height - 2;
        if (self.on)
            knob.frame = CGRectMake(frame.size.width - (normalKnobWidth + 1), 1, frame.size.height - 2, normalKnobWidth);
        else
            knob.frame = CGRectMake(1, 1, normalKnobWidth, normalKnobWidth);
        
        knob.layer.cornerRadius = self.isRounded ? (frame.size.height * 0.5) - 1 : 2;
    }
}

#pragma mark Setters
- (void)setInactiveColor:(UIColor *)color {
    inactiveColor = color;
    if (!self.on && !self.isTracking)
        backGround.backgroundColor = color;
}
- (void)setOnColor:(UIColor *)color {
    onColor = color;
    if (on && !self.isTracking) {
        backGround.backgroundColor = color;
        backGround.layer.borderColor = color.CGColor;
    }
}


- (void)setBorderColor:(UIColor *)color {
    borderColor = color;
    if (!self.on)
        backGround.layer.borderColor = color.CGColor;
}


- (void)setKnobColor:(UIColor *)color {
    knobColor = color;
    knob.backgroundColor = color;
}


- (void)setShadowColor:(UIColor *)color {
    shadowColor = color;
    knob.layer.shadowColor = color.CGColor;
}


- (void)setOnImage:(UIImage *)image {
    onImage = image;
    onImageView.image = image;
}


- (void)setOffImage:(UIImage *)image {
    offImage = image;
    offImageView.image = image;
}


- (void)setIsRounded:(BOOL)rounded {
    isRounded = rounded;
    
    if (rounded) {
        backGround.layer.cornerRadius = self.frame.size.height * 0.5;
        knob.layer.cornerRadius = (self.frame.size.height * 0.5) - 1;
    }
    else {
        backGround.layer.cornerRadius = 2;
        knob.layer.cornerRadius = 2;
    }
}


- (void)setOn:(BOOL)isOn {
    [self setOn:isOn animated:NO];
}


- (void)setOn:(BOOL)isOn animated:(BOOL)animated {
    on = isOn;
    
    if (isOn) {
        [self showOn:animated];
    }
    else {
        [self showOff:animated];
    }
}


#pragma mark Getters

- (BOOL)isOn {
    return self.on;
}


#pragma mark State Changes


- (void)showOn:(BOOL)animated {
    CGFloat normalKnobWidth = self.bounds.size.height - 2;
    CGFloat activeKnobWidth = normalKnobWidth + 5;
    if (animated) {
        isAnimating = YES;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            if (self.tracking)
                knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            else
                knob.frame = CGRectMake(self.bounds.size.width - (normalKnobWidth + 1), knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
            backGround.backgroundColor = self.onColor;
            backGround.layer.borderColor = self.onColor.CGColor;
            onImageView.alpha = 1.0;
            offImageView.alpha = 0;
        } completion:^(BOOL finished) {
            isAnimating = NO;
        }];
    }
    else {
        if (self.tracking)
            knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
        else
            knob.frame = CGRectMake(self.bounds.size.width - (normalKnobWidth + 1), knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
        backGround.backgroundColor = self.onColor;
        backGround.layer.borderColor = self.onColor.CGColor;
        onImageView.alpha = 1.0;
        offImageView.alpha = 0;
    }
}


- (void)showOff:(BOOL)animated {
    CGFloat normalKnobWidth = self.bounds.size.height - 2;
    CGFloat activeKnobWidth = normalKnobWidth + 5;
    if (animated) {
        isAnimating = YES;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            if (self.tracking) {
                knob.frame = CGRectMake(1, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
                backGround.backgroundColor = self.activeColor;
            }
            else {
                knob.frame = CGRectMake(1, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
                backGround.backgroundColor = self.inactiveColor;
            }
            backGround.layer.borderColor = self.borderColor.CGColor;
            onImageView.alpha = 0;
            offImageView.alpha = 1.0;
        } completion:^(BOOL finished) {
            isAnimating = NO;
        }];
    }
    else {
        if (self.tracking) {
            knob.frame = CGRectMake(1, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            backGround.backgroundColor = self.activeColor;
        }
        else {
            knob.frame = CGRectMake(1, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
            backGround.backgroundColor = self.inactiveColor;
        }
        backGround.layer.borderColor = self.borderColor.CGColor;
        onImageView.alpha = 0;
        offImageView.alpha = 1.0;
    }
}

#pragma mark 辅助方法
-(CGRect)rectFromModelJSON:(SwitchOfMapper *)switchOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [switchOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [switchOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [switchOfMapper.widthOfRect floatValue];
    table_rect.size.height = [switchOfMapper.heightOfRect floatValue];
    return table_rect;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
