import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

/**
 * Codegen spec for the AppleHealthKit TurboModule.
 *
 * Every method keeps the callback-style signature of the legacy bridge module
 * so existing JS callers keep working unchanged. Parameter names matter: codegen
 * derives the Objective-C selector from them (e.g. `initHealthKit:callback:`).
 */

type Callback = (error: Object | null, result: Object | null) => void;

export interface Spec extends TurboModule {
  isAvailable(callback: Callback): void;
  initHealthKit(input: Object, callback: Callback): void;
  initStepCountObserver(input: Object, callback: Callback): void;
  getBiologicalSex(input: Object, callback: Callback): void;
  getBloodType(input: Object, callback: Callback): void;
  getDateOfBirth(input: Object, callback: Callback): void;
  getLatestWeight(input: Object, callback: Callback): void;
  getWeightSamples(input: Object, callback: Callback): void;
  saveWeight(input: Object, callback: Callback): void;
  getLatestHeight(input: Object, callback: Callback): void;
  getHeightSamples(input: Object, callback: Callback): void;
  saveHeight(input: Object, callback: Callback): void;
  getLatestWaistCircumference(input: Object, callback: Callback): void;
  getWaistCircumferenceSamples(input: Object, callback: Callback): void;
  saveWaistCircumference(input: Object, callback: Callback): void;
  getLatestPeakFlow(input: Object, callback: Callback): void;
  getPeakFlowSamples(input: Object, callback: Callback): void;
  savePeakFlow(input: Object, callback: Callback): void;
  getLatestBmi(input: Object, callback: Callback): void;
  getBmiSamples(input: Object, callback: Callback): void;
  saveBmi(input: Object, callback: Callback): void;
  getLatestBodyFatPercentage(input: Object, callback: Callback): void;
  getBodyFatPercentageSamples(input: Object, callback: Callback): void;
  saveBodyFatPercentage(input: Object, callback: Callback): void;
  saveBodyTemperature(input: Object, callback: Callback): void;
  getLatestLeanBodyMass(input: Object, callback: Callback): void;
  getLeanBodyMassSamples(input: Object, callback: Callback): void;
  saveLeanBodyMass(input: Object, callback: Callback): void;
  getStepCount(input: Object, callback: Callback): void;
  getSamples(input: Object, callback: Callback): void;
  getAnchoredWorkouts(input: Object, callback: Callback): void;
  getWorkoutRouteSamples(input: Object, callback: Callback): void;
  setObserver(input: Object): void;
  getDailyStepCountSamples(input: Object, callback: Callback): void;
  saveSteps(input: Object, callback: Callback): void;
  saveWalkingRunningDistance(input: Object, callback: Callback): void;
  getDistanceWalkingRunning(input: Object, callback: Callback): void;
  getDailyDistanceWalkingRunningSamples(input: Object, callback: Callback): void;
  getDistanceCycling(input: Object, callback: Callback): void;
  getDailyDistanceCyclingSamples(input: Object, callback: Callback): void;
  getDistanceSwimming(input: Object, callback: Callback): void;
  getDailyDistanceSwimmingSamples(input: Object, callback: Callback): void;
  getFlightsClimbed(input: Object, callback: Callback): void;
  getDailyFlightsClimbedSamples(input: Object, callback: Callback): void;
  getEnergyConsumedSamples(input: Object, callback: Callback): void;
  getProteinSamples(input: Object, callback: Callback): void;
  getFiberSamples(input: Object, callback: Callback): void;
  getTotalFatSamples(input: Object, callback: Callback): void;
  saveFood(input: Object, callback: Callback): void;
  saveWater(input: Object, callback: Callback): void;
  getWater(input: Object, callback: Callback): void;
  getWaterSamples(input: Object, callback: Callback): void;
  saveHeartRateSample(input: Object, callback: Callback): void;
  getHeartRateSamples(input: Object, callback: Callback): void;
  getRestingHeartRate(input: Object, callback: Callback): void;
  getWalkingHeartRateAverage(input: Object, callback: Callback): void;
  saveActiveEnergyBurned(input: Object, callback: Callback): void;
  getActiveEnergyBurned(input: Object, callback: Callback): void;
  saveBasalEnergyBurned(input: Object, callback: Callback): void;
  getBasalEnergyBurned(input: Object, callback: Callback): void;
  getAppleExerciseTime(input: Object, callback: Callback): void;
  getAppleStandTime(input: Object, callback: Callback): void;
  saveVo2MaxSample(input: Object, callback: Callback): void;
  getVo2MaxSamples(input: Object, callback: Callback): void;
  getBodyTemperatureSamples(input: Object, callback: Callback): void;
  getBloodPressureSamples(input: Object, callback: Callback): void;
  saveRespiratoryRateSample(input: Object, callback: Callback): void;
  getRespiratoryRateSamples(input: Object, callback: Callback): void;
  saveHeartRateVariabilitySample(input: Object, callback: Callback): void;
  getHeartRateVariabilitySamples(input: Object, callback: Callback): void;
  getHeartbeatSeriesSamples(input: Object, callback: Callback): void;
  saveRestingHeartRateSample(input: Object, callback: Callback): void;
  getRestingHeartRateSamples(input: Object, callback: Callback): void;
  saveOxygenSaturationSample(input: Object, callback: Callback): void;
  getOxygenSaturationSamples(input: Object, callback: Callback): void;
  getElectrocardiogramSamples(input: Object, callback: Callback): void;
  getBloodGlucoseSamples(input: Object, callback: Callback): void;
  getCarbohydratesSamples(input: Object, callback: Callback): void;
  getInsulinDeliverySamples(input: Object, callback: Callback): void;
  saveInsulinDeliverySample(input: Object, callback: Callback): void;
  deleteInsulinDeliverySample(oid: string, callback: Callback): void;
  saveCarbohydratesSample(input: Object, callback: Callback): void;
  deleteCarbohydratesSample(oid: string, callback: Callback): void;
  saveBloodGlucoseSample(input: Object, callback: Callback): void;
  deleteBloodGlucoseSample(oid: string, callback: Callback): void;
  getSleepSamples(input: Object, callback: Callback): void;
  saveSleepSample(input: Object, callback: Callback): void;
  getInfo(input: Object, callback: Callback): void;
  getMindfulSession(input: Object, callback: Callback): void;
  saveMindfulSession(input: Object, callback: Callback): void;
  saveWorkout(input: Object, callback: Callback): void;
  getAuthStatus(input: Object, callback: Callback): void;
  getLatestBloodAlcoholContent(input: Object, callback: Callback): void;
  getBloodAlcoholContentSamples(input: Object, callback: Callback): void;
  saveBloodAlcoholContent(input: Object, callback: Callback): void;
  getEnvironmentalAudioExposure(input: Object, callback: Callback): void;
  getHeadphoneAudioExposure(input: Object, callback: Callback): void;
  getActivitySummary(input: Object, callback: Callback): void;
  getClinicalRecords(input: Object, callback: Callback): void;
  deleteSamplesByType(input: Object, callback: Callback): void;
  // Mental wellbeing (iOS 18+)
  getStateOfMindSamples(input: Object, callback: Callback): void;
  saveStateOfMind(input: Object, callback: Callback): void;
  getScoredAssessments(input: Object, callback: Callback): void;
  saveScoredAssessment(input: Object, callback: Callback): void;
  // Medications (iOS 26+)
  getUserAnnotatedMedications(input: Object, callback: Callback): void;
  getMedicationDoseEvents(input: Object, callback: Callback): void;

  // Required by NativeEventEmitter
  addListener(eventName: string): void;
  removeListeners(count: number): void;
}

export default TurboModuleRegistry.get<Spec>('AppleHealthKit');
