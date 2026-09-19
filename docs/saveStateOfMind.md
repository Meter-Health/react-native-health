# saveStateOfMind

**iOS 18+.** Saves a State of Mind sample (`HKStateOfMind`). Requires the `StateOfMind` write
permission.

Example input options:

```javascript
let options = {
  date: new Date().toISOString(), // optional, default now
  kind: 'MomentaryEmotion', // optional: 'MomentaryEmotion' | 'DailyMood' (default MomentaryEmotion)
  valence: 0.75, // required, -1 .. 1
  labels: ['Happy', 'Excited'], // optional, see StateOfMindLabel
  associations: ['Friends'], // optional, see StateOfMindAssociation
  metadata: { note: 'after the run' }, // optional
}
```

Call the method:

```javascript
AppleHealthKit.saveStateOfMind(options, (err, uuid) => {
  if (err) {
    return
  }
  console.log('saved', uuid)
})
```

Returns the UUID of the saved sample. On iOS < 18 the callback receives an error.
