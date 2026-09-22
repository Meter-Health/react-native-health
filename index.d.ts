declare module 'react-native-health' {
  export interface HealthKitPermissions {
    permissions: {
      read: HealthPermission[]
      write: HealthPermission[]
    }
  }

  export interface Constants {
    Activities: Record<HealthActivity, HealthActivity>
    Observers: Record<HealthObserver, HealthObserver>
    Permissions: Record<HealthPermission, HealthPermission>
    Units: Record<HealthUnit, HealthUnit>
  }

  export interface HKErrorResponse {
    message?: string
  }

  export interface AppleHealthKit {
    initHealthKit(
      permissions: HealthKitPermissions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    isAvailable(callback: (error: Object, results: boolean) => void): void

    getBiologicalSex(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBloodType(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDateOfBirth(
      options: any,
      callback: (err: string, results: HealthDateOfBirth) => void,
    ): void

    getLatestWeight(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getWeightSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveWeight(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestHeight(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getHeightSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveHeight(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestWaistCircumference(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getWaistCircumferenceSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveWaistCircumference(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestPeakFlow(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getPeakFlowSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    savePeakFlow(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    saveLeanBodyMass(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestBmi(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBmiSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveBmi(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestBodyFatPercentage(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBodyFatPercentageSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getLatestLeanBodyMass(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getLeanBodyMassSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getStepCount(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getAnchoredWorkouts(
      options: HealthInputOptions,
      callback: (err: HKErrorResponse, results: AnchoredQueryResults) => void,
    ): void

    getDailyStepCountSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveSteps(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    saveWalkingRunningDistance(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getDistanceWalkingRunning(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyDistanceWalkingRunningSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getDistanceCycling(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyDistanceCyclingSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getFlightsClimbed(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyFlightsClimbedSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getEnergyConsumedSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getProteinSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getFiberSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getTotalFatSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveFood(
      options: HealthInputOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    saveWater(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getWater(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveHeartRateSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getWaterSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getHeartRateSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getRestingHeartRate(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getWalkingHeartRateAverage(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue[]) => void,
    ): void

    saveActiveEnergyBurned(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getActiveEnergyBurned(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveBasalEnergyBurned(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getBasalEnergyBurned(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getAppleExerciseTime(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getAppleStandTime(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveVo2MaxSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getVo2MaxSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getBodyTemperatureSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getBloodPressureSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<BloodPressureSampleValue>) => void,
    ): void

    saveRespiratoryRateSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getRespiratoryRateSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveHeartRateVariabilitySample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getHeartRateVariabilitySamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getHeartbeatSeriesSamples(
      options: HealthInputOptions,
      callback: (err: string, results: HeartbeatSeriesSampleValue[]) => void,
    ): void

    saveRestingHeartRateSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getRestingHeartRateSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getBloodGlucoseSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getCarbohydratesSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveBloodGlucoseSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    saveCarbohydratesSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    deleteBloodGlucoseSample(
      id: string,
      callback: (error: string, result: HealthValue) => void,
    ): void

    deleteCarbohydratesSample(
      id: string,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getSleepSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getInfo(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getMindfulSession(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveMindfulSession(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getWorkoutRouteSamples(
      options: { id: string },
      callback: (err: string, results: WorkoutRouteQueryResults) => void,
    ): void

    saveWorkout(
      options: HealthActivityOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getAuthStatus(
      permissions: HealthKitPermissions,
      callback: (err: string, results: HealthStatusResult) => void,
    ): void

    getLatestBloodAlcoholContent(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBloodAlcoholContentSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveBloodAlcoholContent(
      options: HealthValueOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDistanceSwimming(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyDistanceSwimmingSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveOxygenSaturationSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getOxygenSaturationSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getElectrocardiogramSamples(
      options: HealthInputOptions,
      callback: (err: string, results: ElectrocardiogramSampleValue[]) => void,
    ): void

    saveBodyFatPercentage(
      options: HealthValueOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveBodyTemperature(
      options: HealthValueOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getEnvironmentalAudioExposure(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue[]) => void,
    ): void

    getHeadphoneAudioExposure(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue[]) => void,
    ): void

    getClinicalRecords(
      options: HealthClinicalRecordOptions,
      callback: (err: string, results: Array<HealthClinicalRecord>) => void,
    ): void

    setObserver(options: HealthObserverOptions): void

    getActivitySummary(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthActivitySummary>) => void,
    ): void

    getInsulinDeliverySamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveInsulinDeliverySample(
      options: HealthValueOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    deleteInsulinDeliverySample(
      id: string,
      callback: (error: string, result: HealthValue) => void,
    ): void


    Constants: Constants
  }

  /* Inputs and Payloads */

  export interface HealthDateOfBirth {
    value: string
    age: number
  }
  interface BaseValue {
    id?: string
    startDate: string
    endDate: string
    metadata?: RecordMetadata
  }

  export interface LocationValue {
    latitude: number
    longitude: number
    altitude: number
    timestamp: string
    speed: number
    speedAccuracy: number
  }

  export interface RecordMetadata {
    HKBloodGlucoseMealTime?: BloodGlucoseMealTime
    HKInsulinDeliveryReason?: InsulinDeliveryReason
    HKWasUserEntered?: boolean
    [key: string]: string | number | boolean | undefined
  }

  export interface HealthValue extends BaseValue {
    value: number
  }

  export interface BloodPressureSampleValue extends BaseValue {
    bloodPressureSystolicValue: number
    bloodPressureDiastolicValue: number
  }

  export interface HeartbeatSeriesSampleValue extends BaseValue {
    heartbeatSeries: {
      timeSinceSeriesStart: number
      precededByGap: boolean
    }[]
  }

  export interface HealthUnitOptions {
    unit?: HealthUnit
  }

  export interface HealthInputOptions extends HealthUnitOptions {
    startDate?: string
    endDate?: string
    limit?: number
    ascending?: boolean
    type?: HealthObserver
    date?: string
    includeManuallyAdded?: boolean
    period?: number
    anchor?: string
  }

  export interface HKWorkoutRouteSampleType {
    device: string
    id: string
    metadata: any
    sourceName: string
    sourceId: string
    start: string
    end: string
    locations: LocationValue[]
  }

  export enum EventType {
    Pause = 'pause',
    Resume = 'resume',
    MotionPaused = 'motion paused',
    MotionResumed = 'motion resumed',
    PausedOrResumeRequest = 'pause or resume request',
    Lap = 'lap',
    Segment = 'segment',
    Marker = 'marker'
  }

  export type HKWorkoutEventType = {
    endDate: string
    startDate: string
    eventTypeInt: number
    eventType: EventType
  }

  export interface HKWorkoutQueriedSampleType {
    activityId: number
    activityName: string
    calories: number
    device: string
    id: string
    tracked: boolean
    metadata: any
    sourceName: string
    sourceId: string
    distance: number
    start: string
    end: string
    duration: number
    workoutEvents: HKWorkoutEventType[]
  }

  export interface ElectrocardiogramSampleValue extends BaseValue {
    classification: ElectrocardiogramClassification
    averageHeartRate: number
    samplingFrequency: number
    device: string
    algorithmVersion: number
    voltageMeasurements: number[][]
  }

  export interface HealthValueOptions extends HealthUnitOptions {
    value: number
    date?: string;
    startDate?: string
    endDate?: string
    metadata?: RecordMetadata
  }

  export interface WorkoutRouteLocationInput {
    latitude: number
    longitude: number
    /** Milliseconds since epoch, or an ISO 8601 string. Defaults to startDate. */
    time?: number | string
    /** Metres. */
    altitude?: number
    /** Metres; must be >= 0. */
    horizontalAccuracy?: number
    /** Metres. */
    verticalAccuracy?: number
  }

  export interface HealthActivityOptions
    extends Omit<Omit<HealthValueOptions, 'unit'>, 'value'> {
    type: HealthActivity
    energyBurned?: number
    energyBurnedUnit?: HealthUnit
    distance?: number
    distanceUnit?: HealthUnit
    /** Saved as an HKWorkoutRoute attached to the workout (needs WorkoutRoute write permission). */
    route?: WorkoutRouteLocationInput[]
  }

  export interface HealthObserverOptions {
    type: HealthObserver
  }

  export interface HealthActivitySummary {
    activeEnergyBurned: number
    activeEnergyBurnedGoal: number
    appleExerciseTime: number
    appleExerciseTimeGoal: number
    appleStandHours: number
    appleStandHoursGoal: number
  }

  export interface HealthClinicalRecordOptions {
    startDate: string
    endDate?: string
    limit?: number
    ascending?: boolean
    type: ClinicalRecordType
  }

  export enum ClinicalRecordType {
    AllergyRecord = 'AllergyRecord',
    ConditionRecord = 'ConditionRecord',
    CoverageRecord = 'CoverageRecord',
    ImmunizationRecord = 'ImmunizationRecord',
    LabResultRecord = 'LabResultRecord',
    MedicationRecord = 'MedicationRecord',
    ProcedureRecord = 'ProcedureRecord',
    VitalSignRecord = 'VitalSignRecord',
  }

  export interface HealthClinicalRecord extends BaseValue {
    sourceName: string
    sourceId: string
    displayName: string
    fhirData: any
  }

  /* Health Constants */

  export enum HealthActivity {
    AmericanFootball = 'AmericanFootball',
    Archery = 'Archery',
    AustralianFootball = 'AustralianFootball',
    Badminton = 'Badminton',
    Baseball = 'Baseball',
    Basketball = 'Basketball',
    Bowling = 'Bowling',
    Boxing = 'Boxing',
    CardioDance = 'CardioDance',
    Climbing = 'Climbing',
    Cooldown = 'Cooldown',
    Cricket = 'Cricket',
    CrossTraining = 'CrossTraining',
    Curling = 'Curling',
    Cycling = 'Cycling',
    Dance = 'Dance',
    DiscSports = 'DiscSports',
    Elliptical = 'Elliptical',
    EquestrianSports = 'EquestrianSports',
    Fencing = 'Fencing',
    FitnessGaming = 'FitnessGaming',
    Fishing = 'Fishing',
    FunctionalStrengthTraining = 'FunctionalStrengthTraining',
    Golf = 'Golf',
    Gymnastics = 'Gymnastics',
    Handball = 'Handball',
    Hiking = 'Hiking',
    Hockey = 'Hockey',
    Hunting = 'Hunting',
    Lacrosse = 'Lacrosse',
    MartialArts = 'MartialArts',
    MindAndBody = 'MindAndBody',
    PaddleSports = 'PaddleSports',
    Play = 'Play',
    Pickleball = 'Pickleball',
    PreparationAndRecovery = 'PreparationAndRecovery',
    Racquetball = 'Racquetball',
    Rowing = 'Rowing',
    Rugby = 'Rugby',
    Running = 'Running',
    Sailing = 'Sailing',
    SkatingSports = 'SkatingSports',
    SnowSports = 'SnowSports',
    Soccer = 'Soccer',
    SocialDance = 'SocialDance',
    Softball = 'Softball',
    Squash = 'Squash',
    StairClimbing = 'StairClimbing',
    SurfingSports = 'SurfingSports',
    Swimming = 'Swimming',
    TableTennis = 'TableTennis',
    Tennis = 'Tennis',
    TrackAndField = 'TrackAndField',
    TraditionalStrengthTraining = 'TraditionalStrengthTraining',
    Volleyball = 'Volleyball',
    Walking = 'Walking',
    WaterFitness = 'WaterFitness',
    WaterPolo = 'WaterPolo',
    WaterSports = 'WaterSports',
    Wrestling = 'Wrestling',
    Yoga = 'Yoga',
    Barre = 'Barre',
    CoreTraining = 'CoreTraining',
    CrossCountrySkiing = 'CrossCountrySkiing',
    DownhillSkiing = 'DownhillSkiing',
    Flexibility = 'Flexibility',
    HighIntensityIntervalTraining = 'HighIntensityIntervalTraining',
    JumpRope = 'JumpRope',
    Kickboxing = 'Kickboxing',
    Pilates = 'Pilates',
    Snowboarding = 'Snowboarding',
    Stairs = 'Stairs',
    StepTraining = 'StepTraining',
    WheelchairWalkPace = 'WheelchairWalkPace',
    WheelchairRunPace = 'WheelchairRunPace',
    TaiChi = 'TaiChi',
    MixedCardio = 'MixedCardio',
    HandCycling = 'HandCycling',
    SwimBikeRun = 'SwimBikeRun',
    Transition = 'Transition',
    UnderwaterDiving = 'UnderwaterDiving',
    Other = 'Other',
  }

  export enum HealthPermission {
    ActiveEnergyBurned = 'ActiveEnergyBurned',
    ActivitySummary = 'ActivitySummary',
    AllergyRecord = 'AllergyRecord',
    AppleExerciseTime = 'AppleExerciseTime',
    AppleStandTime = 'AppleStandTime',
    BasalEnergyBurned = 'BasalEnergyBurned',
    BiologicalSex = 'BiologicalSex',
    BloodType = 'BloodType',
    BloodAlcoholContent = 'BloodAlcoholContent',
    BloodGlucose = 'BloodGlucose',
    BloodPressureDiastolic = 'BloodPressureDiastolic',
    BloodPressureSystolic = 'BloodPressureSystolic',
    BodyFatPercentage = 'BodyFatPercentage',
    BodyMass = 'BodyMass',
    BodyMassIndex = 'BodyMassIndex',
    BodyTemperature = 'BodyTemperature',
    DateOfBirth = 'DateOfBirth',
    Biotin = 'Biotin',
    Caffeine = 'Caffeine',
    Calcium = 'Calcium',
    Carbohydrates = 'Carbohydrates',
    Chloride = 'Chloride',
    Cholesterol = 'Cholesterol',
    ConditionRecord = 'ConditionRecord',
    Copper = 'Copper',
    CoverageRecord = 'CoverageRecord',
    EnergyConsumed = 'EnergyConsumed',
    EnvironmentalAudioExposure = 'EnvironmentalAudioExposure',
    FatMonounsaturated = 'FatMonounsaturated',
    FatPolyunsaturated = 'FatPolyunsaturated',
    FatSaturated = 'FatSaturated',
    FatTotal = 'FatTotal',
    Fiber = 'Fiber',
    Folate = 'Folate',
    HeadphoneAudioExposure = 'HeadphoneAudioExposure',
    ImmunizationRecord = 'ImmunizationRecord',
    InsulinDelivery = 'InsulinDelivery',
    Iodine = 'Iodine',
    Iron = 'Iron',
    LabResultRecord = 'LabResultRecord',
    Magnesium = 'Magnesium',
    Manganese = 'Manganese',
    MedicationRecord = 'MedicationRecord',
    Molybdenum = 'Molybdenum',
    Niacin = 'Niacin',
    OxygenSaturation = 'OxygenSaturation',
    PantothenicAcid = 'PantothenicAcid',
    Phosphorus = 'Phosphorus',
    Potassium = 'Potassium',
    ProcedureRecord = 'ProcedureRecord',
    Protein = 'Protein',
    Riboflavin = 'Riboflavin',
    Selenium = 'Selenium',
    Sodium = 'Sodium',
    Sugar = 'Sugar',
    Thiamin = 'Thiamin',
    VitalSignRecord = 'VitalSignRecord',
    VitaminA = 'VitaminA',
    VitaminB12 = 'VitaminB12',
    VitaminB6 = 'VitaminB6',
    VitaminC = 'VitaminC',
    VitaminD = 'VitaminD',
    VitaminE = 'VitaminE',
    VitaminK = 'VitaminK',
    Zinc = 'Zinc',
    Water = 'Water',
    DistanceCycling = 'DistanceCycling',
    DistanceSwimming = 'DistanceSwimming',
    DistanceWalkingRunning = 'DistanceWalkingRunning',
    DistanceWheelchair = 'DistanceWheelchair',
    DistanceDownhillSnowSports = 'DistanceDownhillSnowSports',
    Electrocardiogram = 'Electrocardiogram',
    FlightsClimbed = 'FlightsClimbed',
    HeartbeatSeries = 'HeartbeatSeries',
    HeartRate = 'HeartRate',
    RestingHeartRate = 'RestingHeartRate',
    HeartRateVariability = 'HeartRateVariability',
    Height = 'Height',
    LeanBodyMass = 'LeanBodyMass',
    MindfulSession = 'MindfulSession',
    NikeFuel = 'NikeFuel',
    PeakFlow = 'PeakFlow',
    RespiratoryRate = 'RespiratoryRate',
    SleepAnalysis = 'SleepAnalysis',
    StepCount = 'StepCount',
    Steps = 'Steps',
    Vo2Max = 'Vo2Max',
    WaistCircumference = 'WaistCircumference',
    WalkingHeartRateAverage = 'WalkingHeartRateAverage',
    Weight = 'Weight',
    Workout = 'Workout',
    WorkoutRoute = 'WorkoutRoute',
    RunningSpeed = 'RunningSpeed',
    RunningPower = 'RunningPower',
    RunningStrideLength = 'RunningStrideLength',
    RunningVerticalOscillation = 'RunningVerticalOscillation',
    RunningGroundContactTime = 'RunningGroundContactTime',
    AbdominalCramps = 'AbdominalCramps',
    Acne = 'Acne',
    AppetiteChanges = 'AppetiteChanges',
    AppleMoveTime = 'AppleMoveTime',
    AppleSleepingBreathingDisturbances = 'AppleSleepingBreathingDisturbances',
    AppleSleepingWristTemperature = 'AppleSleepingWristTemperature',
    AppleStandHour = 'AppleStandHour',
    AppleWalkingSteadiness = 'AppleWalkingSteadiness',
    AppleWalkingSteadinessEvent = 'AppleWalkingSteadinessEvent',
    AtrialFibrillationBurden = 'AtrialFibrillationBurden',
    AudioExposureEvent = 'AudioExposureEvent',
    BasalBodyTemperature = 'BasalBodyTemperature',
    BladderIncontinence = 'BladderIncontinence',
    BleedingAfterPregnancy = 'BleedingAfterPregnancy',
    BleedingDuringPregnancy = 'BleedingDuringPregnancy',
    Bloating = 'Bloating',
    BreastPain = 'BreastPain',
    CervicalMucusQuality = 'CervicalMucusQuality',
    ChestTightnessOrPain = 'ChestTightnessOrPain',
    Chills = 'Chills',
    Constipation = 'Constipation',
    Contraceptive = 'Contraceptive',
    Coughing = 'Coughing',
    CrossCountrySkiingSpeed = 'CrossCountrySkiingSpeed',
    CyclingCadence = 'CyclingCadence',
    CyclingFunctionalThresholdPower = 'CyclingFunctionalThresholdPower',
    CyclingPower = 'CyclingPower',
    CyclingSpeed = 'CyclingSpeed',
    Diarrhea = 'Diarrhea',
    DietaryChromium = 'DietaryChromium',
    DistanceCrossCountrySkiing = 'DistanceCrossCountrySkiing',
    DistancePaddleSports = 'DistancePaddleSports',
    DistanceRowing = 'DistanceRowing',
    DistanceSkatingSports = 'DistanceSkatingSports',
    Dizziness = 'Dizziness',
    DrySkin = 'DrySkin',
    ElectrodermalActivity = 'ElectrodermalActivity',
    EnvironmentalAudioExposureEvent = 'EnvironmentalAudioExposureEvent',
    EnvironmentalSoundReduction = 'EnvironmentalSoundReduction',
    EstimatedWorkoutEffortScore = 'EstimatedWorkoutEffortScore',
    Fainting = 'Fainting',
    Fatigue = 'Fatigue',
    Fever = 'Fever',
    ForcedExpiratoryVolume1 = 'ForcedExpiratoryVolume1',
    ForcedVitalCapacity = 'ForcedVitalCapacity',
    GeneralizedBodyAche = 'GeneralizedBodyAche',
    HairLoss = 'HairLoss',
    HandwashingEvent = 'HandwashingEvent',
    Headache = 'Headache',
    HeadphoneAudioExposureEvent = 'HeadphoneAudioExposureEvent',
    HeartRateRecoveryOneMinute = 'HeartRateRecoveryOneMinute',
    Heartburn = 'Heartburn',
    HighHeartRateEvent = 'HighHeartRateEvent',
    HotFlashes = 'HotFlashes',
    HypertensionEvent = 'HypertensionEvent',
    InfrequentMenstrualCycles = 'InfrequentMenstrualCycles',
    InhalerUsage = 'InhalerUsage',
    IntermenstrualBleeding = 'IntermenstrualBleeding',
    IrregularHeartRhythmEvent = 'IrregularHeartRhythmEvent',
    IrregularMenstrualCycles = 'IrregularMenstrualCycles',
    Lactation = 'Lactation',
    LossOfSmell = 'LossOfSmell',
    LossOfTaste = 'LossOfTaste',
    LowCardioFitnessEvent = 'LowCardioFitnessEvent',
    LowHeartRateEvent = 'LowHeartRateEvent',
    LowerBackPain = 'LowerBackPain',
    MemoryLapse = 'MemoryLapse',
    MenstrualFlow = 'MenstrualFlow',
    MoodChanges = 'MoodChanges',
    Nausea = 'Nausea',
    NightSweats = 'NightSweats',
    NumberOfAlcoholicBeverages = 'NumberOfAlcoholicBeverages',
    NumberOfTimesFallen = 'NumberOfTimesFallen',
    OvulationTestResult = 'OvulationTestResult',
    PaddleSportsSpeed = 'PaddleSportsSpeed',
    PelvicPain = 'PelvicPain',
    PeripheralPerfusionIndex = 'PeripheralPerfusionIndex',
    PersistentIntermenstrualBleeding = 'PersistentIntermenstrualBleeding',
    PhysicalEffort = 'PhysicalEffort',
    Pregnancy = 'Pregnancy',
    PregnancyTestResult = 'PregnancyTestResult',
    ProgesteroneTestResult = 'ProgesteroneTestResult',
    ProlongedMenstrualPeriods = 'ProlongedMenstrualPeriods',
    PushCount = 'PushCount',
    RapidPoundingOrFlutteringHeartbeat = 'RapidPoundingOrFlutteringHeartbeat',
    RowingSpeed = 'RowingSpeed',
    RunnyNose = 'RunnyNose',
    SexualActivity = 'SexualActivity',
    ShortnessOfBreath = 'ShortnessOfBreath',
    SinusCongestion = 'SinusCongestion',
    SixMinuteWalkTestDistance = 'SixMinuteWalkTestDistance',
    SkippedHeartbeat = 'SkippedHeartbeat',
    SleepApneaEvent = 'SleepApneaEvent',
    SleepChanges = 'SleepChanges',
    SoreThroat = 'SoreThroat',
    StairAscentSpeed = 'StairAscentSpeed',
    StairDescentSpeed = 'StairDescentSpeed',
    SwimmingStrokeCount = 'SwimmingStrokeCount',
    TimeInDaylight = 'TimeInDaylight',
    ToothbrushingEvent = 'ToothbrushingEvent',
    UVExposure = 'UVExposure',
    UnderwaterDepth = 'UnderwaterDepth',
    VaginalDryness = 'VaginalDryness',
    Vomiting = 'Vomiting',
    WalkingAsymmetryPercentage = 'WalkingAsymmetryPercentage',
    WalkingDoubleSupportPercentage = 'WalkingDoubleSupportPercentage',
    WalkingSpeed = 'WalkingSpeed',
    WalkingStepLength = 'WalkingStepLength',
    WaterTemperature = 'WaterTemperature',
    Wheezing = 'Wheezing',
    WorkoutEffortScore = 'WorkoutEffortScore',
    StateOfMind = 'StateOfMind',
    GAD7Assessment = 'GAD7Assessment',
    PHQ9Assessment = 'PHQ9Assessment',
    MedicationDoseEvent = 'MedicationDoseEvent',
    UserAnnotatedMedications = 'UserAnnotatedMedications',
  }

  export enum HealthUnit {
    bpm = 'bpm',
    calorie = 'calorie',
    celsius = 'celsius',
    count = 'count',
    day = 'day',
    fahrenheit = 'fahrenheit',
    foot = 'foot',
    gram = 'gram',
    hour = 'hour',
    inch = 'inch',
    joule = 'joule',
    kilocalorie = 'kilocalorie',
    meter = 'meter',
    mgPerdL = 'mgPerdL',
    mile = 'mile',
    minute = 'minute',
    mmhg = 'mmhg',
    literPerMinute = 'literPerMinute',
    mmolPerL = 'mmolPerL',
    percent = 'percent',
    pound = 'pound',
    second = 'second',
    kilometer = 'kilometer',
    liter = 'liter',
    milliliter = 'milliliter',
    milligram = 'milligram',
    microgram = 'microgram',
    watt = 'watt',
    rpm = 'rpm',
    meterPerSecond = 'meterPerSecond',
    kmPerHour = 'kmPerHour',
    milePerHour = 'milePerHour',
    kcalPerKgHour = 'kcalPerKgHour',
    decibel = 'decibel',
    microsiemens = 'microsiemens',
    appleEffortScore = 'appleEffortScore',
    mlPerKgMin = 'mlPerKgMin',
  }

  export type StateOfMindKind = 'MomentaryEmotion' | 'DailyMood'

  export type StateOfMindValenceClassification =
    | 'VeryUnpleasant'
    | 'Unpleasant'
    | 'SlightlyUnpleasant'
    | 'Neutral'
    | 'SlightlyPleasant'
    | 'Pleasant'
    | 'VeryPleasant'

  export type StateOfMindLabel =
    | 'Amazed' | 'Amused' | 'Angry' | 'Anxious' | 'Ashamed' | 'Brave' | 'Calm' | 'Content'
    | 'Disappointed' | 'Discouraged' | 'Disgusted' | 'Embarrassed' | 'Excited' | 'Frustrated'
    | 'Grateful' | 'Guilty' | 'Happy' | 'Hopeless' | 'Irritated' | 'Jealous' | 'Joyful' | 'Lonely'
    | 'Passionate' | 'Peaceful' | 'Proud' | 'Relieved' | 'Sad' | 'Scared' | 'Stressed' | 'Surprised'
    | 'Worried' | 'Annoyed' | 'Confident' | 'Drained' | 'Hopeful' | 'Indifferent' | 'Overwhelmed'
    | 'Satisfied'

  export type StateOfMindAssociation =
    | 'Community' | 'CurrentEvents' | 'Dating' | 'Education' | 'Family' | 'Fitness' | 'Friends'
    | 'Health' | 'Hobbies' | 'Identity' | 'Money' | 'Partner' | 'SelfCare' | 'Spirituality'
    | 'Tasks' | 'Travel' | 'Work' | 'Weather'

  export interface StateOfMindQueryOptions {
    startDate?: string
    endDate?: string
    limit?: number
    ascending?: boolean
    kind?: StateOfMindKind
  }

  export interface StateOfMindSample {
    id: string
    kind: StateOfMindKind
    /** -1 (very unpleasant) .. 1 (very pleasant) */
    valence: number
    valenceClassification: StateOfMindValenceClassification
    labels: StateOfMindLabel[]
    associations: StateOfMindAssociation[]
    startDate: string
    endDate: string
    sourceName: string
    sourceId: string
    metadata: Record<string, string | number>
  }

  export interface StateOfMindSaveOptions {
    /** ISO date; defaults to now */
    date?: string
    /** defaults to 'MomentaryEmotion' */
    kind?: StateOfMindKind
    /** -1 .. 1 */
    valence: number
    labels?: StateOfMindLabel[]
    associations?: StateOfMindAssociation[]
    metadata?: Record<string, string | number>
  }

  export type ScoredAssessmentType = 'GAD7' | 'PHQ9'

  export type GAD7Risk = 'NoneToMinimal' | 'Mild' | 'Moderate' | 'Severe'
  export type PHQ9Risk = 'NoneToMinimal' | 'Mild' | 'Moderate' | 'ModeratelySevere' | 'Severe'

  export interface ScoredAssessmentQueryOptions {
    /** defaults to 'GAD7' */
    type?: ScoredAssessmentType
    startDate?: string
    endDate?: string
    limit?: number
    ascending?: boolean
  }

  export interface ScoredAssessmentSample {
    id: string
    type: ScoredAssessmentType
    score: number
    risk: GAD7Risk | PHQ9Risk
    /** 0 = not at all, 1 = several days, 2 = more than half the days, 3 = nearly every day (PHQ-9: 4 = prefer not to answer) */
    answers: number[]
    startDate: string
    endDate: string
    sourceName: string
    sourceId: string
    metadata: Record<string, string | number>
  }

  export interface ScoredAssessmentSaveOptions {
    type: ScoredAssessmentType
    /** ISO date; defaults to now */
    date?: string
    /** 7 answers for GAD7, 9 for PHQ9 */
    answers: number[]
    metadata?: Record<string, string | number>
  }

  export type MedicationGeneralForm =
    | 'capsule' | 'cream' | 'device' | 'drops' | 'foam' | 'gel' | 'inhaler' | 'injection'
    | 'liquid' | 'lotion' | 'ointment' | 'patch' | 'powder' | 'spray' | 'suppository'
    | 'tablet' | 'topical' | 'unknown'
    | (string & {})

  export interface MedicationClinicalCoding {
    system: string
    version: string | null
    code: string
  }

  export interface MedicationConcept {
    /** Opaque id; pass it to getMedicationDoseEvents({ medicationIds }) */
    id: string
    displayText: string
    generalForm: MedicationGeneralForm
    relatedCodings: MedicationClinicalCoding[]
  }

  export interface UserAnnotatedMedicationsQueryOptions {
    isArchived?: boolean
    hasSchedule?: boolean
    limit?: number
  }

  export interface UserAnnotatedMedication {
    medication: MedicationConcept
    nickname: string | null
    isArchived: boolean
    hasSchedule: boolean
  }

  export type MedicationDoseLogStatus =
    | 'NotInteracted'
    | 'NotificationNotSent'
    | 'Snoozed'
    | 'Taken'
    | 'Skipped'
    | 'NotLogged'

  export interface MedicationDoseEventQueryOptions {
    startDate?: string
    endDate?: string
    limit?: number
    ascending?: boolean
    /** ids from getUserAnnotatedMedications */
    medicationIds?: string[]
    logStatus?: MedicationDoseLogStatus | MedicationDoseLogStatus[]
  }

  export interface MedicationDoseEvent {
    id: string
    medicationId: string
    scheduleType: 'AsNeeded' | 'Schedule'
    logStatus: MedicationDoseLogStatus
    scheduledDate: string | null
    scheduledDoseQuantity: number | null
    doseQuantity: number | null
    /** HealthKit unit string, e.g. "count" */
    unit: string
    startDate: string
    endDate: string
    sourceName: string
    sourceId: string
    metadata: Record<string, string | number>
  }

  export enum HealthStatusCode {
    NotDetermined = 0,
    SharingDenied = 1,
    SharingAuthorized = 2,
  }

  export interface HealthStatusResult {
    permissions: {
      read: HealthStatusCode[]
      write: HealthStatusCode[]
    }
  }

  export interface AnchoredQueryResults {
    anchor: string
    data: Array<HKWorkoutQueriedSampleType>
  }

  export interface WorkoutRouteQueryResults {
    anchor: string
    data: HKWorkoutRouteSampleType
  }

  export enum HealthObserver {
    AllergyRecord = 'AllergyRecord',
    ConditionRecord = 'ConditionRecord',
    CoverageRecord = 'CoverageRecord',
    Cycling = 'Cycling',
    HeartRate = 'HeartRate',
    ImmunizationRecord = 'ImmunizationRecord',
    LabResultRecord = 'LabResultRecord',
    MedicationRecord = 'MedicationRecord',
    ProcedureRecord = 'ProcedureRecord',
    RestingHeartRate = 'RestingHeartRate',
    Running = 'Running',
    StairClimbing = 'StairClimbing',
    VitalSignRecord = 'VitalSignRecord',
    Walking = 'Walking',
    Workout = 'Workout',
  }

  export enum ElectrocardiogramClassification {
    NotSet = 'NotSet',
    SinusRhythm = 'SinusRhythm',
    AtrialFibrillation = 'AtrialFibrillation',
    InconclusiveLowHeartRate = 'InconclusiveLowHeartRate',
    InconclusiveHighHeartRate = 'InconclusiveHighHeartRate',
    InconclusivePoorReading = 'InconclusivePoorReading',
    InconclusiveOther = 'InconclusiveOther',
    Unrecognized = 'Unrecognized',
  }

  export enum BloodGlucoseMealTime {
    Preprandial = 1,
    Postprandial = 2,
  }

  export enum InsulinDeliveryReason {
    Basal = 1,
    Bolus = 2,
  }

  const appleHealthKit: AppleHealthKit

  export default appleHealthKit
}
