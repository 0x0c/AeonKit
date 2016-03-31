//
//  ANKHapticDisplay.h
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKModule.h"

typedef NS_ENUM(NSUInteger, ANKHapticPattern) {
	ANKHapticPatternSingleTap,
	ANKHapticPatternDoubleTap,
	ANKHapticPatternShortDuration,
	ANKHapticPatternLongDuration,
};

@interface ANKHapticDisplay : ANKModule

@property (nonatomic, readonly) id<ANKModuleCommunicationProtocol> pattern;

- (void)vibrateWithPattern:(ANKHapticPattern)pattern;
- (void)vibrateWithDurationPattern:(NSArray *)duration completionHandler:(void (^)())handler;
- (void)vibrateForDuration:(NSTimeInterval)duration completionHandler:(void (^)())handler;
- (void)vibrateWithPattern:(ANKHapticPattern)pattern completionHandler:(void (^)())handler;

@end
