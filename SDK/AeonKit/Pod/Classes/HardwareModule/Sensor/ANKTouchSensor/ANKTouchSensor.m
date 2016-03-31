//
//  ANKTocuhSensor.m
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKTouchSensor.h"

@interface ANKTouchSensor ()

@property (nonatomic, readwrite) NSInteger pressureValue;
@property (nonatomic, readwrite) NSInteger positionValue;

@end

@implementation ANKTouchSensor

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
						BOOL type = op & 0b10000000;
						UInt8 value = op & 0b01111111;
						if (type) {
							NSLog(@"pr %d", value);
							bself.pressureValue = value;
							if (bself.pressureChangedHandler) {
								bself.pressureChangedHandler(value);
							}
							[bself.pressure receiveDataFromModule:bself data:@(value)];
						}
						else {
							NSLog(@"po %d", value);
							bself.positionValue = value;
							if (bself.positionChangedHandler) {
								bself.positionChangedHandler(value);
							}
							[bself.position receiveDataFromModule:bself data:@(value)];
						}
					}];
				}];
				[[NSNotificationCenter defaultCenter] removeObserver:self.observer];
			}
		}];
	}
	
	return self;
}

@end
