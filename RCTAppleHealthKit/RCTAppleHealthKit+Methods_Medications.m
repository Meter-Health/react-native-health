//
//  RCTAppleHealthKit+Methods_Medications.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_Medications.h"
#import "RCTAppleHealthKit+Utils.h"

// Needs the iOS 26 SDK (Xcode 26). Older toolchains get stubs that report the feature as
// unavailable so the rest of the library still builds.
#if defined(__IPHONE_26_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_26_0
#define RNH_HAS_IOS26_SDK 1
#else
#define RNH_HAS_IOS26_SDK 0
#endif

static NSString *const kUnavailableMessage = @"The HealthKit Medications API requires iOS 26 or later";

#if RNH_HAS_IOS26_SDK

API_AVAILABLE(ios(26.0))
static NSDictionary<NSString *, NSNumber *> *LogStatuses(void) {
    return @{
        @"NotInteracted": @(HKMedicationDoseEventLogStatusNotInteracted),
        @"NotificationNotSent": @(HKMedicationDoseEventLogStatusNotificationNotSent),
        @"Snoozed": @(HKMedicationDoseEventLogStatusSnoozed),
        @"Taken": @(HKMedicationDoseEventLogStatusTaken),
        @"Skipped": @(HKMedicationDoseEventLogStatusSkipped),
        @"NotLogged": @(HKMedicationDoseEventLogStatusNotLogged),
    };
}

API_AVAILABLE(ios(26.0))
static NSDictionary<NSString *, NSNumber *> *ScheduleTypes(void) {
    return @{
        @"AsNeeded": @(HKMedicationDoseEventScheduleTypeAsNeeded),
        @"Schedule": @(HKMedicationDoseEventScheduleTypeSchedule),
    };
}

static NSString *NameForValue(NSDictionary<NSString *, NSNumber *> *map, NSInteger value) {
    for (NSString *name in map) {
        if ([map[name] integerValue] == value) {
            return name;
        }
    }
    return [NSString stringWithFormat:@"%ld", (long)value];
}

/*!
    HKHealthConceptIdentifier has no public string form. It does support secure coding, so the
    archived bytes (base64) are used as the id handed to JS; it round-trips through
    MedicationConceptIdentifierFromString for dose-event filtering.
 */
API_AVAILABLE(ios(26.0))
static NSString *StringFromMedicationConceptIdentifier(HKHealthConceptIdentifier *identifier) {
    NSError *error = nil;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:identifier requiringSecureCoding:YES error:&error];
    if (data == nil) {
        NSLog(@"[HealthKit] Could not archive medication identifier: %@", error);
        return @"";
    }
    return [data base64EncodedStringWithOptions:0];
}

API_AVAILABLE(ios(26.0))
static HKHealthConceptIdentifier *MedicationConceptIdentifierFromString(NSString *string) {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (data == nil) {
        return nil;
    }
    NSError *error = nil;
    HKHealthConceptIdentifier *identifier = [NSKeyedUnarchiver unarchivedObjectOfClass:[HKHealthConceptIdentifier class] fromData:data error:&error];
    if (identifier == nil) {
        NSLog(@"[HealthKit] Could not decode medication identifier: %@", error);
    }
    return identifier;
}

API_AVAILABLE(ios(26.0))
static NSDictionary *SerializeMedicationConcept(HKMedicationConcept *concept) {
    NSMutableArray *codings = [NSMutableArray array];
    for (HKClinicalCoding *coding in concept.relatedCodings) {
        [codings addObject:@{
            @"system": coding.system ?: @"",
            @"version": coding.version ?: [NSNull null],
            @"code": coding.code ?: @"",
        }];
    }
    return @{
        @"id": StringFromMedicationConceptIdentifier(concept.identifier),
        @"displayText": concept.displayText ?: @"",
        @"generalForm": concept.generalForm ?: @"",
        @"relatedCodings": codings,
    };
}

#endif // RNH_HAS_IOS26_SDK

@implementation RCTAppleHealthKit (Methods_Medications)

- (void)medications_getUserAnnotatedMedications:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
#if RNH_HAS_IOS26_SDK
    if (@available(iOS 26.0, *)) {
        NSMutableArray<NSPredicate *> *predicates = [NSMutableArray array];
        if ([input[@"isArchived"] isKindOfClass:[NSNumber class]]) {
            [predicates addObject:[HKQuery predicateForUserAnnotatedMedicationsWithIsArchived:[input[@"isArchived"] boolValue]]];
        }
        if ([input[@"hasSchedule"] isKindOfClass:[NSNumber class]]) {
            [predicates addObject:[HKQuery predicateForUserAnnotatedMedicationsWithHasSchedule:[input[@"hasSchedule"] boolValue]]];
        }
        NSPredicate *predicate = predicates.count > 0 ? [NSCompoundPredicate andPredicateWithSubpredicates:predicates] : nil;
        NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];

        NSMutableArray *data = [NSMutableArray array];
        HKUserAnnotatedMedicationQuery *query = [[HKUserAnnotatedMedicationQuery alloc] initWithPredicate:predicate
                                                                                                    limit:limit
                                                                                           resultsHandler:^(HKUserAnnotatedMedicationQuery *query,
                                                                                                            __kindof HKUserAnnotatedMedication * _Nullable medication,
                                                                                                            BOOL done,
                                                                                                            NSError * _Nullable error) {
            // Results are streamed one at a time; `done` marks the end of the list.
            if (error) {
                callback(@[RCTJSErrorFromNSError(error)]);
                return;
            }
            if (medication != nil) {
                [data addObject:@{
                    @"medication": SerializeMedicationConcept(medication.medication),
                    @"nickname": medication.nickname ?: [NSNull null],
                    @"isArchived": @(medication.isArchived),
                    @"hasSchedule": @(medication.hasSchedule),
                }];
            }
            if (done) {
                callback(@[[NSNull null], [data copy]]);
            }
        }];
        [self.healthStore executeQuery:query];
        return;
    }
