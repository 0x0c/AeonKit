//
//  ANKTocuhSensor.h
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKModule.h"

@interface ANKTouchSensor : ANKModule

@property (nonatomic, readonly) id<ANKModuleCommunicationProtocol> position;
@property (nonatomic, readonly) id<ANKModuleCommunicationProtocol> pressure;
@property (nonatomic, assign) BOOL feedbackEnabled;
@property (nonatomic, readonly) NSInteger pressureValue;
@property (nonatomic, readonly) NSInteger positionValue;
@property (nonatomic, copy) void (^positionChangedHandler)(NSInteger position);
@property (nonatomic, copy) void (^pressureChangedHandler)(NSInteger pressure);

@end
