//
//  ANKTiltSensor.h
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKModule.h"

@interface ANKTiltSensor : ANKModule

extern NSString *const ANKTiltSensorStepUpNotifiction;

@property (nonatomic, readonly) id<ANKModuleCommunicationProtocol> tilt;
@property (nonatomic, strong) void (^valueChangedHandler)(NSInteger tiltCount);
@property (nonatomic, readonly) BOOL high;
@property (nonatomic, assign) NSTimeInterval sleepInterval;
@property (nonatomic, readonly) NSInteger tiltCount;

@end
