//
//  RCTAppleHealthKit+Methods_MentalWellbeing.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_MentalWellbeing.h"
#import "RCTAppleHealthKit+Utils.h"

// Everything in here needs the iOS 18 SDK (Xcode 16+). Older toolchains get stubs that report
// the feature as unavailable so the rest of the library still builds.
#if defined(__IPHONE_18_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_18_0
#define RNH_HAS_IOS18_SDK 1
#else
#define RNH_HAS_IOS18_SDK 0
#endif

static NSString *const kUnavailableMessage = @"State of Mind and scored assessments require iOS 18 or later";

#if RNH_HAS_IOS18_SDK

API_AVAILABLE(ios(18.0))
static NSDictionary<NSString *, NSNumber *> *StateOfMindKinds(void) {
    return @{
        @"MomentaryEmotion": @(HKStateOfMindKindMomentaryEmotion),
        @"DailyMood": @(HKStateOfMindKindDailyMood),
    };
}

API_AVAILABLE(ios(18.0))
static NSDictionary<NSString *, NSNumber *> *StateOfMindValenceClassifications(void) {
    return @{
        @"VeryUnpleasant": @(HKStateOfMindValenceClassificationVeryUnpleasant),
        @"Unpleasant": @(HKStateOfMindValenceClassificationUnpleasant),
        @"SlightlyUnpleasant": @(HKStateOfMindValenceClassificationSlightlyUnpleasant),
        @"Neutral": @(HKStateOfMindValenceClassificationNeutral),
        @"SlightlyPleasant": @(HKStateOfMindValenceClassificationSlightlyPleasant),
        @"Pleasant": @(HKStateOfMindValenceClassificationPleasant),
        @"VeryPleasant": @(HKStateOfMindValenceClassificationVeryPleasant),
    };
}

API_AVAILABLE(ios(18.0))
static NSDictionary<NSString *, NSNumber *> *StateOfMindLabels(void) {
    return @{
        @"Amazed": @(HKStateOfMindLabelAmazed),
        @"Amused": @(HKStateOfMindLabelAmused),
        @"Angry": @(HKStateOfMindLabelAngry),
        @"Anxious": @(HKStateOfMindLabelAnxious),
        @"Ashamed": @(HKStateOfMindLabelAshamed),
        @"Brave": @(HKStateOfMindLabelBrave),
        @"Calm": @(HKStateOfMindLabelCalm),
        @"Content": @(HKStateOfMindLabelContent),
        @"Disappointed": @(HKStateOfMindLabelDisappointed),
        @"Discouraged": @(HKStateOfMindLabelDiscouraged),
        @"Disgusted": @(HKStateOfMindLabelDisgusted),
        @"Embarrassed": @(HKStateOfMindLabelEmbarrassed),
        @"Excited": @(HKStateOfMindLabelExcited),
        @"Frustrated": @(HKStateOfMindLabelFrustrated),
        @"Grateful": @(HKStateOfMindLabelGrateful),
        @"Guilty": @(HKStateOfMindLabelGuilty),
        @"Happy": @(HKStateOfMindLabelHappy),
        @"Hopeless": @(HKStateOfMindLabelHopeless),
        @"Irritated": @(HKStateOfMindLabelIrritated),
        @"Jealous": @(HKStateOfMindLabelJealous),
        @"Joyful": @(HKStateOfMindLabelJoyful),
        @"Lonely": @(HKStateOfMindLabelLonely),
        @"Passionate": @(HKStateOfMindLabelPassionate),
        @"Peaceful": @(HKStateOfMindLabelPeaceful),
        @"Proud": @(HKStateOfMindLabelProud),
        @"Relieved": @(HKStateOfMindLabelRelieved),
        @"Sad": @(HKStateOfMindLabelSad),
        @"Scared": @(HKStateOfMindLabelScared),
        @"Stressed": @(HKStateOfMindLabelStressed),
        @"Surprised": @(HKStateOfMindLabelSurprised),
        @"Worried": @(HKStateOfMindLabelWorried),
        @"Annoyed": @(HKStateOfMindLabelAnnoyed),
        @"Confident": @(HKStateOfMindLabelConfident),
        @"Drained": @(HKStateOfMindLabelDrained),
        @"Hopeful": @(HKStateOfMindLabelHopeful),
        @"Indifferent": @(HKStateOfMindLabelIndifferent),
        @"Overwhelmed": @(HKStateOfMindLabelOverwhelmed),
        @"Satisfied": @(HKStateOfMindLabelSatisfied),
    };
}

