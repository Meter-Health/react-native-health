//
//  RCTAppleHealthKit+Utils.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Utils.h"
#import "RCTAppleHealthKit+TypesAndPermissions.h"

NSString * const kMetadataKey = @"metadata";

@implementation RCTAppleHealthKit (Utils)

#pragma mark - Utilities

+ (NSArray *)formatWorkoutEvents:(NSArray *)workoutEvents
{
    NSMutableArray *formattedWorkEvents = [[NSMutableArray alloc] init];
    
    for (id workoutEvent in workoutEvents) {
        NSNumber *eventType = [workoutEvent valueForKey:@"type"];
        NSString *eventDescription = @"";
        
        switch([eventType intValue]) {
            case (int)HKWorkoutEventTypePause:
                eventDescription = @"pause";
                break;
            case (int)HKWorkoutEventTypeResume:
                eventDescription = @"resume";
                break;
            case (int)HKWorkoutEventTypeMotionPaused:
                eventDescription = @"motion paused";
                break;
            case (int)HKWorkoutEventTypeMotionResumed:
                eventDescription = @"motion resumed";
                break;
            case (int)HKWorkoutEventTypePauseOrResumeRequest:
                eventDescription = @"pause or resume request";
                break;
            case (int)HKWorkoutEventTypeLap:
                eventDescription = @"lap";
                break;
            case (int)HKWorkoutEventTypeSegment:
                eventDescription = @"segment";
                break;
            case (int)HKWorkoutEventTypeMarker:
                eventDescription = @"marker";
            default:
                eventDescription = @"";
        }
        
        
        NSObject *formattedEvent = @{
            @"eventTypeInt":eventType,
            @"eventType": eventDescription,
            @"startDate": [RCTAppleHealthKit buildISO8601StringFromDate:[[workoutEvent dateInterval] startDate]],
            @"endDate": [RCTAppleHealthKit buildISO8601StringFromDate:[[workoutEvent dateInterval] endDate]]
        };
        [formattedWorkEvents addObject: formattedEvent];
    }
    
    return formattedWorkEvents;
}

+ (NSDate *)parseISO8601DateFromString:(NSString *)date
{
    @try {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        NSLocale *posix = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.locale = posix;
        dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ";
        return [dateFormatter dateFromString:date];
    } @catch (NSException *exception) {
        NSLog(@"RNHealth: An error occured while trying parse ISO8601 date from string");
        return nil;
    }
}


+ (NSString *)buildISO8601StringFromDate:(NSDate *)date
{
    @try {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        NSLocale *posix = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.locale = posix;
        dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ";
        return [dateFormatter stringFromDate:date];
    } @catch (NSException *exception) {
        NSLog(@"RNHealth: An error occured while trying parse ISO8601 string from date");
        return nil;
    }   
}


+ (NSPredicate *)predicateForSamplesToday {
    NSDate *now = [NSDate date];
    return [RCTAppleHealthKit predicateForSamplesOnDay:now];
}


+ (NSPredicate *)predicateForSamplesOnDayFromTimestamp:(NSString *)timestamp {
    NSDate *day = [RCTAppleHealthKit parseISO8601DateFromString:timestamp];
    return [RCTAppleHealthKit predicateForSamplesOnDay:day];
}


+ (NSPredicate *)predicateForSamplesOnDay:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *startDate = [calendar startOfDayForDate:date];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}


+ (NSPredicate *)predicateForSamplesBetweenDates:(NSDate *)startDate endDate:(NSDate *)endDate {
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}

+ (NSPredicate *)predicateForAnchoredQueries:(HKQueryAnchor *)anchor startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    if (startDate == nil) {
        return nil;
    } else {
        return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    }

}

+ (double)doubleValueFromOptions:(NSDictionary *)options {
    double value = [[options objectForKey:@"value"] doubleValue];
    return value;
}


+ (NSDate *)dateFromOptions:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"date"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
    }
    return date;
}


+ (NSDate *)dateFromOptionsDefaultNow:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"date"];
    if(dateString != nil){
        NSDate *date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
        if(date == nil){
            // probably not a good idea... should return an error or just the null pointer
            date = [NSDate date];
        }
        return date;
    }
    NSDate *now = [NSDate date];
    return now;
}


+ (NSDate *)startDateFromOptions:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"startDate"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
        return date;
    }
    return date;
}


