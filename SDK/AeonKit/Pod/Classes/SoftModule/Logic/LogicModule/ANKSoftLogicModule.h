//
//  ANKSoftLogicModule.h
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import <Foundation/Foundation.h>
#import "ANKModule.h"

@interface ANKSoftLogicModule : NSObject <ANKModuleCommunicationProtocol>

@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> output;

@end

@interface ANKSoftLogicNOTModule : ANKSoftLogicModule

@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> input;

@end

@interface ANKSoftLogicANDModule : ANKSoftLogicModule

@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> in1;
@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> in2;

@end

@interface ANKSoftLogicORModule : ANKSoftLogicModule

@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> in1;
@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> in2;

@end

@interface ANKSoftLogicXORModule : ANKSoftLogicModule

@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> in1;
@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> in2;

@end
