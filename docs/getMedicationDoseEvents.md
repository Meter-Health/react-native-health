# getMedicationDoseEvents

**iOS 26+.** Reads logged and scheduled medication doses (`HKMedicationDoseEvent`). Requires the
`MedicationDoseEvent` read permission. The Medications API is read-only for third-party apps.

Example input options (all optional):

```javascript
let options = {
  startDate: new Date(2025, 0, 1).toISOString(),
  endDate: new Date().toISOString(),
  medicationIds: ['YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25...'], // ids from getUserAnnotatedMedications
  logStatus: ['Taken', 'Skipped'], // one name or an array
  limit: 100,
  ascending: false,
}
```

Call the method:

```javascript
AppleHealthKit.getMedicationDoseEvents(options, (err, results) => {
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
    "medicationId": "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25...",
    "scheduleType": "Schedule",
    "logStatus": "Taken",
    "scheduledDate": "2025-03-10T08:00:00.000+0100",
    "scheduledDoseQuantity": 1,
    "doseQuantity": 1,
    "unit": "count",
    "startDate": "2025-03-10T08:05:00.000+0100",
    "endDate": "2025-03-10T08:05:00.000+0100",
    "sourceName": "Health",
    "sourceId": "com.apple.Health",
    "metadata": {}
  }
]
```

`logStatus` is one of `NotInteracted`, `NotificationNotSent`, `Snoozed`, `Taken`, `Skipped`,
`NotLogged`; `scheduleType` is `Schedule` or `AsNeeded`. On iOS < 26 the callback receives an error.
