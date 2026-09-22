# saveWorkout

Save workout to Healthkit

`saveWorkout` accepts an options object containing type, startDate, endDate, energyBurned, distance
and an optional route

The workout is created with `HKWorkoutBuilder`. `energyBurned` and `distance` are stored as
samples attached to the workout, so besides the `Workout` write permission the app needs write
access to `ActiveEnergyBurned` (when `energyBurned` is set) and to the distance type matching the
activity (`DistanceWalkingRunning` by default; `DistanceCycling`, `DistanceSwimming`,
`DistanceWheelchair` or `DistanceDownhillSnowSports` for the corresponding activities).

An optional `route` array is saved as an `HKWorkoutRoute` attached to the workout via
`HKWorkoutRouteBuilder`, which requires the `WorkoutRoute` write permission. Each point takes
`latitude`, `longitude`, and optionally `time` (milliseconds since epoch or an ISO 8601 string,
defaults to `startDate`), `altitude`, `horizontalAccuracy` and `verticalAccuracy` in metres.
Points should fall inside the workout window; they are sorted by time before insertion. If the
route cannot be saved the callback receives an error, but the workout itself has already been
written.

Example input options:

```javascript
let options = {
  type: 'AmericanFootball', // See HealthActivity Enum
  startDate: new Date(2016, 6, 2, 6, 0, 0).toISOString(),
  endDate: new Date(2020, 6, 2, 6, 30, 0).toISOString(),
  energyBurned: 50, // In Energy burned unit,
  energyBurnedUnit: 'calorie', 
  distance: 50, // In Distance unit
  distanceUnit: 'meter',
  route: [ // Optional, needs WorkoutRoute write permission
    { latitude: 59.3293, longitude: 18.0686, time: Date.UTC(2016, 6, 2, 6, 0, 0), altitude: 20, horizontalAccuracy: 5 },
    { latitude: 59.3301, longitude: 18.0702, time: Date.UTC(2016, 6, 2, 6, 5, 0), altitude: 21, horizontalAccuracy: 5 },
  ],
}
```

Call the method:

```javascript
AppleHealthKit.saveWorkout(
  (options: HealthInputOptions),
  (err: Object, results: string) => {
    if (err) {
      console.log('error saving workout to Healthkit: ', err)
      return
    }
    // workout successfully saved
  },
)
```

Example output, UUIDString:

```json
 A7D8E94A-5544-4533-869F-7566AAB81252
```
