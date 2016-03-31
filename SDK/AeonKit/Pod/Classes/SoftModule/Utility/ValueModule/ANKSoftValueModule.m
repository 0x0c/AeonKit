//
//  ANKSoftValueModule.m
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import "ANKSoftValueModule.h"

@implementation ANKSoftValueModule

@synthesize identifier = _identifier;

- (void)setModuleValue:(CGFloat)moduleValue
{
	_moduleValue = moduleValue;
	[self sendData:@(_moduleValue)];
}

- (void)setOutput:(id<ANKModuleCommunicationProtocol>)output
{
	_output = output;
	[self sendData:@(_moduleValue)];
}

#pragma mark 

- (void)sendData:(id)data
{
	[self.output receiveDataFromModule:self data:data];
}

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	
}

@end
