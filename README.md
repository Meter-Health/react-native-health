<img style="float: left;" src="https://i.imgur.com/q5PS8gU.png">

# React Native Health

A React Native package to interact with Apple HealthKit for iOS. Maintained with ❤️ by [AE Studio](https://ae.studio).

This package allows access to health & fitness data exposed by Apple Healthkit. You can see the methods available [here](https://github.com/agencyenterprise/react-native-health#documentation).

If you are looking for a more robust solution providing normalized data, insights and recommendations based on user's biometric data, data from multiple sources (Fitbit, Oura), or a hosted solution, please check out the [Point SDK](https://www.areyouonpoint.co/) developed by our frens.

---
## METER HEALTH
### Fork changelog:

#### 2.0.0

- **New Architecture / TurboModule support.** The module ships a codegen spec
  (`src/NativeAppleHealthKit.ts`) and is registered as a TurboModule, so it works
  in bridgeless mode (React Native 0.76+ / Expo SDK 52+) without the interop layer.
  The JS API is unchanged.
- Background observers no longer need the bridge:
  `initializeBackgroundObservers()` replaces `initializeBackgroundObservers:bridge`
  (the old selector still exists but ignores its argument). Events are delivered
  through the regular `NativeEventEmitter` in both architectures.
- Expo config plugin: new `enableBackgroundObservers` option that wires the
  AppDelegate call and the background-delivery entitlement for you.
- HealthKit API updates: `saveWorkout` uses `HKWorkoutBuilder` (the `HKWorkout`
  initializer is deprecated since iOS 17), workout energy/distance are read from
  workout statistics (`totalEnergyBurned`/`totalDistance` are deprecated since
  iOS 18), and the `SwimBikeRun`, `Transition`, `UnderwaterDiving` and `Other`
  activity types were added.
- HealthKit data types brought up to the iOS 26 SDK: 43 additional quantity types
  (cycling power/cadence/speed/FTP, physical effort, time in daylight, workout effort
  score, mobility metrics, HRR, AFib burden, sleeping wrist temperature, breathing
  disturbances, cross-country skiing / rowing / paddle / skating distance & speed, ...)
  and 68 category types (symptoms, heart / hearing / mobility events, sleep apnea,
  hypertension, reproductive health, ...) are now requestable as permissions and
  readable through `getSamples`. Read-only Apple types are filtered out of write
  permissions instead of failing the whole authorization request.
- `getSamples` accepts any readable permission name, picks a fitting unit when none
  (or an incompatible one) is given, and returns category samples with their `value`.
- More units (`watt`, `rpm`, `meterPerSecond`, `kmPerHour`, `kcalPerKgHour`,
  `appleEffortScore`, ...), plus any raw HealthKit unit string.
- New APIs: State of Mind (`getStateOfMindSamples` / `saveStateOfMind`), GAD-7 & PHQ-9
  scored assessments (`getScoredAssessments` / `saveScoredAssessment`) on iOS 18+, and
  the read-only Medications API (`getUserAnnotatedMedications` /
  `getMedicationDoseEvents`) on iOS 26+. Permissions: `StateOfMind`, `GAD7Assessment`,
  `PHQ9Assessment`, `MedicationDoseEvent`, `UserAnnotatedMedications`. On older iOS the
  methods return an error instead of crashing; building them needs Xcode 16 / Xcode 26
  respectively (older SDKs compile them out).
- Requires React Native >= 0.71 and iOS 15.1+.
- Breaking: `saveWorkout` now needs write permission for `ActiveEnergyBurned`
  (when `energyBurned` is given) and the matching distance type (when `distance`
  is given), in addition to `Workout`.

#### 1.x

- Added save functions for:
  - Heartrate variability
  - Resting heartrate
  - Active Energy
  - Basal Energy
  - Vo2Max
  - OxygenSaturation
  - Respiratory rate
  - SleepAnalysis

---

# New Version

(August 2023)

We're thrilled to share that we're in the midst of creating a significant update for this library. The upcoming version will be crafted using Swift (bye-bye, Objective-C! 👋) and will showcase a fresh new interface.

We're currently preparing to make it available for opt-in users in the near future, and we're extending a warm invitation for you all to join us in shaping this endeavor.

As we are fully focused in it, we're temporarily holding off on introducing new features. However, we're eagerly welcoming pull requests that address critical bug fixes or tackle dependency issues. Your contributions will not only be highly appreciated but also swiftly integrated and deployed. 💖

# Discord

<a href="https://discord.gg/d24g5XDePr"><img src="https://img.shields.io/badge/Discord-join%20chat-738bd7.svg" alt="React Native Health official Discord"></a>

## Getting Started

> 🚨 Expo: This package is not available in the [Expo Go](https://expo.io/client) app. Learn how you can use it with [custom dev clients](/docs/Expo.md).

### Automatic Installation

1. Install the react-native-health package from [npm](https://www.npmjs.com/package/react-native-health)

```
yarn add react-native-health
```

2. If you are using [CocoaPods](https://cocoapods.org/) you can run the following
   from the `ios/` folder of your app

```
pod install
```

Or, if you need to manually link it, run

```
react-native link react-native-health
```

3. Update the `ios/<Project Name>/info.plist` file in your project

```
<key>NSHealthShareUsageDescription</key>
<string>Read and understand health data.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Share workout data with other apps.</string>
<!-- Below is only required if requesting clinical health data -->
<key>NSHealthClinicalHealthRecordsShareUsageDescription</key>
<string>Read and understand clinical health data.</string>
```

To add Healthkit support to your application's `Capabilities`

- Open the `ios/` folder of your project in Xcode
- Select the project name in the left sidebar
- In the main view select '+ Capability' and double click 'HealthKit'

To enable access to clinical data types, check the `Clinical Health Records` box.

## Usage

In order to start collecting or saving data to HealthKit, you need to request
the user's permissions for the given data types. It can be done in the following
way

```typescript
import AppleHealthKit, {
  HealthValue,
  HealthKitPermissions,
} from 'react-native-health'

/* Permission options */
const permissions = {
  permissions: {
    read: [AppleHealthKit.Constants.Permissions.HeartRate],
    write: [AppleHealthKit.Constants.Permissions.Steps],
  },
} as HealthKitPermissions

AppleHealthKit.initHealthKit(permissions, (error: string) => {
  /* Called after we receive a response from the system */

  if (error) {
    console.log('[ERROR] Cannot grant permissions!')
  }

  /* Can now read or write to HealthKit */

  const options = {
    startDate: new Date(2020, 1, 1).toISOString(),
  }

  AppleHealthKit.getHeartRateSamples(
    options,
    (callbackError: string, results: HealthValue[]) => {
      /* Samples are now collected from HealthKit */
    },
  )
})
```

### Background Processing

For background capabilities, Apple allows developers to setup long running observer
queries for the health types needed.

Register the observers once at app launch. With the Swift `AppDelegate.swift` that
React Native 0.77+ templates ship with:

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

Or, with an Objective-C `AppDelegate.mm`:

```objective-c
#import <RNAppleHealthKit/RCTAppleHealthKit.h>

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  /* Add Background initializer for HealthKit */
  [[RCTAppleHealthKit new] initializeBackgroundObservers];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
```

Expo projects don't edit the AppDelegate by hand: set `enableBackgroundObservers: true`
on the config plugin instead (see [Expo](/docs/Expo.md)).

The HealthKit "Background Delivery" capability
(`com.apple.developer.healthkit.background-delivery` entitlement) must be enabled for
iOS to wake the app when new samples arrive.

After that you can start listening for data updates using the React Native
client. For more information, see [background observers](/docs/background.md).

## Documentation

All the documentation is under the [docs](/docs) folder. They are split into the following categories:

### Constants

- [Activities](/docs/activities.md)
- [Observers](/docs/observers.md)
- [Permissions](/docs/permissions.md)
- [Units](/docs/units.md)

### Base Methods

- [isAvailable](/docs/isAvailable.md)
- [initHealthKit](/docs/initHealthKit.md)
- [getAuthStatus](/docs/getAuthStatus.md)

### Mental Wellbeing Methods (iOS 18+)

- [getStateOfMindSamples](/docs/getStateOfMindSamples.md)
- [saveStateOfMind](/docs/saveStateOfMind.md)
- [getScoredAssessments](/docs/getScoredAssessments.md)
- [saveScoredAssessment](/docs/saveScoredAssessment.md)

### Medication Methods (iOS 26+)

- [getUserAnnotatedMedications](/docs/getUserAnnotatedMedications.md)
- [getMedicationDoseEvents](/docs/getMedicationDoseEvents.md)

### Background Methods

- [background observers](/docs/background.md)
- [initStepCountObserver](/docs/initStepCountObserver.md) - _DEPRECATED_
- [setObserver](/docs/setObserver.md) - _DEPRECATED_

### Activity Methods

- [getActiveEnergyBurned](/docs/getActiveEnergyBurned.md)
- [getBasalEnergyBurned](/docs/getBasalEnergyBurned.md)
- [getAppleStandTime](/docs/getAppleStandTime.md)

### Body Methods

- [getLatestHeight](/docs/getLatestHeight.md)
- [getLatestWeight](/docs/getLatestWeight.md)
- [getHeightSamples](/docs/getHeightSamples.md)
- [getWeightSamples](/docs/getWeightSamples.md)
- [getBodyTemperatureSamples](/docs/getBodyTemperatureSamples.md)
- [getLatestBodyFatPercentage](/docs/getLatestBodyFatPercentage.md)
- [getBodyFatPercentageSamples](/docs/getBodyFatPercentageSamples.md)
- [getLatestLeanBodyMass](/docs/getLatestLeanBodyMass.md)
- [getLeanBodyMassSamples](/docs/getLeanBodyMassSamples.md)
- [saveHeight](/docs/saveHeight.md)
- [saveWeight](/docs/saveWeight.md)
- [saveBodyFatPercentage](/docs/saveBodyFatPercentage.md)
- [saveBodyTemperature](/docs/saveBodyTemperature.md)
- [saveLeanBodyMass](/docs/saveLeanBodyMass.md)

### Characteristic Methods

- [getBiologicalSex](/docs/getBiologicalSex.md)
- [getDateOfBirth](/docs/getDateOfBirth.md)

### Clinical Records Methods

- [getClinicalRecords](/docs/getClinicalRecords.md)

### Dietary Methods

- [getEnergyConsumedSamples](/docs/getEnergyConsumedSamples.md)
- [getProteinSamples](/docs/getProteinSamples.md)
- [getFiberSamples](/docs/getFiberSamples.md)
- [getTotalFatSamples](/docs/getTotalFatSamples.md)
- [saveFood](/docs/saveFood.md)
- [saveWater](/docs/saveWater.md)
- [getWater](/docs/getWater.md)
- [getWaterSamples](/docs/getWaterSamples.md)
- [getFiberSamples](/docs/getFiberSamples.md)
- [getInsulinDeliverySamples](/docs/getInsulinDeliverySamples.md)
- [saveInsulinDeliverySamples](/docs/saveInsulinDeliverySample.md)
- [deleteInsulinDeliverySamples](/docs/deleteInsulinDeliverySample.md)

### Fitness Methods

- [getDailyStepCountSamples](/docs/getDailyStepCountSamples.md)
- [getStepCount](/docs/getStepCount.md)
- [getSamples](docs/getSamples.md)
- [getDailyDistanceWalkingRunningSamples](/docs/getDailyDistanceWalkingRunningSamples.md)
- [getDistanceWalkingRunning](/docs/getDistanceWalkingRunning.md)
- [getDailyDistanceSwimmingSamples](/docs/getDailyDistanceSwimmingSamples.md)
- [getDistanceSwimming](/docs/getDistanceSwimming.md)
- [getDailyDistanceCyclingSamples](/docs/getDailyDistanceCyclingSamples.md)
- [getDistanceCycling](/docs/getDistanceCycling.md)
- [getDailyFlightsClimbedSamples](/docs/getDailyFlightsClimbedSamples.md)
- [getFlightsClimbed](/docs/getFlightsClimbed.md)
- [saveSteps](/docs/saveSteps.md)
- [saveWalkingRunningDistance](/docs/saveWalkingRunningDistance.md)

### Hearing Methods

- [getEnvironmentalAudioExposure](/docs/getEnvironmentalAudioExposure.md)
- [getHeadphoneAudioExposure](/docs/getHeadphoneAudioExposure.md)

### Lab Tests Methods

- [getBloodAlcoholContentSamples](/docs/getBloodAlcoholContentSamples.md)
- [getBloodGlucoseSamples](/docs/getBloodGlucoseSamples.md)
- [getLatestBloodAlcoholContent](/docs/getLatestBloodAlcoholContent.md)
- [saveBloodAlcoholContent](/docs/saveBloodAlcoholContent.md)
- [saveBloodGlucoseSample](/docs/saveBloodGlucoseSample.md)
- [deleteBloodGlucoseSample](/docs/deleteBloodGlucoseSample.md)

### Nutrition

- [getCarbohydratesSamples](/docs/getCarbohydratesSamples.md)
- [saveCarbohydratesSample](/docs/saveCarbohydratesSample.md)
- [deleteCarbohydratesSample](/docs/deleteCarbohydratesSample.md)

### Mindfulness Methods

- [getMindfulSession](docs/getMindfulSession.md)
- [saveMindfulSession](/docs/saveMindfulSession.md)

### Sleep Methods

- [getSleepSamples](/docs/getSleepSamples.md)

#### Vitals Methods

- [getBloodPressureSamples](/docs/getBloodPressureSamples.md)
- [getElectrocardiogramSamples](/docs/getElectrocardiogramSamples.md)
- [saveHeartRateSample](/docs/saveHeartRateSample.md)
- [getHeartRateSamples](/docs/getHeartRateSamples.md)
- [getHeartRateVariabilitySamples](/docs/getHeartRateVariabilitySamples.md)
- [getHeartbeatSeriesSamples](/docs/getHeartbeatSeriesSamples.md)
- [getOxygenSaturationSamples](/docs/getOxygenSaturationSamples.md)
- [getRestingHeartRateSamples](/docs/getRestingHeartRateSamples.md)
- [getVo2MaxSamples](/docs/getVo2MaxSamples.md)
- [getLatestBmi](/docs/getLatestBmi.md)
- [getBmiSamples](/docs/getBmiSamples.md)
- [getRespiratoryRateSamples](/docs/getRespiratoryRateSamples.md)
- [getWalkingHeartRateAverage](/docs/getWalkingHeartRateAverage.md)
- [saveBmi](/docs/saveBmi.md)

#### Workout Methods

- [getSamples](docs/getSamples.md)
- [getAnchoredWorkouts](/docs/getAnchoredWorkouts.md)
- [saveWorkout](/docs/saveWorkout.md)
- [getWorkoutRouteSamples](/docs/getWorkoutRouteSamples.md)

## Additional Information

### Permissions

Due to Apple's privacy model, if a user has previously denied a
specific permission they will not be prompted again for that permission.
The user will need to go into the Apple Health app and grant the
permission to your app.

For any data written to Healthkit, an authorization error can be caught. If
an authorization error occurs, you can prompt the user to set the
specific permission or add the permission to the options object when
initializing the library.

If extra read or write permissions are added to the options object, the
app will request the user's permission when the library is
initialized again.

### Manual Installation

1. Run `yarn add react-native-health`
2. In XCode, in the project navigator, right-click `Libraries` ➜ `Add Files to [your project's name]`
3. Go to `node_modules` ➜ `react-native-health` and add `RCTAppleHealthkit.xcodeproj`
4. In XCode, in the project navigator, select your project. Add `libRCTAppleHealthkit.a`
   to your project's `Build Phases` ➜ `Link Binary With Libraries`
5. Click `RCTAppleHealthkit.xcodeproj` in the project navigator and go
   the `Build Settings` tab. Make sure 'All' is toggled on (instead of 'Basic').
   In the `Search Paths` section, look for `Header Search Paths` and make sure
   it contains both `$(SRCROOT)/../../react-native/React`
   and `$(SRCROOT)/../../../React` - mark both as `recursive`.
6. Enable Healthkit in your application's `Capabilities`
   ![](https://i.imgur.com/Ql1kXCg.png 'Xcode Capabilities Section')
7. Compile and run

## Contributing

We appreciate any requests and contributions to `react-native-health`.
The [issues](https://github.com/agencyenterprise/react-native-health/issues) tracker
is used to keep a list of features and bugs to be worked on. Please see our
[contributing documentation](https://github.com/agencyenterprise/react-native-health/blob/master/CONTRIBUTING.md)
for some tips on getting started.

## References

- [Apple Healthkit Documentation](https://developer.apple.com/documentation/healthkit)

## Android Alternative

If your app needs an Android + Health Connect integration, your princess is in another castle. You can use the package [React Native Health Connect](https://github.com/matinzd/react-native-health-connect) maintained by one of the community's dev.

In case of questions or if you just want to congratz the author, you can reach out to him on our [Discord Server](https://github.com/agencyenterprise/react-native-health#discord).

## Acknowledgement

> _This package is a fork of [rn-apple-healthkit](https://github.com/terrillo/rn-apple-healthkit)_

> _This package also inherits additional features from [Nutrisense](https://www.nutrisense.io/) fork_

## Plz I Still Need Halp

This package is maintained with ❤️ by [AE Studio](https://ae.studio). We will do our best to respond to requests and support for this package so please get in touch! If you require more extensive help or have other design, data science or development needs - we are a full service product development agency and can build pretty much anything so hit us up!