#endif
    callback(@[RCTMakeError(kUnavailableMessage, nil, nil)]);
}

- (void)medications_getMedicationDoseEvents:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
#if RNH_HAS_IOS26_SDK
    if (@available(iOS 26.0, *)) {
        NSMutableArray<NSPredicate *> *predicates = [NSMutableArray array];

        NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
        NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
        if (startDate != nil) {
            [predicates addObject:[HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone]];
        }

        // Filter by the ids returned from getUserAnnotatedMedications
        id medicationIds = input[@"medicationIds"];
        if ([medicationIds isKindOfClass:[NSArray class]] && [medicationIds count] > 0) {
            NSMutableSet<HKHealthConceptIdentifier *> *identifiers = [NSMutableSet set];
            for (id medicationId in (NSArray *)medicationIds) {
                HKHealthConceptIdentifier *identifier = [medicationId isKindOfClass:[NSString class]] ? MedicationConceptIdentifierFromString(medicationId) : nil;
                if (identifier == nil) {
                    callback(@[RCTMakeError([NSString stringWithFormat:@"Invalid medication id: %@", medicationId], nil, nil)]);
                    return;
                }
                [identifiers addObject:identifier];
            }
            [predicates addObject:[HKQuery predicateForMedicationDoseEventWithMedicationConceptIdentifiers:identifiers]];
        }

        // Filter by log status ("Taken", "Skipped", ...); a single name or an array of names
        id logStatus = input[@"logStatus"];
        if ([logStatus isKindOfClass:[NSString class]]) {
            logStatus = @[logStatus];
        }
        if ([logStatus isKindOfClass:[NSArray class]] && [logStatus count] > 0) {
            NSMutableSet<NSNumber *> *statuses = [NSMutableSet set];
            for (id name in (NSArray *)logStatus) {
                NSNumber *status = [name isKindOfClass:[NSString class]] ? LogStatuses()[name] : nil;
                if (status == nil) {
                    callback(@[RCTMakeError([NSString stringWithFormat:@"Unknown logStatus: %@", name], nil, nil)]);
                    return;
                }
                [statuses addObject:status];
            }
            [predicates addObject:[HKQuery predicateForMedicationDoseEventWithStatuses:statuses]];
        }

        NSPredicate *predicate = predicates.count > 0 ? [NSCompoundPredicate andPredicateWithSubpredicates:predicates] : nil;
        NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
        BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierStartDate ascending:ascending];

        HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:[HKObjectType medicationDoseEventType]
                                                               predicate:predicate
                                                                   limit:limit
                                                         sortDescriptors:@[sort]
                                                          resultsHandler:^(HKSampleQuery *query, NSArray<__kindof HKSample *> *results, NSError *error) {
            if (error) {
                callback(@[RCTJSErrorFromNSError(error)]);
                return;
            }
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:results.count];
            for (HKMedicationDoseEvent *event in results) {
                [data addObject:@{
                    @"id": [[event UUID] UUIDString],
                    @"medicationId": StringFromMedicationConceptIdentifier(event.medicationConceptIdentifier),
                    @"scheduleType": NameForValue(ScheduleTypes(), event.scheduleType),
                    @"logStatus": NameForValue(LogStatuses(), event.logStatus),
                    @"scheduledDate": event.scheduledDate ? [RCTAppleHealthKit buildISO8601StringFromDate:event.scheduledDate] : [NSNull null],
                    @"scheduledDoseQuantity": event.scheduledDoseQuantity ?: [NSNull null],
                    @"doseQuantity": event.doseQuantity ?: [NSNull null],
                    @"unit": [event.unit unitString] ?: @"",
                    @"startDate": [RCTAppleHealthKit buildISO8601StringFromDate:event.startDate],
                    @"endDate": [RCTAppleHealthKit buildISO8601StringFromDate:event.endDate],
                    @"sourceName": [[[event sourceRevision] source] name] ?: @"",
                    @"sourceId": [[[event sourceRevision] source] bundleIdentifier] ?: @"",
                    @"metadata": [RCTAppleHealthKit jsonSafeMetadata:event.metadata],
                }];
            }
            callback(@[[NSNull null], data]);
        }];
        [self.healthStore executeQuery:query];
        return;
    }
#endif
    callback(@[RCTMakeError(kUnavailableMessage, nil, nil)]);
}

@end
