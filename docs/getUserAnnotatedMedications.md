# getUserAnnotatedMedications

**iOS 26+.** Lists the medications the user tracks in the Health app
(`HKUserAnnotatedMedication`). Requires the `UserAnnotatedMedications` read permission. The
Medications API is read-only for third-party apps.

Example input options (all optional):

```javascript
let options = {
  isArchived: false, // only current (false) or archived (true) medications
  hasSchedule: true, // only medications with / without a schedule
  limit: 50,
}
```

Call the method:

```javascript
AppleHealthKit.getUserAnnotatedMedications(options, (err, results) => {
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
    "medication": {
      "id": "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25...",
      "displayText": "Ibuprofen 200 mg tablet",
      "generalForm": "tablet",
      "relatedCodings": [{ "system": "http://www.nlm.nih.gov/research/umls/rxnorm", "version": null, "code": "310965" }]
    },
    "nickname": "Painkiller",
    "isArchived": false,
    "hasSchedule": true
  }
]
```

`medication.id` is an opaque, stable identifier (the archived `HKHealthConceptIdentifier`) that
can be passed to [getMedicationDoseEvents](./getMedicationDoseEvents.md) as `medicationIds`.
On iOS < 26 the callback receives an error.
