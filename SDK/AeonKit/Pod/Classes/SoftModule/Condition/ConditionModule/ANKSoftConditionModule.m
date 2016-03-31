//
//  ANKSoftConditionModule.m
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import "ANKSoftConditionModule.h"

@interface ANKSoftConditionModule ()

@property (nonatomic, assign) CGFloat input1Value;
@property (nonatomic, assign) CGFloat input2Value;

@end

@implementation ANKSoftConditionModule

@synthesize identifier = _identifier;

#pragma mark - ANKModuleCommunicationProtocol

- (void)sendData:(id)data
{
	[self.output receiveDataFromModule:self data:data];
}

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	if (module == self.in1) {
		self.input1Value = [data floatValue];
	}
	else {
		self.input2Value = [data floatValue];
	}
	
	BOOL result = NO;
	switch (self.comparisonType) {
		case ANKSoftConditionModuleCmparisonTypeEqual: {
			result = self.input1Value == self.input2Value;
			break;
		}
		case ANKSoftConditionModuleCmparisonTypeNotEqual: {
			result = self.input1Value != self.input2Value;
			break;
		}
		case ANKSoftConditionModuleCmparisonTypeGreater: {
			result = self.input1Value > self.input2Value;
			break;
		}
		case ANKSoftConditionModuleCmparisonTypeGreaterEqual: {
			result = self.input1Value >= self.input2Value;
			break;
		}
		case ANKSoftConditionModuleCmparisonTypeLess: {
			result = self.input1Value < self.input2Value;
			break;
		}
		case ANKSoftConditionModuleCmparisonTypeLessEqual: {
			result = self.input1Value <= self.input2Value;
			break;
		}
	}
	[self sendData:@(result)];
}

@end