+ (NSDate *)endDateFromOptions:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"endDate"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
    }
    return date;
}


+ (NSDate *)endDateFromOptionsDefaultNow:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"endDate"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
        return date;
    }
    if(date == nil){
        date = [NSDate date];
    }
    return date;
}

/*!
    Convert Human Readable name for a HealthKit activity into a HKObjectType format

    @param type The human readable format
 */
+ (HKSampleType *)quantityTypeFromName:(NSString *)type {
    if ([type isEqual:@"ActiveEnergyBurned"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    } else if ([type isEqual:@"BasalEnergyBurned"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    } else if ([type isEqual:@"Cycling"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    } else if ([type isEqual:@"HeartRate"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    } else if ([type isEqual:@"HeartRateVariabilitySDNN"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRateVariabilitySDNN];
    } else if ([type isEqual:@"RestingHeartRate"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRestingHeartRate];
    } else if ([type isEqual:@"Running"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    } else if ([type isEqual:@"StairClimbing"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    } else if ([type isEqual:@"StepCount"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if ([type isEqual:@"Swimming"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceSwimming];
    } else if ([type isEqual:@"Vo2Max"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierVO2Max];
    } else if ([type isEqual:@"Walking"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if ([type isEqual:@"Workout"]) {
        return [HKObjectType workoutType];
    }

    return [RCTAppleHealthKit extendedSampleTypeFromName:type];
}

+ (HKSampleType *)clinicalTypeFromName:(NSString *)type {
    if (@available(iOS 12.0, *)) {
        if ([type isEqual:@"AllergyRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierAllergyRecord];
        } else if ([type isEqual:@"ConditionRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierConditionRecord];
        } else if ([type isEqual:@"ImmunizationRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierImmunizationRecord];
        } else if ([type isEqual:@"LabResultRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierLabResultRecord];
        } else if ([type isEqual:@"MedicationRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierMedicationRecord];
        } else if ([type isEqual:@"ProcedureRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierProcedureRecord];
        } else if ([type isEqual:@"VitalSignRecord"]) {
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierVitalSignRecord];
        }
    }
    
    if (@available(iOS 14.0, *)) {
         if ([type isEqual:@"CoverageRecord"]){
             return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierCoverageRecord];
         }
    }
    
    return nil;
}

+ (HKQueryAnchor *)hkAnchorFromOptions:(NSDictionary *)options {
    NSString *anchorString = [options objectForKey:@"anchor"];
    if (!anchorString.length) return nil;
    NSData* anchorData = [[NSData alloc] initWithBase64EncodedString:anchorString options:0];
    HKQueryAnchor *anchor = [NSKeyedUnarchiver unarchiveObjectWithData:anchorData];
    if(anchor == nil){
        return nil;
    }
    return anchor;
}


+ (HKUnit *)hkUnitFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(HKUnit *)defaultValue {
    NSString *unitString = [options objectForKey:key];
    HKUnit *theUnit;

    if ([unitString isEqualToString:@"gram"]) {
         theUnit = [HKUnit gramUnit];
    }
    if ([unitString isEqualToString:@"kg"]) {
         theUnit = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
    }
    if ([unitString isEqualToString:@"stone"]) {
         theUnit = [HKUnit stoneUnit];
    }
    if ([unitString isEqualToString:@"pound"]) {
         theUnit = [HKUnit poundUnit];
    }
    if ([unitString isEqualToString:@"meter"]) {
         theUnit = [HKUnit meterUnit];
    }
    if ([unitString isEqualToString:@"cm"]) {
         theUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixCenti];
    }
    if ([unitString isEqualToString:@"inch"]) {
         theUnit = [HKUnit inchUnit];
    }
    if ([unitString isEqualToString:@"mile"]) {
         theUnit = [HKUnit mileUnit];
    }
    if ([unitString isEqualToString:@"foot"]) {
         theUnit = [HKUnit footUnit];
    }
    if ([unitString isEqualToString:@"second"]) {
         theUnit = [HKUnit secondUnit];
    }
    if ([unitString isEqualToString:@"minute"]) {
         theUnit = [HKUnit minuteUnit];
    }
    if ([unitString isEqualToString:@"hour"]) {
         theUnit = [HKUnit hourUnit];
    }
    if ([unitString isEqualToString:@"day"]) {
         theUnit = [HKUnit dayUnit];
    }
    if ([unitString isEqualToString:@"joule"]) {
         theUnit = [HKUnit jouleUnit];
    }
    if ([unitString isEqualToString:@"calorie"]) {
         theUnit = [HKUnit calorieUnit];
    }
    if ([unitString isEqualToString:@"count"]) {
         theUnit = [HKUnit countUnit];
    }
    if ([unitString isEqualToString:@"percent"]) {
         theUnit = [HKUnit percentUnit];
    }
    if ([unitString isEqualToString:@"bpm"]) {
         HKUnit *count = [HKUnit countUnit];
         HKUnit *minute = [HKUnit minuteUnit];

         theUnit = [count unitDividedByUnit:minute];
    }
    if ([unitString isEqualToString:@"fahrenheit"]) {
         theUnit = [HKUnit degreeFahrenheitUnit];
    }
    if ([unitString isEqualToString:@"celsius"]) {
         theUnit = [HKUnit degreeCelsiusUnit];
    }
    if ([unitString isEqualToString:@"mmhg"]) {
         theUnit = [HKUnit millimeterOfMercuryUnit];
    }
    if ([unitString isEqualToString:@"mmolPerL"]) {
         theUnit = [[HKUnit moleUnitWithMetricPrefix:HKMetricPrefixMilli molarMass:HKUnitMolarMassBloodGlucose] unitDividedByUnit:[HKUnit literUnit]];
    }
    if ([unitString isEqualToString:@"literPerMinute"]) {
         theUnit = [[HKUnit literUnit] unitDividedByUnit:[HKUnit minuteUnit]];
    }
    if ([unitString isEqualToString:@"mgPerdL"]) {
         theUnit = [HKUnit unitFromString:@"mg/dL"];
    }
    if ([unitString isEqualToString:@"mlPerKgMin"]) {
      HKUnit *ml = [HKUnit literUnitWithMetricPrefix:HKMetricPrefixMilli];
      HKUnit *kg = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
      HKUnit *min = [HKUnit minuteUnit];
      theUnit = [ml unitDividedByUnit:[kg unitMultipliedByUnit:min]];
    }
    if ([unitString isEqualToString:@"kilocalorie"]) {
         theUnit = [HKUnit kilocalorieUnit];
    }
    if ([unitString isEqualToString:@"kilometer"]) {
         theUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];
    }
    if ([unitString isEqualToString:@"liter"]) {
         theUnit = [HKUnit literUnit];
    }
    if ([unitString isEqualToString:@"milliliter"]) {
         theUnit = [HKUnit literUnitWithMetricPrefix:HKMetricPrefixMilli];
    }
    if ([unitString isEqualToString:@"milligram"]) {
         theUnit = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixMilli];
    }
    if ([unitString isEqualToString:@"microgram"]) {
         theUnit = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixMicro];
    }
    if ([unitString isEqualToString:@"watt"]) {
         if (@available(iOS 16.0, *)) {
             theUnit = [HKUnit wattUnit];
         }
    }
    if ([unitString isEqualToString:@"rpm"]) {
         theUnit = [[HKUnit countUnit] unitDividedByUnit:[HKUnit minuteUnit]];
    }
    if ([unitString isEqualToString:@"meterPerSecond"]) {
         theUnit = [[HKUnit meterUnit] unitDividedByUnit:[HKUnit secondUnit]];
    }
    if ([unitString isEqualToString:@"kmPerHour"]) {
         theUnit = [[HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo] unitDividedByUnit:[HKUnit hourUnit]];
    }
    if ([unitString isEqualToString:@"milePerHour"]) {
         theUnit = [[HKUnit mileUnit] unitDividedByUnit:[HKUnit hourUnit]];
    }
    if ([unitString isEqualToString:@"kcalPerKgHour"]) {
         // PhysicalEffort (MET-equivalent)
         HKUnit *kg = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
         theUnit = [[HKUnit kilocalorieUnit] unitDividedByUnit:[kg unitMultipliedByUnit:[HKUnit hourUnit]]];
    }
    if ([unitString isEqualToString:@"decibel"]) {
         theUnit = [HKUnit decibelAWeightedSoundPressureLevelUnit];
    }
    if ([unitString isEqualToString:@"microsiemens"]) {
         theUnit = [HKUnit siemenUnitWithMetricPrefix:HKMetricPrefixMicro];
    }
    if ([unitString isEqualToString:@"appleEffortScore"]) {
         if (@available(iOS 18.0, *)) {
             theUnit = [HKUnit appleEffortScoreUnit];
         }
    }

    // Escape hatch: any HealthKit unit string (e.g. "kcal/(kg*hr)", "m/s", "W") is accepted as-is.
    if (theUnit == nil && unitString.length > 0) {
        @try {
            theUnit = [HKUnit unitFromString:unitString];
        } @catch (NSException *exception) {
            theUnit = nil;
        }
    }

    if(theUnit == nil){
        theUnit = defaultValue;
    }

    return theUnit;
}

/*!
    A unit the given quantity type can be expressed in, used when the caller did not pass one (or
    passed one that does not fit the type). Candidates are tried in order, so the common types get
    the unit people expect (count, meters, kcal, bpm, percent, ...).
 */
+ (HKUnit *)defaultUnitForQuantityType:(HKQuantityType *)quantityType
{
    NSMutableArray<HKUnit *> *candidates = [NSMutableArray arrayWithArray:@[
        [HKUnit countUnit],
        [HKUnit meterUnit],
        [HKUnit kilocalorieUnit],
        [[HKUnit countUnit] unitDividedByUnit:[HKUnit minuteUnit]],
        [HKUnit percentUnit],
        [HKUnit minuteUnit],
        [HKUnit degreeCelsiusUnit],
        [[HKUnit meterUnit] unitDividedByUnit:[HKUnit secondUnit]],
        [HKUnit literUnit],
        [HKUnit gramUnit],
        [HKUnit millimeterOfMercuryUnit],
        [HKUnit decibelAWeightedSoundPressureLevelUnit],
        [HKUnit siemenUnitWithMetricPrefix:HKMetricPrefixMicro],
        [[HKUnit kilocalorieUnit] unitDividedByUnit:[[HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo] unitMultipliedByUnit:[HKUnit hourUnit]]],
        [HKUnit internationalUnit],
        [[HKUnit literUnitWithMetricPrefix:HKMetricPrefixMilli] unitDividedByUnit:[[HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo] unitMultipliedByUnit:[HKUnit minuteUnit]]],
        [[HKUnit moleUnitWithMetricPrefix:HKMetricPrefixMilli molarMass:HKUnitMolarMassBloodGlucose] unitDividedByUnit:[HKUnit literUnit]],
        [HKUnit secondUnit],
    ]];
    if (@available(iOS 16.0, *)) {
        [candidates addObject:[HKUnit wattUnit]];
    }
    if (@available(iOS 18.0, *)) {
        [candidates addObject:[HKUnit appleEffortScoreUnit]];
    }
    for (HKUnit *unit in candidates) {
        if ([quantityType isCompatibleWithUnit:unit]) {
            return unit;
        }
    }
    return [HKUnit countUnit];
}


+ (NSUInteger)uintFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSUInteger)defaultValue {
    NSUInteger val;
    NSNumber *num = [options objectForKey:key];
    if(num != nil){
        val = [num unsignedIntValue];
    } else {
        val = defaultValue;
    }
    return val;
}


+ (double)doubleFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(double)defaultValue {
    double val;
    NSNumber *num = [options objectForKey:key];
    if(num != nil){
        val = [num doubleValue];
    } else {
        val = defaultValue;
    }
    return val;
}


+ (NSDate *)dateFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSDate *)defaultValue {
    NSString *dateString = [options objectForKey:key];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
    } else {
        date = defaultValue;
    }
    return date;
}


+ (NSString *)stringFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSString *)defaultValue {
    NSString *str = [options objectForKey:key];
    if(str == nil){
        str = defaultValue;
    }
    return str;
}


+ (bool)boolFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(bool)defaultValue {
    NSNumber *num = [options objectForKey:key];
    if(num == nil){
        return defaultValue;
    }
    return [num boolValue];
}

+ (NSDictionary *)metadataFromOptions:(NSDictionary *)options withDefault:(NSDictionary *)defaultValue {
    NSDictionary *metadata = [options objectForKey:kMetadataKey];
    if(metadata == nil){
        return defaultValue;
    }
    return metadata;
}

+ (NSMutableArray *)reverseNSMutableArray:(NSMutableArray *)array {
    if ([array count] <= 1)
        return array;
    NSUInteger i = 0;
    NSUInteger j = [array count] - 1;
    while (i < j) {
        [array exchangeObjectAtIndex:i
                  withObjectAtIndex:j];
        i++;
        j--;
    }
    return array;
}

+ (HKWorkoutActivityType)hkWorkoutActivityTypeFromOptions: (NSDictionary *)options key: (NSString *)key withDefault: (HKWorkoutActivityType)defaultValue {
    NSDictionary * stringToWorkoutActivityType = [RCTAppleHealthKit getStringToWorkoutActivityTypeDictionary];
    HKWorkoutActivityType activityType = defaultValue;

    if([options objectForKey:key] && [stringToWorkoutActivityType objectForKey:[options valueForKey:key]]) {
        NSString * activityString = [options valueForKey:key];
        activityType = [(NSNumber *)[stringToWorkoutActivityType objectForKey:activityString] integerValue];
    }
    return activityType;
}

+ (HKQuantity *)hkQuantityFromOptions:(NSDictionary *)options valueKey: (NSString *)valueKey unitKey: (NSString *)unitKey {
    const int outOfBoundValue = -1;
    double value = [RCTAppleHealthKit doubleFromOptions:options key:valueKey withDefault:outOfBoundValue];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:options key:unitKey withDefault:nil];

    if(unit != nil && value >= 0) {
        return [HKQuantity quantityWithUnit:unit doubleValue:value];
    }
    return nil;
}

+ (NSString*)stringForHKWorkoutActivityType:(int) enumValue{
    switch( enumValue ){
        case HKWorkoutActivityTypeAmericanFootball:
            return @"AmericanFootball";
        case HKWorkoutActivityTypeArchery:
            return @"Archery";
        case HKWorkoutActivityTypeAustralianFootball:
            return @"AustralianFootball";
        case HKWorkoutActivityTypeBadminton:
            return @"Badminton";
        case HKWorkoutActivityTypeBaseball:
            return @"Baseball";
        case HKWorkoutActivityTypeBasketball:
            return @"Basketball";
        case HKWorkoutActivityTypeBowling:
            return @"Bowling";
        case HKWorkoutActivityTypeBoxing:
            return @"Boxing";
        case HKWorkoutActivityTypeCardioDance:
            return @"CardioDance";
        case HKWorkoutActivityTypeClimbing:
            return @"Climbing";
        case HKWorkoutActivityTypeCooldown:
            return @"Cooldown";
        case HKWorkoutActivityTypeCricket:
            return @"Cricket";
        case HKWorkoutActivityTypeCrossTraining:
            return @"CrossTraining";
        case HKWorkoutActivityTypeCurling:
            return @"Curling";
        case HKWorkoutActivityTypeCycling:
            return @"Cycling";
        case HKWorkoutActivityTypeDance:
            return @"Dance";
        case HKWorkoutActivityTypeDanceInspiredTraining:
            return @"DanceInspiredTraining";
        case HKWorkoutActivityTypeDiscSports:
            return @"DiscSports";
        case HKWorkoutActivityTypeElliptical:
            return @"Elliptical";
        case HKWorkoutActivityTypeEquestrianSports:
            return @"EquestrianSports";
        case HKWorkoutActivityTypeFencing:
            return @"Fencing";
        case HKWorkoutActivityTypeFitnessGaming:
            return @"FitnessGaming";
        case HKWorkoutActivityTypeFishing:
            return @"Fishing";
        case HKWorkoutActivityTypeFunctionalStrengthTraining:
            return @"FunctionalStrengthTraining";
        case HKWorkoutActivityTypeGolf:
            return @"Golf";
        case HKWorkoutActivityTypeGymnastics:
            return @"Gymnastics";
        case HKWorkoutActivityTypeHandball:
            return @"Handball";
        case HKWorkoutActivityTypeHiking:
            return @"Hiking";
        case HKWorkoutActivityTypeHockey:
            return @"Hockey";
        case HKWorkoutActivityTypeHunting:
            return @"Hunting";
        case HKWorkoutActivityTypeLacrosse:
            return @"Lacrosse";
        case HKWorkoutActivityTypeMartialArts:
            return @"MartialArts";
        case HKWorkoutActivityTypeMindAndBody:
            return @"MindAndBody";
        case HKWorkoutActivityTypeMixedMetabolicCardioTraining:
            return @"MixedMetabolicCardioTraining";
        case HKWorkoutActivityTypePaddleSports:
            return @"PaddleSports";
        case HKWorkoutActivityTypePlay:
            return @"Play";
        case HKWorkoutActivityTypePickleball:
            return @"Pickleball";
        case HKWorkoutActivityTypePreparationAndRecovery:
            return @"PreparationAndRecovery";
        case HKWorkoutActivityTypeRacquetball:
            return @"Racquetball";
        case HKWorkoutActivityTypeRowing:
            return @"Rowing";
        case HKWorkoutActivityTypeRugby:
            return @"Rugby";
        case HKWorkoutActivityTypeRunning:
            return @"Running";
        case HKWorkoutActivityTypeSailing:
            return @"Sailing";
        case HKWorkoutActivityTypeSkatingSports:
            return @"SkatingSports";
        case HKWorkoutActivityTypeSnowSports:
            return @"SnowSports";
        case HKWorkoutActivityTypeSoccer:
            return @"Soccer";
        case HKWorkoutActivityTypeSocialDance:
            return @"SocialDance";
        case HKWorkoutActivityTypeSoftball:
            return @"Softball";
        case HKWorkoutActivityTypeSquash:
            return @"Squash";
        case HKWorkoutActivityTypeStairClimbing:
            return @"StairClimbing";
        case HKWorkoutActivityTypeSurfingSports:
            return @"SurfingSports";
        case HKWorkoutActivityTypeSwimming:
            return @"Swimming";
        case HKWorkoutActivityTypeTableTennis:
            return @"TableTennis";
        case HKWorkoutActivityTypeTennis:
            return @"Tennis";
        case HKWorkoutActivityTypeTrackAndField:
            return @"TrackAndField";
        case HKWorkoutActivityTypeTraditionalStrengthTraining:
            return @"TraditionalStrengthTraining";
        case HKWorkoutActivityTypeVolleyball:
            return @"Volleyball";
        case HKWorkoutActivityTypeWalking:
            return @"Walking";
        case HKWorkoutActivityTypeWaterFitness:
            return @"WaterFitness";
        case HKWorkoutActivityTypeWaterPolo:
            return @"WaterPolo";
        case HKWorkoutActivityTypeWaterSports:
            return @"WaterSports";
        case HKWorkoutActivityTypeWrestling:
            return @"Wrestling";
        case HKWorkoutActivityTypeYoga:
            return @"Yoga";
        case HKWorkoutActivityTypeOther:
            return @"Other";
        case HKWorkoutActivityTypeBarre:
            return @"Barre";
        case HKWorkoutActivityTypeCoreTraining:
            return @"CoreTraining";
        case HKWorkoutActivityTypeCrossCountrySkiing:
            return @"CrossCountrySkiing";
        case HKWorkoutActivityTypeDownhillSkiing:
            return @"DownhillSkiing";
        case HKWorkoutActivityTypeFlexibility:
            return @"Flexibility";
        case HKWorkoutActivityTypeHighIntensityIntervalTraining:
            return @"HighIntensityIntervalTraining";
        case HKWorkoutActivityTypeJumpRope:
            return @"JumpRope";
        case HKWorkoutActivityTypeKickboxing:
            return @"Kickboxing";
        case HKWorkoutActivityTypePilates:
            return @"Pilates";
        case HKWorkoutActivityTypeSnowboarding:
            return @"Snowboarding";
        case HKWorkoutActivityTypeStairs:
            return @"Stairs";
        case HKWorkoutActivityTypeStepTraining:
            return @"StepTraining";
        case HKWorkoutActivityTypeWheelchairWalkPace:
            return @"WheelchairWalkPace";
        case HKWorkoutActivityTypeWheelchairRunPace:
            return @"WheelchairRunPace";
        case HKWorkoutActivityTypeTaiChi:
            return @"TaiChi";
        case HKWorkoutActivityTypeMixedCardio:
            return @"MixedCardio";
        case HKWorkoutActivityTypeHandCycling:
            return @"HandCycling";
        case HKWorkoutActivityTypeSwimBikeRun:
            return @"SwimBikeRun";
        case HKWorkoutActivityTypeTransition:
            return @"Transition";
        case HKWorkoutActivityTypeUnderwaterDiving:
            return @"UnderwaterDiving";
        default:
            return @"Other";
    }
}

/*!
    HKWorkout.totalEnergyBurned / totalDistance are deprecated since iOS 18. On iOS 16+ the same
    value is available through the workout statistics; the deprecated accessors are only used
    on older systems.
 */
+ (double)workoutSumForQuantityType:(HKQuantityType *)quantityType
                            workout:(HKWorkout *)workout
                               unit:(HKUnit *)unit
                           fallback:(HKQuantity *)fallback
{
    HKQuantity *quantity = nil;
    if (@available(iOS 16.0, *)) {
        quantity = [[workout statisticsForType:quantityType] sumQuantity];
    }
    if (quantity == nil) {
        quantity = fallback;
    }
    if (quantity == nil || ![quantity isCompatibleWithUnit:unit]) {
        return 0;
    }
    return [quantity doubleValueForUnit:unit];
}

+ (double)workoutTotalEnergyBurned:(HKWorkout *)workout unit:(HKUnit *)unit
{
    HKQuantity *fallback = nil;
    if (@available(iOS 18.0, *)) {
        // Workout statistics are the source of truth from iOS 18 on; nothing to fall back to.
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        fallback = [workout totalEnergyBurned];
#pragma clang diagnostic pop
    }
    return [self workoutSumForQuantityType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned]
                                   workout:workout
                                      unit:unit
                                  fallback:fallback];
}

+ (double)workoutTotalDistance:(HKWorkout *)workout unit:(HKUnit *)unit
{
    HKQuantity *fallback = nil;
    if (@available(iOS 18.0, *)) {
        // See workoutTotalEnergyBurned:unit:
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        fallback = [workout totalDistance];
#pragma clang diagnostic pop
    }
    HKQuantityType *distanceType = [self distanceQuantityTypeForWorkoutActivityType:[workout workoutActivityType]];
    return [self workoutSumForQuantityType:distanceType workout:workout unit:unit fallback:fallback];
}

/*!
    The distance quantity type HealthKit associates with a workout activity. Mirrors what the
    Workout app records, so saved and read distances line up with Apple Health.
 */
+ (HKQuantityType *)distanceQuantityTypeForWorkoutActivityType:(HKWorkoutActivityType)activityType
{
    NSString *identifier;
    switch (activityType) {
        case HKWorkoutActivityTypeCycling:
        case HKWorkoutActivityTypeHandCycling:
            identifier = HKQuantityTypeIdentifierDistanceCycling;
            break;
        case HKWorkoutActivityTypeSwimming:
        case HKWorkoutActivityTypeWaterFitness:
        case HKWorkoutActivityTypeWaterPolo:
        case HKWorkoutActivityTypeWaterSports:
            identifier = HKQuantityTypeIdentifierDistanceSwimming;
            break;
        case HKWorkoutActivityTypeWheelchairWalkPace:
        case HKWorkoutActivityTypeWheelchairRunPace:
            identifier = HKQuantityTypeIdentifierDistanceWheelchair;
            break;
        case HKWorkoutActivityTypeDownhillSkiing:
        case HKWorkoutActivityTypeSnowboarding:
            identifier = HKQuantityTypeIdentifierDistanceDownhillSnowSports;
            break;
        default:
            identifier = HKQuantityTypeIdentifierDistanceWalkingRunning;
            break;
    }
    return [HKQuantityType quantityTypeForIdentifier:identifier];
}

/*!
    HealthKit metadata can hold NSDate / HKQuantity values that cannot cross the bridge; convert
    them to strings and keep strings and numbers as they are.
 */
+ (NSDictionary *)jsonSafeMetadata:(NSDictionary *)metadata
{
    NSMutableDictionary *safe = [NSMutableDictionary dictionaryWithCapacity:metadata.count];
    for (id key in metadata) {
        if (![key isKindOfClass:[NSString class]]) {
            continue;
        }
        id value = metadata[key];
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            safe[key] = value;
        } else if ([value isKindOfClass:[NSDate class]]) {
            safe[key] = [RCTAppleHealthKit buildISO8601StringFromDate:value];
        } else if (value != nil) {
            safe[key] = [value description];
        }
    }
    return safe;
}

@end
