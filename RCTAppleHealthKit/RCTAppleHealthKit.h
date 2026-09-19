//
//  RCTAppleHealthKit.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTUtils.h>
#import <React/RCTLog.h>
#import <React/RCTEventDispatcher.h>

@interface RCTAppleHealthKit : RCTEventEmitter <RCTBridgeModule>

@property (nonatomic) HKHealthStore *healthStore;
@property (nonatomic, assign) BOOL hasListeners;

- (HKHealthStore *)_initializeHealthStore;
- (void)isHealthKitAvailable:(RCTResponseSenderBlock)callback;
- (void)initializeHealthKit:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)getModuleInfo:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)getAuthorizationStatus:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
/// Registers HealthKit background delivery observers. Call once at app launch, e.g. from
/// `application:didFinishLaunchingWithOptions:` (Swift: `RCTAppleHealthKit().initializeBackgroundObservers()`).
- (void)initializeBackgroundObservers;
/// Kept for source compatibility with the legacy bridge; the bridge argument is ignored.
- (void)initializeBackgroundObservers:(RCTBridge *)bridge __deprecated_msg("Use -initializeBackgroundObservers (no bridge argument).");
- (void)emitEventWithName:(NSString *)name andPayload:(NSDictionary *)payload;

@end
