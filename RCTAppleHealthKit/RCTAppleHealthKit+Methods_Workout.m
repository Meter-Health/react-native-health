//
//  RCTAppleHealthKit+Methods_Workout.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_Workout.h"
#import "RCTAppleHealthKit+Utils.h"
#import "RCTAppleHealthKit+Queries.h"

@implementation RCTAppleHealthKit (Methods_Workout)


- (void)workout_getRoute:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{

    NSString *uid = [RCTAppleHealthKit stringFromOptions:input key:@"id" withDefault:@""];
    
    NSUUID *uuid;
    
    @try {
        uuid = [[NSUUID alloc] initWithUUIDString:uid];
    } @catch (NSException *exception) {
        callback(@[RCTMakeError(@"Error converting id to uuid", nil, nil)]);
        return;
    }
    
    if(!uuid){
        callback(@[RCTMakeError(@"An id is required", nil, nil)]);
        return;
    }

    NSPredicate *predicate = [HKQuery predicateForObjectWithUUID:uuid];

    HKSampleType *samplesType = [HKSampleType workoutType];

    void (^completion)(NSArray *results, NSError *error);

    completion = ^(NSArray *results, NSError *error) {
        if (results){
            
            //only one workout should return from the query
            for (HKWorkout *sample in results) {
                // do something with object
                HKSampleType *type = [HKSeriesType workoutRouteType];

                NSPredicate *pre = [HKQuery predicateForObjectsFromWorkout:sample];
                
                void (^routeCompletion)(NSDictionary *results, NSError *error);

                routeCompletion = ^(NSDictionary *results, NSError *error) {
                    if (results){
                        callback(@[[NSNull null], results]);
                        
                        return;
                    } else {
                        NSLog(@"error getting samples: %@", error);
                        callback(@[RCTMakeError(@"error getting samples. Activity possibly does not have a route.", error, nil)]);
                        return;
                    }
                };
                
                
                [self fetchWorkoutRoute:type
                                  predicate:pre
                                     anchor:nil
                                      limit:HKObjectQueryNoLimit
                                 completion:routeCompletion];
                
                break;
            }
            
        } else {
            NSLog(@"error getting samples: %@", error);
            callback(@[RCTMakeError(@"error getting samples:", error, nil)]);

            return;
        }
    };


    [self fetchWorkoutById:samplesType
                        unit:[HKUnit countUnit]
                   predicate:predicate
                   ascending:false
                       limit:HKObjectQueryNoLimit
                  completion:completion];
}


- (void)workout_getAnchoredQuery:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    
    HKSampleType *workoutType = [HKObjectType workoutType];
    HKQueryAnchor *anchor = [RCTAppleHealthKit hkAnchorFromOptions:input];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    
    NSPredicate *predicate = [RCTAppleHealthKit predicateForAnchoredQueries:anchor startDate:startDate endDate:endDate];

    void (^completion)(NSDictionary *results, NSError *error);

    completion = ^(NSDictionary *results, NSError *error) {
        if (results){
            callback(@[[NSNull null], results]);

            return;
        } else {
            NSLog(@"error getting samples: %@", error);
            callback(@[RCTMakeError(@"error getting samples", error, nil)]);

            return;
        }
    };

    [self fetchAnchoredWorkouts:workoutType
                      predicate:predicate
                         anchor:anchor
                          limit:limit
                     completion:completion];
}

- (void)workout_save: (NSDictionary *)input callback: (RCTResponseSenderBlock)callback {
    HKWorkoutActivityType type = [RCTAppleHealthKit hkWorkoutActivityTypeFromOptions:input key:@"type" withDefault:HKWorkoutActivityTypeAmericanFootball];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:nil];
    HKQuantity *totalEnergyBurned = [RCTAppleHealthKit hkQuantityFromOptions:input valueKey:@"energyBurned" unitKey:@"energyBurnedUnit"];
    HKQuantity *totalDistance = [RCTAppleHealthKit hkQuantityFromOptions:input valueKey:@"distance" unitKey:@"distanceUnit"];

    if (startDate == nil || endDate == nil) {
        callback(@[RCTMakeError(@"startDate and endDate are required in options", nil, nil)]);
        return;
    }
    if ([endDate compare:startDate] == NSOrderedAscending) {
        callback(@[RCTMakeError(@"endDate must not be before startDate", nil, nil)]);
        return;
    }

    // +[HKWorkout workoutWithActivityType:...] is deprecated since iOS 17. HKWorkoutBuilder is the
    // replacement: totals are recorded as samples attached to the workout, which is also what the
    // statistics-based readers (see workoutTotalEnergyBurned:unit:) expect.
    HKWorkoutConfiguration *configuration = [[HKWorkoutConfiguration alloc] init];
    configuration.activityType = type;

    HKWorkoutBuilder *builder = [[HKWorkoutBuilder alloc] initWithHealthStore:self.healthStore
                                                                configuration:configuration
                                                                       device:nil];

    NSMutableArray<HKSample *> *samples = [NSMutableArray array];
    if (totalEnergyBurned != nil) {
        HKQuantityType *energyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
        if ([totalEnergyBurned isCompatibleWithUnit:[HKUnit kilocalorieUnit]]) {
            [samples addObject:[HKQuantitySample quantitySampleWithType:energyType quantity:totalEnergyBurned startDate:startDate endDate:endDate]];
        } else {
            callback(@[RCTMakeError(@"energyBurnedUnit must be an energy unit", nil, nil)]);
            return;
        }
    }
    if (totalDistance != nil) {
        HKQuantityType *distanceType = [RCTAppleHealthKit distanceQuantityTypeForWorkoutActivityType:type];
        if ([totalDistance isCompatibleWithUnit:[HKUnit meterUnit]]) {
            [samples addObject:[HKQuantitySample quantitySampleWithType:distanceType quantity:totalDistance startDate:startDate endDate:endDate]];
        } else {
            callback(@[RCTMakeError(@"distanceUnit must be a length unit", nil, nil)]);
            return;
        }
    }

    void (^fail)(NSString *, NSError *) = ^(NSString *message, NSError *error) {
        NSLog(@"An error occured saving the workout. %@: %@.", message, error);
        [builder discardWorkout];
        callback(@[RCTMakeError(message, error, nil)]);
    };

    void (^finish)(void) = ^{
        [builder endCollectionWithEndDate:endDate completion:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                fail(@"An error occured ending the workout", error);
                return;
            }
            [builder finishWorkoutWithCompletion:^(HKWorkout * _Nullable workout, NSError * _Nullable error) {
                if (workout == nil) {
                    fail(@"An error occured saving the workout", error);
                    return;
                }
                callback(@[[NSNull null], [[workout UUID] UUIDString]]);
            }];
        }];
    };

    [builder beginCollectionWithStartDate:startDate completion:^(BOOL success, NSError * _Nullable error) {
        if (!success) {
            fail(@"An error occured starting the workout", error);
            return;
        }
        if (samples.count == 0) {
            finish();
            return;
        }
        [builder addSamples:samples completion:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                fail(@"An error occured adding workout samples", error);
                return;
            }
            finish();
        }];
    }];
}
@end