API_AVAILABLE(ios(18.0))
static NSDictionary<NSString *, NSNumber *> *StateOfMindAssociations(void) {
    return @{
        @"Community": @(HKStateOfMindAssociationCommunity),
        @"CurrentEvents": @(HKStateOfMindAssociationCurrentEvents),
        @"Dating": @(HKStateOfMindAssociationDating),
        @"Education": @(HKStateOfMindAssociationEducation),
        @"Family": @(HKStateOfMindAssociationFamily),
        @"Fitness": @(HKStateOfMindAssociationFitness),
        @"Friends": @(HKStateOfMindAssociationFriends),
        @"Health": @(HKStateOfMindAssociationHealth),
        @"Hobbies": @(HKStateOfMindAssociationHobbies),
        @"Identity": @(HKStateOfMindAssociationIdentity),
        @"Money": @(HKStateOfMindAssociationMoney),
        @"Partner": @(HKStateOfMindAssociationPartner),
        @"SelfCare": @(HKStateOfMindAssociationSelfCare),
        @"Spirituality": @(HKStateOfMindAssociationSpirituality),
        @"Tasks": @(HKStateOfMindAssociationTasks),
        @"Travel": @(HKStateOfMindAssociationTravel),
        @"Work": @(HKStateOfMindAssociationWork),
        @"Weather": @(HKStateOfMindAssociationWeather),
    };
}

API_AVAILABLE(ios(18.0))
static NSDictionary<NSString *, NSNumber *> *GAD7Risks(void) {
    return @{
        @"NoneToMinimal": @(HKGAD7AssessmentRiskNoneToMinimal),
        @"Mild": @(HKGAD7AssessmentRiskMild),
        @"Moderate": @(HKGAD7AssessmentRiskModerate),
        @"Severe": @(HKGAD7AssessmentRiskSevere),
    };
}

API_AVAILABLE(ios(18.0))
static NSDictionary<NSString *, NSNumber *> *PHQ9Risks(void) {
    return @{
        @"NoneToMinimal": @(HKPHQ9AssessmentRiskNoneToMinimal),
        @"Mild": @(HKPHQ9AssessmentRiskMild),
        @"Moderate": @(HKPHQ9AssessmentRiskModerate),
        @"ModeratelySevere": @(HKPHQ9AssessmentRiskModeratelySevere),
        @"Severe": @(HKPHQ9AssessmentRiskSevere),
    };
}

/// Reverse lookup: enum value -> JS name (falls back to the number as a string).
static NSString *NameForValue(NSDictionary<NSString *, NSNumber *> *map, NSInteger value) {
    for (NSString *name in map) {
        if ([map[name] integerValue] == value) {
            return name;
        }
    }
    return [NSString stringWithFormat:@"%ld", (long)value];
}

/// Maps an array of JS names (or raw numbers) to enum values. Unknown names are reported through `error`.
static NSArray<NSNumber *> *ValuesForNames(NSDictionary<NSString *, NSNumber *> *map, id names, NSString *what, NSString **error) {
    NSMutableArray *values = [NSMutableArray array];
    if (names == nil || names == [NSNull null]) {
        return values;
    }
    if (![names isKindOfClass:[NSArray class]]) {
        *error = [NSString stringWithFormat:@"%@ must be an array", what];
        return nil;
    }
    for (id name in (NSArray *)names) {
        if ([name isKindOfClass:[NSNumber class]]) {
            [values addObject:name];
        } else if ([name isKindOfClass:[NSString class]] && map[name] != nil) {
            [values addObject:map[name]];
        } else {
            *error = [NSString stringWithFormat:@"Unknown %@: %@", what, name];
            return nil;
        }
    }
    return values;
}

static NSArray<NSString *> *NamesForValues(NSDictionary<NSString *, NSNumber *> *map, NSArray<NSNumber *> *values) {
    NSMutableArray *names = [NSMutableArray arrayWithCapacity:values.count];
    for (NSNumber *value in values) {
        [names addObject:NameForValue(map, [value integerValue])];
    }
    return names;
}

#endif // RNH_HAS_IOS18_SDK

@implementation RCTAppleHealthKit (Methods_MentalWellbeing)

#if RNH_HAS_IOS18_SDK

- (NSDictionary *)mentalWellbeing_baseFieldsForSample:(HKSample *)sample
{
    return @{
        @"id": [[sample UUID] UUIDString],
        @"startDate": [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate],
        @"endDate": [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate],
        @"sourceName": [[[sample sourceRevision] source] name] ?: @"",
        @"sourceId": [[[sample sourceRevision] source] bundleIdentifier] ?: @"",
        @"metadata": [RCTAppleHealthKit jsonSafeMetadata:sample.metadata],
    };
}

