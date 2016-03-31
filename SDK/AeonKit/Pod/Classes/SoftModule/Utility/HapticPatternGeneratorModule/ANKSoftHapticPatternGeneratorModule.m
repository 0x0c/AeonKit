//
//  ANKSoftHapticPatternGeneratorModule.m
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import "ANKSoftHapticPatternGeneratorModule.h"

@implementation ANKSoftHapticPatternGeneratorModule

@synthesize identifier = _identifier;

#pragma mark - ANKModuleCommunicationProtocol

- (void)sendData:(id)data
{
	[self.pattern receiveDataFromModule:self data:data];
}

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	BOOL input = (BOOL)[data boolValue];
	if (input) {
		[self sendData:@(self.hapticPattern)];
	}
}

@end
