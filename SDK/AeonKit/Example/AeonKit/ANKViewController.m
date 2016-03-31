//
//  ANKViewController.m
//  AeonKit
//
//  Created by Akira Matsuda on 02/09/2016.
//  Copyright (c) 2016 Akira Matsuda. All rights reserved.
//

#import "ANKViewController.h"
#import "AeonKit.h"

@interface ANKViewController ()

@property (strong, nonatomic) NSMutableArray *hardwareModule;
@property (strong, nonatomic) NSMutableDictionary<NSString *, id<ANKModuleCommunicationProtocol>> *modules;
@property (strong, nonatomic) ANKDepthSensor *depth;
@property (strong, nonatomic) ANKSoftConditionModule *condition;
@property (strong, nonatomic) IBOutlet UILabel *logTextLabel;

@end

@implementation ANKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.modules = [NSMutableDictionary new];
	self.hardwareModule = [NSMutableArray new];
	
	// Do any additional setup after loading the view, typically from a nib.
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"graph" ofType:@"amg"];
	NSError *error;
	NSString *text = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
	NSLog(@"%@", text);
	self.logTextLabel.text = text;
	
	NSArray *line = [text componentsSeparatedByString:@"\n"];
	for (NSString *connection in line) {
		if (connection.length == 0) {
			break;
		}
		NSLog(@"%@", connection);
		NSArray *module = [connection componentsSeparatedByString:@" "];
		NSArray *param1 = [module[0] componentsSeparatedByString:@":"];
		NSLog(@"%@ - %@", module[0], param1);
		NSObject<ANKModuleCommunicationProtocol> *node1 = self.modules[param1[0]];
		if (node1 == nil) {
			node1 = [self nodeFromString:param1];
			self.modules[param1[0]] = node1;
		}
		NSString *outputKey = param1[2];
		NSArray *param2 = [module[1] componentsSeparatedByString:@":"];
		NSLog(@"%@ - %@", module[1], param2);
		NSObject<ANKModuleCommunicationProtocol> *node2 = self.modules[param2[0]];
		if (node2 == nil) {
			node2 = [self nodeFromString:param2];
			self.modules[param2[0]] = node2;
		}
		NSString *inputKey = param2[2];
		[node1 setValue:node2 forKey:outputKey];
		[node2 setValue:node1 forKey:inputKey];
		[self updateValueForNode:param1 node:node1];
		[self updateValueForNode:param2 node:node2];
	}
	for (NSString *key in self.modules) {
		id m = self.modules[key];
		if ([m isKindOfClass:[ANKModule class]]) {
			[self.hardwareModule addObject:m];
		}
	}
}

- (id<ANKModuleCommunicationProtocol>)nodeFromString:(NSArray<NSString *> *)param
{
	id<ANKModuleCommunicationProtocol> node = nil;
	NSString *label = param[0];
	if ([label isEqualToString:@"BOOL"]) {
//		node = new AeonKitMapper::LogicBooleanModule(offset, offset);
	}
	else if ([label isEqualToString:@"NOT"]) {
		node = [ANKSoftLogicNOTModule new];
	}
	else if ([label isEqualToString:@"AND"]) {
		node = [ANKSoftLogicANDModule new];
	}
	else if ([label isEqualToString:@"OR"]) {
		node = [ANKSoftLogicORModule new];
	}
	else if ([label isEqualToString:@"XOR"]) {
		node = [ANKSoftLogicXORModule new];
	}
	else if ([label isEqualToString:@"HapticPatternGenerator"]) {
		node = [ANKSoftHapticPatternGeneratorModule new];
	}
	else if ([label isEqualToString:@"Counter"]) {
		node = [ANKSoftCounterModule new];
	}
	else if ([label isEqualToString:@"Value"]) {
		node = [ANKSoftValueModule new];
		((ANKSoftValueModule *)node).moduleValue = [param[3] integerValue];
	}
	else if ([label isEqualToString:@"Condition"]) {
		node = [ANKSoftConditionModule new];
		((ANKSoftConditionModule *)node).comparisonType = [param[3] integerValue];
	}
	else if ([label isEqualToString:@"OLEDDisplay"]) {
		node = [[ANKOLEDDisplay alloc] initWithModuleName:param[3]];
	}
	else if ([label isEqualToString:@"HapticDisplay"]) {
		node = [[ANKHapticDisplay alloc] initWithModuleName:param[3]];
	}
	else if ([label isEqualToString:@"DepthSensor"]) {
		node = [[ANKDepthSensor alloc] initWithModuleName:param[3]];
	}
	else if ([label isEqualToString:@"TiltSensor"]) {
		node = [[ANKTiltSensor alloc] initWithModuleName:param[3]];
	}
	else if ([label isEqualToString:@"TouchSensor"]) {
		node = [[ANKTouchSensor alloc] initWithModuleName:param[3]];
	}
	
	return node;
}

- (void)updateValueForNode:(NSArray<NSString *> *)param node:(id<ANKModuleCommunicationProtocol>)node
{
	NSString *label = param[0];
	if ([label isEqualToString:@"Value"]) {
		((ANKSoftValueModule *)node).moduleValue = [param[3] integerValue];
	}
	else if ([label isEqualToString:@"Condition"]) {
		((ANKSoftConditionModule *)node).comparisonType = [param[3] integerValue];
	}
	else if ([label isEqualToString:@"HapticPatternGenerator"]) {
		((ANKSoftHapticPatternGeneratorModule *)node).hapticPattern = [param[3] integerValue];
	}
}

- (IBAction)connect:(id)sender
{
	ANKModule *m = self.hardwareModule.firstObject;
	__weak typeof(m) bm = m;
	[m setConnectedHandler:^{
		[self.hardwareModule removeObject:bm];
		[self connect:nil];
	}];
	[m connect];
}

@end
