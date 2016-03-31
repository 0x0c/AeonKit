//
//  ANKModuleCommunicationProtocol.h
//  Pods
//
//  Created by Akira Matsuda on 2/11/16.
//
//

#import <Foundation/Foundation.h>

@class ANKModule;

@protocol ANKModuleCommunicationProtocol <NSObject>

@property (nonatomic, strong) NSString * _Nonnull identifier;

@required
- (void)sendData:(id)data;
- (void)receiveDataFromModule:(id<ANKModuleCommunicationProtocol>)module data:(id)data;

@optional
- (void)sendSignalWithParameter:(NSDictionary *)param from:(ANKModule *)module;

@end