- (void)mentalWellbeing_runQueryForType:(HKSampleType *)type
                                  input:(NSDictionary *)input
                              predicate:(NSPredicate *)predicate
                              serialize:(NSDictionary *(^)(HKSample *sample))serialize
                               callback:(RCTResponseSenderBlock)callback
{
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierStartDate ascending:ascending];

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:type
                                                           predicate:predicate
                                                               limit:limit
                                                     sortDescriptors:@[sort]
                                                      resultsHandler:^(HKSampleQuery *query, NSArray<__kindof HKSample *> *results, NSError *error) {
        if (error) {
            callback(@[RCTJSErrorFromNSError(error)]);
            return;
        }
        NSMutableArray *data = [NSMutableArray arrayWithCapacity:results.count];
        for (HKSample *sample in results) {
            [data addObject:serialize(sample)];
        }
        callback(@[[NSNull null], data]);
    }];
    [self.healthStore executeQuery:query];
}

- (NSPredicate *)mentalWellbeing_datePredicateFromOptions:(NSDictionary *)input
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if (startDate == nil) {
        return nil;
    }
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
}

#endif

#pragma mark - State of Mind

- (void)mentalWellbeing_getStateOfMindSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
#if RNH_HAS_IOS18_SDK
    if (@available(iOS 18.0, *)) {
        NSMutableArray<NSPredicate *> *predicates = [NSMutableArray array];
        NSPredicate *datePredicate = [self mentalWellbeing_datePredicateFromOptions:input];
        if (datePredicate) {
            [predicates addObject:datePredicate];
        }
        NSString *kindName = [RCTAppleHealthKit stringFromOptions:input key:@"kind" withDefault:nil];
        if (kindName != nil) {
            NSNumber *kind = StateOfMindKinds()[kindName];
            if (kind == nil) {
                callback(@[RCTMakeError([NSString stringWithFormat:@"Unknown State of Mind kind: %@", kindName], nil, nil)]);
                return;
            }
            [predicates addObject:[HKQuery predicateForStatesOfMindWithKind:(HKStateOfMindKind)[kind integerValue]]];
        }
        NSPredicate *predicate = predicates.count > 0 ? [NSCompoundPredicate andPredicateWithSubpredicates:predicates] : nil;

        [self mentalWellbeing_runQueryForType:[HKObjectType stateOfMindType]
                                        input:input
                                    predicate:predicate
                                    serialize:^NSDictionary *(HKSample *sample) {
            HKStateOfMind *stateOfMind = (HKStateOfMind *)sample;
            NSMutableDictionary *elem = [[self mentalWellbeing_baseFieldsForSample:sample] mutableCopy];
            elem[@"kind"] = NameForValue(StateOfMindKinds(), stateOfMind.kind);
            elem[@"valence"] = @(stateOfMind.valence);
            elem[@"valenceClassification"] = NameForValue(StateOfMindValenceClassifications(), stateOfMind.valenceClassification);
            elem[@"labels"] = NamesForValues(StateOfMindLabels(), stateOfMind.labels);
            elem[@"associations"] = NamesForValues(StateOfMindAssociations(), stateOfMind.associations);
            return elem;
        }
                                     callback:callback];
        return;
    }
#endif
    callback(@[RCTMakeError(kUnavailableMessage, nil, nil)]);
}

- (void)mentalWellbeing_saveStateOfMind:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
#if RNH_HAS_IOS18_SDK
    if (@available(iOS 18.0, *)) {
        NSDate *date = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];
        NSString *kindName = [RCTAppleHealthKit stringFromOptions:input key:@"kind" withDefault:@"MomentaryEmotion"];
        NSNumber *kind = StateOfMindKinds()[kindName];
        if (kind == nil) {
            callback(@[RCTMakeError([NSString stringWithFormat:@"Unknown State of Mind kind: %@", kindName], nil, nil)]);
            return;
        }
        NSNumber *valenceNumber = [input objectForKey:@"valence"];
        if (![valenceNumber isKindOfClass:[NSNumber class]]) {
            callback(@[RCTMakeError(@"valence (a number between -1 and 1) is required in options", nil, nil)]);
            return;
        }
        double valence = MAX(-1.0, MIN(1.0, [valenceNumber doubleValue]));

        NSString *error = nil;
        NSArray<NSNumber *> *labels = ValuesForNames(StateOfMindLabels(), input[@"labels"], @"label", &error);
        if (error) {
            callback(@[RCTMakeError(error, nil, nil)]);
            return;
        }
        NSArray<NSNumber *> *associations = ValuesForNames(StateOfMindAssociations(), input[@"associations"], @"association", &error);
        if (error) {
            callback(@[RCTMakeError(error, nil, nil)]);
            return;
        }
        NSDictionary *metadata = [input[@"metadata"] isKindOfClass:[NSDictionary class]] ? input[@"metadata"] : nil;

        HKStateOfMind *sample = [HKStateOfMind stateOfMindWithDate:date
                                                              kind:(HKStateOfMindKind)[kind integerValue]
                                                           valence:valence
                                                            labels:labels
                                                      associations:associations
                                                          metadata:metadata];
        [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *saveError) {
            if (!success) {
                callback(@[RCTJSErrorFromNSError(saveError)]);
                return;
            }
            callback(@[[NSNull null], [[sample UUID] UUIDString]]);
        }];
        return;
    }
