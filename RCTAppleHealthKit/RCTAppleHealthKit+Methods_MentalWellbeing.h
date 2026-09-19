//
//  RCTAppleHealthKit+Methods_MentalWellbeing.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

/// State of Mind (mood / emotion logging) and scored assessments (GAD-7, PHQ-9). iOS 18+.
@interface RCTAppleHealthKit (Methods_MentalWellbeing)

- (void)mentalWellbeing_getStateOfMindSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)mentalWellbeing_saveStateOfMind:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)mentalWellbeing_getScoredAssessments:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)mentalWellbeing_saveScoredAssessment:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
