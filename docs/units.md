# Units

The following units are supported by the library

```
  appleEffortScore
  bpm
  calorie
  celsius
  count
  day
  decibel
  fahrenheit
  foot
  gram
  hour
  inch
  joule
  kcalPerKgHour
  kilometer
  kmPerHour
  liter
  literPerMinute
  meter
  meterPerSecond
  mgPerdL
  microgram
  microsiemens
  mile
  milePerHour
  milligram
  milliliter
  minute
  mlPerKgMin
  mmhg
  mmolPerL
  percent
  pound
  rpm
  second
  watt
```

Any other [HealthKit unit string](https://developer.apple.com/documentation/healthkit/hkunit/init(from:))
(for example `kcal/(kg*hr)`, `m/s`, `W`) is accepted as-is.

`kilocalorie` is the unit shown as "Calories" in the Health app; `calorie` is the small (gram) calorie.
