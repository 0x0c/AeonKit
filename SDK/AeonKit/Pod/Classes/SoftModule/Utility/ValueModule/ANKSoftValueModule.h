//
//  ANKSoftValueModule.h
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import <Foundation/Foundation.h>
#import "ANKModule.h"

@interface ANKSoftValueModule : NSObject <ANKModuleCommunicationProtocol>

@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> output;
@property (nonatomic, assign) CGFloat moduleValue;

@end
