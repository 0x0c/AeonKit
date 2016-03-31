//
//  ANKOLEDDisplay.m
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKOLEDDisplay.h"

@implementation ANKOLEDDisplay

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:KonashiEventConnectedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
			if (self.peripheral) {
				[self.peripheral setReadyHandler:^() {
					//				[bself.peripheral pinMode:KonashiDigitalIO7 mode:KonashiPinModeOutput];
					//				[bself.peripheral digitalWrite:KonashiDigitalIO7 value:KonashiLevelLow];
				}];
				[[NSNotificationCenter defaultCenter] removeObserver:self.observer];
			}
		}];
	}
	
	return self;
}

- (void)putText:(NSString *)text
{
	
}

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	NSString *string = (NSString *)data;
	[self putText:string];
}

@end
