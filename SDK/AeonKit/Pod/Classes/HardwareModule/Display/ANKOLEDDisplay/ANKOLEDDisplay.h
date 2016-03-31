//
//  ANKOLEDDisplay.h
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKModule.h"

@interface ANKOLEDDisplay : ANKModule

@property (nonatomic, readonly) id<ANKModuleCommunicationProtocol> str;

- (void)putText:(NSString *)text;

@end
