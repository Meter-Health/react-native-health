//
//  RCTAppleHealthKit+TypesAndPermissions.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCTAppleHealthKit (TypesAndPermissions)

- (NSDictionary *)readPermsDict;
- (NSDictionary *)writePermsDict;
- (nullable HKObjectType *)getReadPermFromText:(nonnull NSString *)key;
- (NSSet *)getReadPermsFromOptions:(NSArray *)options;
- (NSSet *)getWritePermsFromOptions:(NSArray *)options;
- (HKObjectType *)getWritePermFromString:(NSString *)string;
- (NSString *)getAuthorizationStatusString:(HKAuthorizationStatus)status;
+ (NSDictionary *)getStringToWorkoutActivityTypeDictionary;
+ (nullable HKSampleType *)extendedSampleTypeFromName:(NSString *)name;
+ (BOOL)isReadOnlyTypeName:(NSString *)name;
+ (nullable HKObjectType *)wellbeingOrMedicationTypeFromName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
