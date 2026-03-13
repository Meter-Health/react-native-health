//
//  RCTAppleHealthKit+Methods_Results.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit+Methods_Results.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Results)


- (void)results_getBloodGlucoseSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bloodGlucoseType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];

    HKUnit *mmolPerL = [[HKUnit moleUnitWithMetricPrefix:HKMetricPrefixMilli molarMass:HKUnitMolarMassBloodGlucose] unitDividedByUnit:[HKUnit literUnit]];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:mmolPerL];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:bloodGlucoseType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"An error occured while retrieving the glucose sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while retrieving the glucose sample", error, nil)]);
            return;
        }
    }];
}

- (void)results_getInsulinDeliverySamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *insulinDeliveryType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierInsulinDelivery];

    HKUnit *unit = [HKUnit internationalUnit];

    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:insulinDeliveryType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"An error occured while retrieving the glucose sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while retrieving the glucose sample", error, nil)]);
            return;
        }
    }];
}

- (void)results_getCarbohydratesSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *carbohydratesType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit gramUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:carbohydratesType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"An error occured while retrieving the carbohydates sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while retrieving the carbohydates sample", error, nil)]);
            return;
        }
    }];
}

- (void)results_saveInsulinDeliverySample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *insulinDeliveryType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierInsulinDelivery];

    HKUnit *unit = [HKUnit internationalUnit];

    double value = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:startDate];
    NSDictionary *metadata = [RCTAppleHealthKit metadataFromOptions:input withDefault:nil];

    HKQuantity *quantity = [HKQuantity quantityWithUnit:unit doubleValue:value];
    HKQuantitySample *sample = [HKQuantitySample quantitySampleWithType:insulinDeliveryType
                                                                      quantity:quantity
                                                                     startDate:startDate
                                                                       endDate:endDate
                                                                      metadata:metadata];

    [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured while saving the insulin sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while saving the insulin sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], [sample.UUID UUIDString]]);
    }];
}

- (void)results_saveBloodGlucoseSample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bloodGlucoseType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];

    HKUnit *mmolPerL = [[HKUnit moleUnitWithMetricPrefix:HKMetricPrefixMilli molarMass:HKUnitMolarMassBloodGlucose] unitDividedByUnit:[HKUnit literUnit]];

    double value = [RCTAppleHealthKit doubleValueFromOptions:input];
    // Undocumented `date` property was used before, keeping for backwards compatibility.
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:sampleDate];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:startDate];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:mmolPerL];
    NSDictionary *metadata = [RCTAppleHealthKit metadataFromOptions:input withDefault:nil];

    HKQuantity *glucoseQuantity = [HKQuantity quantityWithUnit:unit doubleValue:value];
    HKQuantitySample *glucoseSample = [HKQuantitySample quantitySampleWithType:bloodGlucoseType
                                                                      quantity:glucoseQuantity
                                                                     startDate:startDate
                                                                       endDate:endDate
                                                                      metadata:metadata];

    [self.healthStore saveObject:glucoseSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured while saving the glucose sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while saving the glucose sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], [glucoseSample.UUID UUIDString]]);
    }];
}

- (void)results_saveCarbohydratesSample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *carbohydratesType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates];

    double value = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit gramUnit]];
    NSDictionary *metadata = [RCTAppleHealthKit metadataFromOptions:input withDefault:nil];

    HKQuantity *carbQuantity = [HKQuantity quantityWithUnit:unit doubleValue:value];
    HKQuantitySample *carbSample = [HKQuantitySample quantitySampleWithType:carbohydratesType
                                                                   quantity:carbQuantity
                                                                  startDate:sampleDate
                                                                    endDate:sampleDate
                                                                   metadata:metadata];

    [self.healthStore saveObject:carbSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured while saving the carbohydrate sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while saving the carbohydrate sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], [carbSample.UUID UUIDString]]);
    }];
}

- (void)results_deleteBloodGlucoseSample:(NSString *)oid callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bloodGlucoseType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:oid];
    NSPredicate *uuidPredicate = [HKQuery predicateForObjectWithUUID:uuid];
    [self.healthStore deleteObjectsOfType:bloodGlucoseType predicate:uuidPredicate withCompletion:^(BOOL success, NSUInteger deletedObjectCount, NSError * _Nullable error) {
        if (!success) {
            NSLog(@"An error occured while deleting the glucose sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while deleting the glucose sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(deletedObjectCount)]);
    }];
}

- (void)results_deleteCarbohydratesSample:(NSString *)oid callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *carbohydratesType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:oid];
    NSPredicate *uuidPredicate = [HKQuery predicateForObjectWithUUID:uuid];
    [self.healthStore deleteObjectsOfType:carbohydratesType predicate:uuidPredicate withCompletion:^(BOOL success, NSUInteger deletedObjectCount, NSError * _Nullable error) {
        if (!success) {
            NSLog(@"An error occured while deleting the carbohydrate sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while deleting the carbohydrate sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(deletedObjectCount)]);
    }];
}

- (void)results_deleteInsulinDeliverySample:(NSString *)oid callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *insulinDeliveryType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierInsulinDelivery];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:oid];
    NSPredicate *uuidPredicate = [HKQuery predicateForObjectWithUUID:uuid];
    [self.healthStore deleteObjectsOfType:insulinDeliveryType predicate:uuidPredicate withCompletion:^(BOOL success, NSUInteger deletedObjectCount, NSError * _Nullable error) {
        if (!success) {
            NSLog(@"An error occured while deleting the insulin delivery sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while deleting the insulin delivery sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(deletedObjectCount)]);
    }];
}

- (void)results_registerObservers:(RCTBridge *)bridge hasListeners:(bool)hasListeners
{
    if (@available(iOS 11.0, *)) {
        HKSampleType* insulinType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierInsulinDelivery];
        [self setObserverForType:insulinType type:@"InsulinDelivery" bridge:bridge hasListeners:hasListeners];
    }
}

