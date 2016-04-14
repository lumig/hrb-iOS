//
//  NSDictionary+LifeExtension.h
//  iosApp
//
//  Created by admin on 15/1/15.
//  Copyright (c) 2015年 lifevc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LifeExtension)

- (NSString *) toJSONDescription;

-(NSString*) urlEncodedString;

@end
