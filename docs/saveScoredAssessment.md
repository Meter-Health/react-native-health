# saveScoredAssessment

**iOS 18+.** Saves a GAD-7 or PHQ-9 assessment. HealthKit computes the score and risk from the
answers. Requires the `GAD7Assessment` / `PHQ9Assessment` write permission.

Example input options:

```javascript
let options = {
  type: 'GAD7', // 'GAD7' | 'PHQ9' (required)
  date: new Date().toISOString(), // optional, default now
  answers: [0, 1, 1, 2, 0, 1, 0], // 7 answers for GAD7, 9 for PHQ9; each 0..3 (PHQ9: 4 = prefer not to answer)
  metadata: {}, // optional
}
```

Call the method:

```javascript
AppleHealthKit.saveScoredAssessment(options, (err, result) => {
  if (err) {
    return
  }
  console.log(result) // { id: '...', score: 5 }
})
```

On iOS < 18 the callback receives an error.
