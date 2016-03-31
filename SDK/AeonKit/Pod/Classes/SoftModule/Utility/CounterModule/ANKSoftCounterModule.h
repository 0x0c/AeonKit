//
//  ANKSoftCounterModule.h
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import <Foundation/Foundation.h>
#import "ANKModule.h"

@interface ANKSoftCounterModule : NSObject <ANKModuleCommunicationProtocol>

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) ANKModule *input;
@property (nonatomic, strong) ANKModule *output;

@end
