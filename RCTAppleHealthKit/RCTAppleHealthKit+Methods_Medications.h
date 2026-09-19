//
//  RCTAppleHealthKit+Methods_Medications.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

/// HealthKit Medications API (iOS 26+): the medications a person tracks and their logged doses.
/// Read-only: HealthKit does not let third-party apps create these objects.
@interface RCTAppleHealthKit (Methods_Medications)

- (void)medications_getUserAnnotatedMedications:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)medications_getMedicationDoseEvents:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
