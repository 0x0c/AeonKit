//
//  ANKSoftHapticPatternGeneratorModule.h
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import <Foundation/Foundation.h>

#import "ANKModule.h"
#import "ANKHapticDisplay.h"

@interface ANKSoftHapticPatternGeneratorModule : NSObject <ANKModuleCommunicationProtocol>

@property (nonatomic, assign) ANKHapticPattern hapticPattern;
@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> input;
@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> pattern;

@end
