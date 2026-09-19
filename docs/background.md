# Background Observers

An observer is responsible by constantly listen to Apple HealthKit updates in the
background and notify your app in case any new data sample was added. The
background notification is handled by iOS and the following steps show how to
detect these changes using the react-native-health library.

Currently, the supported data identifiers that can be observed are the
following:

- `ActiveEnergyBurned`
- `BasalEnergyBurned`
- `Cycling`
- `InsulinDelivery`
- `HeartRate`
- `HeartRateVariabilitySDNN`
- `RestingHeartRate`
- `Running`
- `StairClimbing`
- `StepCount`
- `Swimming`
- `Vo2Max`
- `Walking`
- `Workout`

### Initialization

If you followed the [Background Processing](https://github.com/Meter-Health/react-native-health#background-processing)
step in the README, you can skip this one.

Register the observers once at app launch, from `application:didFinishLaunchingWithOptions:`.

`AppDelegate.swift` (React Native 0.77+ template):

```swift
import RNAppleHealthKit

@main
class AppDelegate: RCTAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    /* Add Background initializer for HealthKit */
    RCTAppleHealthKit().initializeBackgroundObservers()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

`AppDelegate.mm` (Objective-C):

```objective-c
#import <RNAppleHealthKit/RCTAppleHealthKit.h>

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  /* Add Background initializer for HealthKit */
  [[RCTAppleHealthKit new] initializeBackgroundObservers];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
```

Expo: set `enableBackgroundObservers: true` on the config plugin instead of editing
the AppDelegate (see [Expo](./Expo.md)).

Also enable the HealthKit **Background Delivery** capability for the app target
(`com.apple.developer.healthkit.background-delivery` entitlement); without it iOS
will not wake the app for new samples.

After that, your app is ready to start listening for data updates using the
React Native client.

### Handling the updates

This library sends events to your app through the module's event emitter. To
intercept those, subscribe with a `NativeEventEmitter` created from the module.

They follow events are triggered by the library

| Event                                     | When is triggered?                                                              |
| ----------------------------------------- | ------------------------------------------------------------------------------- |
| `healthKit:<OBSERVER_TYPE>:setup:success` | When the background observer for that type is successfuly setup                 |
| `healthKit:<OBSERVER_TYPE>:setup:failure` | When the background observer for that type is not successfuly setup             |
| `healthKit:<OBSERVER_TYPE>:new`           | When the background observer received a new data sample for that type           |
| `healthKit:<OBSERVER_TYPE>:failure`       | When the background observer received a new data sample, but an error was found |

Note that the `<OBSERVER_TYPE>` token should be replaced with one of
the available types presented in the first section. As an example, if setting
up observers for workouts, the events would have the following names:

- `healthKit:Workout:setup:success`
- `healthKit:Workout:setup:failure`
- `healthKit:Workout:new`
- `healthKit:Workout:failure`

### Example

```typescript
import React, { useEffect } from 'react';
import { NativeEventEmitter, NativeModules } from 'react-native';

useEffect(() => {
  const subscription = new NativeEventEmitter(
    NativeModules.AppleHealthKit,
  ).addListener('healthKit:HeartRate:new', async () => {
    console.log('--> observer triggered');
  });

  return () => subscription.remove();
}, []);
```

When a new sample appears, in order to get the information you need to call
the [getSamples](./getSamples.md) or the [getClinicalRecords](./getClinicalRecords.md) method from your callback function.

**Note** - Some HealthKit data types have a minimum update frequency of an
hour. Even setting up an observer, it might take some moment until your
app is notified by the HealthKit

### More Information

- [Executing Observer Queries](https://developer.apple.com/documentation/healthkit/hkobserverquery/executing_observer_queries)
- [Background Delivery](https://stackoverflow.com/questions/26375767/healthkit-background-delivery-when-app-is-not-running)
- [enableBackgroundDeliveryForType](https://developer.apple.com/documentation/healthkit/hkhealthstore/1614175-enablebackgrounddeliveryfortype?language=objc)
