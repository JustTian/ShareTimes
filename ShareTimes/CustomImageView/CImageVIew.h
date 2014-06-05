//
//  CImageVIew.h
//  FirstProject
//
//  Created by 传晟 on 14-5-6.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CImageVIew : UIImageView
+(CImageVIew *)loadCustomLabelFromMode:(NSDictionary *)dictionary;

-(void)setImageWithURL:(NSURL *)url;
@end
