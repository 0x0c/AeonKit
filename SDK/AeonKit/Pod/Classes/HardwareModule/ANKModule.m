//
//  ANKModule.m
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKModule.h"

@implementation ANKModule

@synthesize identifier = _identifier;

- (_Nonnull instancetype)initWithModuleName:(NSString * _Nonnull )moduleName
{
	self = [self init];
	if (self) {
		_moduleName = moduleName;
	}
	
	return self;
}

- (void)connect
{
	[[KNSCentralManager sharedInstance] connectWithName:self.moduleName timeout:KonashiFindTimeoutInterval connectedHandler:^(KNSPeripheral *connectedPeripheral) {
		NSLog(@"connected : %@", connectedPeripheral.peripheral.name);
		self.peripheral = connectedPeripheral;
		if (self.connectedHandler) {
			self.connectedHandler();
		}
	}];
}

- (void)disconnect
{
	[[KNSCentralManager sharedInstance] cancelPeripheralConnection:self.peripheral];
}

- (void)sendData:(id)data
{
	
}

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	
}

@end
