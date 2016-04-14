//
//  NSDictionary+LifeExtension.m
//  iosApp
//
//  Created by admin on 15/1/15.
//  Copyright (c) 2015年 lifevc. All rights reserved.
//

#import "NSDictionary+LifeExtension.h"

static NSString *urlEncode(id object) {
    NSString *string = [NSString stringWithFormat:@"%@",object];
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation NSDictionary (LifeExtension)

- (NSString *) toJSONDescription{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

-(NSString*) urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in self) {
        id value = [self objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

@end