- (void)deleteSamplesByType:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    NSString *type = [RCTAppleHealthKit stringFromOptions:input key:@"type" withDefault:nil];
    NSDate *startDate = [RCTAppleHealthKit startDateFromOptions:input];
    NSDate *endDate = [RCTAppleHealthKit endDateFromOptionsDefaultNow:input];

    if (!type || !startDate) {
        callback(@[@"type and startDate are required", [NSNull null]]);
        return;
    }

    HKSampleType *sampleType = nil;

    if ([type isEqualToString:@"MindfulSession"]) {
        sampleType = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession];
    } else if ([type isEqualToString:@"SleepAnalysis"]) {
        sampleType = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    } else if ([type isEqualToString:@"Workout"]) {
        sampleType = [HKObjectType workoutType];
    } else {
        NSDictionary *typeMap = @{
            @"HeartRate":              HKQuantityTypeIdentifierHeartRate,
            @"HeartRateVariability":   HKQuantityTypeIdentifierHeartRateVariabilitySDNN,
            @"RestingHeartRate":       HKQuantityTypeIdentifierRestingHeartRate,
            @"ActiveEnergyBurned":     HKQuantityTypeIdentifierActiveEnergyBurned,
            @"BasalEnergyBurned":      HKQuantityTypeIdentifierBasalEnergyBurned,
            @"StepCount":              HKQuantityTypeIdentifierStepCount,
            @"Weight":                 HKQuantityTypeIdentifierBodyMass,
            @"Height":                 HKQuantityTypeIdentifierHeight,
            @"Vo2Max":                 HKQuantityTypeIdentifierVO2Max,
            @"OxygenSaturation":       HKQuantityTypeIdentifierOxygenSaturation,
            @"RespiratoryRate":        HKQuantityTypeIdentifierRespiratoryRate,
            @"BodyTemperature":        HKQuantityTypeIdentifierBodyTemperature,
            @"BodyFatPercentage":      HKQuantityTypeIdentifierBodyFatPercentage,
            @"DistanceWalkingRunning": HKQuantityTypeIdentifierDistanceWalkingRunning,
        };
        NSString *identifier = typeMap[type];
        if (!identifier) {
            callback(@[[NSString stringWithFormat:@"Unknown type: %@", type], [NSNull null]]);
            return;
        }
        sampleType = [HKObjectType quantityTypeForIdentifier:identifier];
    }

    if (!sampleType) {
        callback(@[[NSString stringWithFormat:@"Could not resolve HKSampleType for: %@", type], [NSNull null]]);
        return;
    }

    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];

    HKSampleQuery *query = [[HKSampleQuery alloc]
        initWithSampleType:sampleType
        predicate:predicate
        limit:HKObjectQueryNoLimit
        sortDescriptors:nil
        resultsHandler:^(HKSampleQuery *q, NSArray *samples, NSError *error) {
            if (error) {
                callback(@[error.localizedDescription, [NSNull null]]);
                return;
            }
            if (!samples || samples.count == 0) {
                callback(@[[NSNull null], @0]);
                return;
            }
            [self.healthStore deleteObjects:samples withCompletion:^(BOOL success, NSError *deleteError) {
                if (!success) {
                    callback(@[deleteError.localizedDescription ?: @"Delete failed", [NSNull null]]);
                    return;
                }
                callback(@[[NSNull null], @(samples.count)]);
            }];
        }];

    [self.healthStore executeQuery:query];
}

- (void)saveSleepSample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate   = [RCTAppleHealthKit dateFromOptions:input key:@"endDate"   withDefault:nil];
    NSInteger value   = (NSInteger)[RCTAppleHealthKit doubleFromOptions:input key:@"value" withDefault:0];

    if (!startDate || !endDate) {
        callback(@[@"startDate and endDate are required", [NSNull null]]);
        return;
    }

    HKCategoryType *sleepType = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];

    HKCategorySample *sample = [HKCategorySample categorySampleWithType:sleepType
                                                                  value:(HKCategoryValue)value
                                                              startDate:startDate
                                                                endDate:endDate];

    [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            callback(@[error.localizedDescription ?: @"Failed to save sleep sample", [NSNull null]]);
            return;
        }
        callback(@[[NSNull null], sample.UUID.UUIDString]);
    }];
}
@end
