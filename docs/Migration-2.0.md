# Migrating from 1.x to 2.0

What changes for **your app** when you upgrade `@krantzr/react-native-health` from
1.x to 2.0. For the full list of what was added, see the
[fork changelog](../README.md#fork-changelog).

## TL;DR

| Area | 1.x | 2.0 | Action |
| --- | --- | --- | --- |
| JS API (method names, `(options, callback)` signatures, `Constants`) | — | unchanged | none |
| `saveWorkout` permissions | `Workout` only | `Workout` + `ActiveEnergyBurned` + distance type | **update `initHealthKit` permissions** |
| Background observers (native) | `initializeBackgroundObservers:bridge` | `initializeBackgroundObservers` | **update AppDelegate** (or use the Expo plugin option) |
| React Native | ≥ 0.67.3 | ≥ 0.71 | bump RN if needed |
| iOS deployment target | 9.0 | 15.1 | bump if needed |
| New Architecture | interop layer | native TurboModule | none — works on both |
| Spreading the module (`{...AppleHealthKit}`) | worked | drops methods on New Arch | call methods on the exported object |

Everything else in 2.0 is additive: new methods, permissions and units that you opt
into.

## 1. `saveWorkout` needs more write permissions (breaking)

Workouts are now created with `HKWorkoutBuilder`, and `energyBurned` / `distance` are
stored as samples attached to the workout. HealthKit therefore requires write access to
those sample types, not just to `Workout`.

Before:

```javascript
const permissions = {
  permissions: {
    read: [],
    write: [AppleHealthKit.Constants.Permissions.Workout],
  },
}
```

After:

```javascript
const P = AppleHealthKit.Constants.Permissions

const permissions = {
  permissions: {
    read: [],
    write: [
      P.Workout,
      P.ActiveEnergyBurned,     // if you pass `energyBurned`
      P.DistanceWalkingRunning, // if you pass `distance` — see below
    ],
  },
}
```

The distance type must match the activity: `DistanceWalkingRunning` by default,
`DistanceCycling`, `DistanceSwimming`, `DistanceWheelchair` or
`DistanceDownhillSnowSports` for the corresponding activities. Request every distance
type your app can save. If you don't pass `energyBurned` / `distance`, nothing changes.

See [saveWorkout](./saveWorkout.md).

## 2. Background observers: AppDelegate call changed (native)

The observers no longer need the React Native bridge. The old selector still compiles
and works but ignores its argument, so this is not strictly required — update it to get
rid of the deprecation warning and the bridge reference.

Before (`AppDelegate.m` / `.mm`):

```objective-c
[[RCTAppleHealthKit new] initializeBackgroundObservers:bridge];
```

After:

```objective-c
#import <RNAppleHealthKit/RCTAppleHealthKit.h>

[[RCTAppleHealthKit new] initializeBackgroundObservers];
```

Swift (`AppDelegate.swift`, RN 0.77+ templates):

```swift
import RNAppleHealthKit

RCTAppleHealthKit().initializeBackgroundObservers()
```

Expo projects don't edit the AppDelegate at all anymore: set
`enableBackgroundObservers: true` on the config plugin and it adds the call plus the
background-delivery entitlement for you (see [Expo](./Expo.md)).

Events still arrive through `NativeEventEmitter` exactly as before; no JS changes. See
[background observers](./background.md).

## 3. Minimum versions

- React Native **0.71** or newer (the podspec relies on `install_modules_dependencies`).
- iOS deployment target **15.1** (`platform :ios, '15.1'` in your Podfile or higher).
- Building the iOS 18 mental-wellbeing methods requires Xcode 16; the iOS 26 medication
  methods require Xcode 26. Older SDKs compile those methods out, and on older iOS
  versions at runtime they return an error in the callback instead of crashing.

## 4. New Architecture

2.0 ships a codegen spec and registers as a TurboModule, so it runs natively in
bridgeless mode (RN 0.76+ / Expo SDK 52+) without the interop layer. No setup on your
side: autolinking and codegen pick it up. The legacy bridge (RN 0.71–0.81 with the New
Architecture disabled) keeps working from the same code.

One JS gotcha that comes with TurboModules: methods are resolved lazily on first
access, so copying the module loses them.

```javascript
// Don't — yields an object with no methods under the New Architecture
const hk = { ...AppleHealthKit }
const hk = Object.assign({}, AppleHealthKit)

// Do — call methods on the exported object
AppleHealthKit.getStepCount(options, callback)
```

## 5. Behaviour changes you may notice (non-breaking)

- **Write permissions for read-only types** (e.g. `AppleExerciseTime`) are now filtered
  out of the request instead of failing the whole `initHealthKit` call.
- **`getSamples`** accepts any readable permission name as `type`, not just the five
  fitness types; when `unit` is omitted or incompatible a fitting default is used, and
  category samples are returned with their `value`. Existing calls behave the same.
- **Units:** `unit` strings you pass are matched against the documented names first and
  then handed to `HKUnit.unitFromString`, so raw HealthKit unit strings (`"W"`, `"m/s"`)
  work too. Existing documented names are unchanged.
- **Workout energy/distance** are read from workout statistics instead of the deprecated
  `totalEnergyBurned` / `totalDistance` properties. Same fields in the result.

## 6. Additive: what you can start using

- Mental wellbeing (iOS 18+): [getStateOfMindSamples](./getStateOfMindSamples.md),
  [saveStateOfMind](./saveStateOfMind.md), [getScoredAssessments](./getScoredAssessments.md),
  [saveScoredAssessment](./saveScoredAssessment.md).
- Medications (iOS 26+, read-only): [getUserAnnotatedMedications](./getUserAnnotatedMedications.md),
  [getMedicationDoseEvents](./getMedicationDoseEvents.md).
- ~110 new permission names (cycling power/cadence, physical effort, time in daylight,
  symptoms, sleep apnea, ...) — see [permissions](./permissions.md).
- New units (`watt`, `rpm`, `meterPerSecond`, `kmPerHour`, `kcalPerKgHour`,
  `appleEffortScore`, ...) — see [units](./units.md).
- New activity types: `SwimBikeRun`, `Transition`, `UnderwaterDiving`, `Other` — see
  [activities](./activities.md).

## Upgrade checklist

1. `npm install @krantzr/react-native-health@^2` and `cd ios && pod install`.
2. Confirm RN ≥ 0.71 and iOS deployment target ≥ 15.1.
3. If you call `saveWorkout` with `energyBurned` / `distance`, add the extra write
   permissions to `initHealthKit`.
4. If you use background observers, drop the `:bridge` argument in the AppDelegate
   (or switch to the Expo plugin option).
5. Search your code for `...AppleHealthKit` / `Object.assign({}, AppleHealthKit` and
   remove it.
6. Rebuild the native app.
