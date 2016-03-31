//
//  ANKSoftLogicModule.m
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import "ANKSoftLogicModule.h"

@implementation ANKSoftLogicModule

@synthesize identifier = _identifier;

#pragma mark - ANKModuleCommunicationProtocol

- (void)sendData:(id)data
{
	[self.output receiveDataFromModule:self data:data];
}

@end

@interface ANKSoftLogicNOTModule ()

@property (nonatomic, assign) BOOL input1Value;
@property (nonatomic, assign) BOOL input2Value;

@end

@implementation ANKSoftLogicNOTModule

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	[self sendData:@(![(NSNumber *)data boolValue])];
}

@end

@interface ANKSoftLogicANDModule ()

@property (nonatomic, assign) BOOL input1Value;
@property (nonatomic, assign) BOOL input2Value;

@end

@implementation ANKSoftLogicANDModule

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	if (self.in1 == module) {
		self.input1Value = [data boolValue];
	}
	else {
		self.input2Value = [data boolValue];
	}
	[self sendData:@(self.input1Value & self.input2Value)];
}

@end

@interface ANKSoftLogicORModule ()

@property (nonatomic, assign) BOOL input1Value;
@property (nonatomic, assign) BOOL input2Value;

@end

@implementation ANKSoftLogicORModule

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	if (self.in1 == module) {
		self.input1Value = [data boolValue];
	}
	else {
		self.input2Value = [data boolValue];
	}
	[self sendData:@(self.input1Value | self.input2Value)];
}

@end

@interface ANKSoftLogicXORModule ()

@property (nonatomic, assign) BOOL input1Value;
@property (nonatomic, assign) BOOL input2Value;

@end

@implementation ANKSoftLogicXORModule

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	if (self.in1 == module) {
		self.input1Value = [data boolValue];
	}
	else {
		self.input2Value = [data boolValue];
	}
	[self sendData:@(self.input1Value ^ self.input2Value)];
}

@end
