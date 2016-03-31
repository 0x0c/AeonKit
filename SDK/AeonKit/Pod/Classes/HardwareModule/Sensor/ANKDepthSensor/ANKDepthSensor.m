//
//  ANKDepthSensor.m
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKDepthSensor.h"

@interface ANKDepthSensor()

@end

@implementation ANKDepthSensor

- (instancetype)init
{
	self = [super init];
	if (self) {
		__weak typeof(self) bself = self;
		self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:KonashiEventConnectedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
			if (self.peripheral) {
				[self.peripheral setReadyHandler:^() {
					[bself.peripheral uartMode:KonashiUartModeEnable baudrate:KonashiUartBaudrateRate9K6];
					[bself.peripheral setUartRxCompleteHandler:^(NSData *data) {
						Byte op = *(Byte *)([data bytes]);
						bself.depthValue = (NSInteger)op;
						if (bself.depthChangedHandler) {
							bself.depthChangedHandler(bself.depthValue);
						}
						[bself sendData:@(bself.depthValue)];
					}];
				}];
				[[NSNotificationCenter defaultCenter] removeObserver:self.observer];
			}
		}];
	}
	
	return self;
}

- (void)setDepthValue:(NSInteger)depthValue
{
	_depthValue = depthValue;
	[self sendData:@(depthValue)];
}

- (void)sendData:(id)data
{
	[self.depth receiveDataFromModule:self data:data];
}

@end
