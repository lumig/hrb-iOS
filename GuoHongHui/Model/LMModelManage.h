//
//  LMModelManage.h
//  GuoHongHui
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "productModel.h"
#import "HuiRongBaoInfo.h"
#import "SignInModel.h"
#import "BuyDateModel.h"

typedef void (^SuccessBlock)(BOOL state,NSMutableArray *dataArray);
typedef void (^SuccessfulBlock)(BOOL state,NSMutableDictionary *dataDict);
typedef void (^FailureBlock)(BOOL state);

@interface LMModelManage : NSObject

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableDictionary *dataDict;

+(LMModelManage *)shareLLModelManage;

//待收益
- (void)getHoldingDataWithView:(UIView *)view idCard:(NSString *)idCard successBlock:(SuccessBlock)sucessBlock failureBlock:(FailureBlock)failureBlock;

//已收益
- (void)getHavingEarnedDataWithView:(UIView *)view idCard:(NSString *)idCard successBlock:(SuccessBlock)sucessBlock failureBlock:(FailureBlock)failureBlock;

- (void)getRecommandDataWithView:(UIView *)view sucessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;


//get signIn
- (void)getSignInDataWithView:(UIView *)view userId:(NSString *)userId successfulBlock:(SuccessfulBlock)successfulBlock failureBlock:(FailureBlock)failureBlock;

// get my earning
- (void)getMyEarningDataWithView:(UIView *)view idCard:(NSString *)idCard successfulBlock:(SuccessfulBlock)successfulBlock failureBlock:(FailureBlock)failureBlock;

// get invest Record
- (void)getInvestRecordDataWithView:(UIView *)view idCard:(NSString *)idCard successBlcok:(SuccessfulBlock)successfulBlock failureBlock:(FailureBlock )failureBlock;

// get buy record
- (void)getBuyRecordDataWithView:(UIView *)view goodsId:(NSNumber *)goodsId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock )failureBlock;

// Calendar
- (void)getCalendarDataWithView:(UIView *)view idCard:(NSString *)idCard successfulBlock:(SuccessfulBlock)successfulBlock failureBlock:(FailureBlock)failureBlock;

// 备货中
- (void)getOrderDataWithView:(UIView *)view idCard:(NSString *)idCard successBlock:(SuccessBlock )successBlock failureBlock:(FailureBlock)failureBlock;
//发货中
- (void)getShippedOrderWithView:(UIView *)view idCard:(NSString *)idCard successBlock:(SuccessBlock )successBlock failureBlock:(FailureBlock)failureBlock;
//已签收
- (void)getReceivedOrderWithView:(UIView *)view idCard:(NSString *)idCard successBlock:(SuccessBlock )successBlock failureBlock:(FailureBlock)failureBlock;
//购买纪录
- (void)getHuiRecordWithCategoryId:(NSNumber *)categoryId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//上传图片
- (void)upLoadWithUserFace:(UIImage *)faceImage idCard:(NSString *)idCard faceBlock:(void(^)(BOOL state,NSString *imageUrl))faceBlock;

@end
