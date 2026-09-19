# getStateOfMindSamples

**iOS 18+.** Reads State of Mind samples (the mood / emotion logs from the Health and Mindfulness
apps, `HKStateOfMind`). Requires the `StateOfMind` read permission.

Example input options:

```javascript
let options = {
  startDate: new Date(2025, 0, 1).toISOString(), // optional
  endDate: new Date().toISOString(), // optional, default now
  kind: 'DailyMood', // optional: 'MomentaryEmotion' | 'DailyMood'
  limit: 10, // optional
  ascending: false, // optional
}
```

Call the method:

```javascript
AppleHealthKit.getStateOfMindSamples(options, (err, results) => {
  if (err) {
    return
  }
  console.log(results)
})
```

Example output:

```json
[
  {
    "id": "A7D8E94A-5544-4533-869F-7566AAB81252",
    "kind": "DailyMood",
    "valence": 0.5,
    "valenceClassification": "Pleasant",
    "labels": ["Calm", "Grateful"],
    "associations": ["Family", "Fitness"],
    "startDate": "2025-03-10T21:00:00.000+0100",
    "endDate": "2025-03-10T21:00:00.000+0100",
    "sourceName": "Health",
    "sourceId": "com.apple.Health",
    "metadata": {}
  }
]
```

`valence` runs from -1 (very unpleasant) to 1 (very pleasant). Labels and associations use the
names of `HKStateOfMind.Label` / `HKStateOfMind.Association` (see `StateOfMindLabel` and
`StateOfMindAssociation` in the TypeScript definitions). On iOS < 18 the callback receives an error.
