# getScoredAssessments

**iOS 18+.** Reads GAD-7 (anxiety) or PHQ-9 (depression) assessments (`HKScoredAssessment`).
Requires the `GAD7Assessment` / `PHQ9Assessment` read permission.

Example input options:

```javascript
let options = {
  type: 'PHQ9', // 'GAD7' (default) | 'PHQ9'
  startDate: new Date(2025, 0, 1).toISOString(), // optional
  endDate: new Date().toISOString(), // optional, default now
  limit: 10, // optional
  ascending: false, // optional
}
```

Call the method:

```javascript
AppleHealthKit.getScoredAssessments(options, (err, results) => {
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
    "type": "PHQ9",
    "score": 7,
    "risk": "Mild",
    "answers": [1, 1, 0, 2, 1, 0, 1, 1, 0],
    "startDate": "2025-03-10T21:00:00.000+0100",
    "endDate": "2025-03-10T21:00:00.000+0100",
    "sourceName": "Health",
    "sourceId": "com.apple.Health",
    "metadata": {}
  }
]
```

Answers: 0 = not at all, 1 = several days, 2 = more than half the days, 3 = nearly every day
(PHQ-9 only: 4 = prefer not to answer). Risk is `NoneToMinimal | Mild | Moderate | Severe` for
GAD-7 and additionally `ModeratelySevere` for PHQ-9. On iOS < 18 the callback receives an error.
