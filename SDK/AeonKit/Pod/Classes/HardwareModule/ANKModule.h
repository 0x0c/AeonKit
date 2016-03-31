//
//  ANKModule.h
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import <Foundation/Foundation.h>
#import "ANKModuleCommunicationProtocol.h"
#import "Konashi.h"

typedef NS_ENUM(NSInteger, ANKModuleType) {
	ANKModuleTypeSensor,
	ANKModuleTypeDisplay,
	ANKModuleTypeSoftLogic,
	ANKModuleTypeSoftUtility,
	ANKModuleTypeSoftCondition,
};

@interface ANKModule : NSObject <ANKModuleCommunicationProtocol>

- (_Nonnull instancetype)initWithModuleName:(NSString * _Nonnull )moduleName;
- (void)connect;
- (void)disconnect;

@property (nonatomic, strong) id observer;
@property (nonatomic, strong) void (^connectedHandler)();
@property (nonatomic, strong) KNSPeripheral *peripheral;
@property (nonatomic, assign) ANKModuleType type;
@property (nonatomic, readonly) NSString * _Nonnull moduleName;

@end
