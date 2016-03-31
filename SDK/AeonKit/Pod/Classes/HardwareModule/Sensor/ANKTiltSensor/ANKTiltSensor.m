//
//  ANKTiltSensor.m
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKTiltSensor.h"

NSString *const ANKTiltSensorStepUpNotifiction = @"ANKTiltSensorStepUpNotifiction";

@interface ANKTiltSensor ()

@property (nonatomic, strong) NSDate *timeStamp;
@property (nonatomic, readwrite) NSInteger tiltCount;
@property (nonatomic, readwrite) BOOL high;

@end

@implementation ANKTiltSensor

- (instancetype)init
{
	self = [super init];
	if (self) {
		__weak typeof(self) bself = self;
		self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:KonashiEventConnectedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
			if (self.peripheral) {
				[self.peripheral setReadyHandler:^() {
					[bself.peripheral pinMode:KonashiDigitalIO4 mode:KonashiPinModeOutput];
					[bself.peripheral digitalWrite:KonashiDigitalIO4 value:KonashiLevelHigh];
					[bself.peripheral pinMode:KonashiDigitalIO5 mode:KonashiPinModeInput];
				}];
				[self.peripheral setDigitalInputDidChangeValueHandler:^(KonashiDigitalIOPin pin, int value) {
					if (pin == KonashiDigitalIO5 && value != bself.high && value == KonashiLevelHigh) {
						//					if ([bself.timeStamp timeIntervalSinceNow] < -bself.sleepInterval) {
						bself.tiltCount++;
						if (bself.valueChangedHandler) {
							bself.valueChangedHandler(value);
						}
						[[NSNotificationCenter defaultCenter]postNotificationName:ANKTiltSensorStepUpNotifiction object:nil];
						bself.timeStamp = [NSDate date];
						[bself sendData:@(bself.tiltCount)];
						//					}
					}
					bself.high = value;
				}];
				[[NSNotificationCenter defaultCenter] removeObserver:self.observer];
			}
		}];
	}
	
	return self;
}

- (void)sendData:(id)data
{
	[self.tilt receiveDataFromModule:self data:data];
}

@end
