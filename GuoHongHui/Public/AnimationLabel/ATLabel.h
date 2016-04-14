//
//  ATLabel.h
//
// Created by Karthikeya Udupa on 7/14/13.
// Copyright (c) 2012 Karthikeya Udupa K M All rights reserved.



#import <UIKit/UIKit.h>

@interface ATLabel : UILabel {
    
}
@property(nonatomic,retain) NSArray *wordList;
@property(nonatomic,assign) double duration;

- (void)animateWithWords:(NSArray *)words forDuration:(double)time;
@end