#endif
    callback(@[RCTMakeError(kUnavailableMessage, nil, nil)]);
}

#pragma mark - Scored assessments (GAD-7 / PHQ-9)

- (void)mentalWellbeing_getScoredAssessments:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
#if RNH_HAS_IOS18_SDK
    if (@available(iOS 18.0, *)) {
        NSString *typeName = [RCTAppleHealthKit stringFromOptions:input key:@"type" withDefault:@"GAD7"];
        BOOL isGAD7 = [typeName isEqualToString:@"GAD7"];
        BOOL isPHQ9 = [typeName isEqualToString:@"PHQ9"];
        if (!isGAD7 && !isPHQ9) {
            callback(@[RCTMakeError(@"type must be 'GAD7' or 'PHQ9'", nil, nil)]);
            return;
        }
        HKScoredAssessmentType *type = [HKObjectType scoredAssessmentTypeForIdentifier:isGAD7 ? HKScoredAssessmentTypeIdentifierGAD7 : HKScoredAssessmentTypeIdentifierPHQ9];

        [self mentalWellbeing_runQueryForType:type
                                        input:input
                                    predicate:[self mentalWellbeing_datePredicateFromOptions:input]
                                    serialize:^NSDictionary *(HKSample *sample) {
            NSMutableDictionary *elem = [[self mentalWellbeing_baseFieldsForSample:sample] mutableCopy];
            elem[@"type"] = typeName;
            elem[@"score"] = @([(HKScoredAssessment *)sample score]);
            if (isGAD7) {
                HKGAD7Assessment *assessment = (HKGAD7Assessment *)sample;
                elem[@"risk"] = NameForValue(GAD7Risks(), assessment.risk);
                elem[@"answers"] = assessment.answers;
            } else {
                HKPHQ9Assessment *assessment = (HKPHQ9Assessment *)sample;
                elem[@"risk"] = NameForValue(PHQ9Risks(), assessment.risk);
                elem[@"answers"] = assessment.answers;
            }
            return elem;
        }
                                     callback:callback];
        return;
    }
#endif
    callback(@[RCTMakeError(kUnavailableMessage, nil, nil)]);
}

- (void)mentalWellbeing_saveScoredAssessment:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
#if RNH_HAS_IOS18_SDK
    if (@available(iOS 18.0, *)) {
        NSString *typeName = [RCTAppleHealthKit stringFromOptions:input key:@"type" withDefault:@""];
        BOOL isGAD7 = [typeName isEqualToString:@"GAD7"];
        BOOL isPHQ9 = [typeName isEqualToString:@"PHQ9"];
        if (!isGAD7 && !isPHQ9) {
            callback(@[RCTMakeError(@"type must be 'GAD7' or 'PHQ9'", nil, nil)]);
            return;
        }
        NSDate *date = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];
        NSDictionary *metadata = [input[@"metadata"] isKindOfClass:[NSDictionary class]] ? input[@"metadata"] : nil;

        // GAD-7: 7 answers 0-3. PHQ-9: 9 answers 0-3, 4 = "prefer not to answer".
        NSUInteger expectedCount = isGAD7 ? 7 : 9;
        NSInteger maxAnswer = isGAD7 ? HKGAD7AssessmentAnswerNearlyEveryDay : HKPHQ9AssessmentAnswerPreferNotToAnswer;
        id answers = input[@"answers"];
        if (![answers isKindOfClass:[NSArray class]] || [answers count] != expectedCount) {
            callback(@[RCTMakeError([NSString stringWithFormat:@"answers must be an array of %lu numbers", (unsigned long)expectedCount], nil, nil)]);
            return;
        }
        for (id answer in (NSArray *)answers) {
            if (![answer isKindOfClass:[NSNumber class]] || [answer integerValue] < 0 || [answer integerValue] > maxAnswer) {
                callback(@[RCTMakeError([NSString stringWithFormat:@"answers must be integers between 0 and %ld", (long)maxAnswer], nil, nil)]);
                return;
            }
        }

        HKScoredAssessment *sample;
        if (isGAD7) {
            sample = [HKGAD7Assessment assessmentWithDate:date answers:answers metadata:metadata];
        } else {
            sample = [HKPHQ9Assessment assessmentWithDate:date answers:answers metadata:metadata];
        }

        [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *saveError) {
            if (!success) {
                callback(@[RCTJSErrorFromNSError(saveError)]);
                return;
            }
            callback(@[[NSNull null], @{ @"id": [[sample UUID] UUIDString], @"score": @(sample.score) }]);
        }];
        return;
    }
#endif
    callback(@[RCTMakeError(kUnavailableMessage, nil, nil)]);
}

@end
