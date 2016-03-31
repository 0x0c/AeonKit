//
//  ANKSoftCounterModule.m
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import "ANKSoftCounterModule.h"

@implementation ANKSoftCounterModule

@synthesize identifier = _identifier;

#pragma mark - ANKModuleCommunicationProtocol

- (void)sendData:(id)data
{
	[self.output receiveDataFromModule:self data:data];
}

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	BOOL input = (BOOL)[data boolValue];
	if (input) {
		self.count++;
	}
	else {
		self.count--;
	}
	
	[self sendData:@(self.count)];
}

@end
