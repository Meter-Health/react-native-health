//
//  RCTAppleHealthKit+TypesAndPermissions.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+TypesAndPermissions.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (TypesAndPermissions)

#pragma mark - HealthKit Permissions

- (nullable HKObjectType *)getReadPermFromText:(nonnull NSString*)key {
    UIDevice *deviceInfo = [UIDevice currentDevice];
    float systemVersion = deviceInfo.systemVersion.floatValue;

    // Characteristic Identifiers
    if ([@"Height" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    } else if ([@"Weight" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    } else if ([@"DateOfBirth" isEqualToString: key]) {
        return [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    } else if ([@"BiologicalSex" isEqualToString: key]) {
        return [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    } else if ([@"BloodType" isEqualToString: key]) {
        return [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];
    } else if ([@"PeakFlow" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPeakExpiratoryFlowRate];
    } else if ([@"WaistCircumference" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierWaistCircumference];
    }

    // Body Measurements
    if ([@"BodyMass" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    } else if ([@"BodyFatPercentage" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    } else if ([@"BodyMassIndex" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    } else if ([@"LeanBodyMass" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass];
    }

    // Hearing Identifiers
    if (@available(iOS 13.0, *)) {
        if ([@"EnvironmentalAudioExposure" isEqualToString:key]) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierEnvironmentalAudioExposure];
        } else if ([@"HeadphoneAudioExposure" isEqualToString:key]) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeadphoneAudioExposure];
        }
    }

    // Fitness Identifiers
    if ([@"Steps" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if ([@"StepCount" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if ([@"DistanceWalkingRunning" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    } else if ([@"RunningSpeed" isEqualToString: key]) {
        if (@available(iOS 16.0, *)) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningSpeed];
        } else {
            return nil;
        }
    } else if ([@"DistanceCycling" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    } else if ([@"DistanceSwimming" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceSwimming];
    } else if ([@"DistanceWheelchair" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWheelchair];
    } else if ([@"DistanceDownhillSnowSports" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceDownhillSnowSports];
    } else if ([@"BasalEnergyBurned" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    } else if ([@"ActiveEnergyBurned" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    } else if ([@"FlightsClimbed" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    } else if ([@"NikeFuel" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierNikeFuel];
    } else if ([@"AppleStandTime" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleStandTime];
    } else if ([@"AppleExerciseTime" isEqualToString: key] && systemVersion >= 9.3) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleExerciseTime];
    } else if ([@"RunningPower" isEqualToString:key]) {
        if (@available(iOS 16.0, *)) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningPower];
        } else {
            return nil;
        }
    } else if ([@"RunningStrideLength" isEqualToString:key]) {
        if (@available(iOS 16.0, *)) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningStrideLength];
        } else {
            return nil;
        }
    } else if ([@"RunningVerticalOscillation" isEqualToString:key]) {
        if (@available(iOS 16.0, *)) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningVerticalOscillation];
        } else {
            return nil;
        }
    } else if ([@"RunningGroundContactTime" isEqualToString:key]) {
        if (@available(iOS 16.0, *)) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningGroundContactTime];
        } else {
            return nil;
        }
    }

    // Nutrition Identifiers
    if ([@"Biotin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryBiotin];
    } else if ([@"Caffeine" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCaffeine];
    } else if ([@"Calcium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCalcium];
    } else if ([@"Carbohydrates" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates];
    } else if ([@"Chloride" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryChloride];
    } else if ([@"Cholesterol" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCholesterol];
    } else if ([@"Copper" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCopper];
    } else if ([@"EnergyConsumed" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    } else if ([@"FatMonounsaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatMonounsaturated];
    } else if ([@"FatPolyunsaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatPolyunsaturated];
    } else if ([@"FatSaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatSaturated];
    } else if ([@"FatTotal" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatTotal];
    } else if ([@"Fiber" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFiber];
    } else if ([@"Folate" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFolate];
    } else if ([@"Iodine" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIodine];
    } else if ([@"Iron" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIron];
    } else if ([@"Magnesium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMagnesium];
    } else if ([@"Manganese" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryManganese];
    } else if ([@"Molybdenum" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMolybdenum];
    } else if ([@"Niacin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryNiacin];
    } else if ([@"PantothenicAcid" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPantothenicAcid];
    } else if ([@"Phosphorus" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPhosphorus];
    } else if ([@"Potassium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPotassium];
    } else if ([@"Protein" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryProtein];
    } else if ([@"Riboflavin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryRiboflavin];
    } else if ([@"Selenium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySelenium];
    } else if ([@"Sodium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySodium];
    } else if ([@"Sugar" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySugar];
    } else if ([@"Thiamin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryThiamin];
    } else if ([@"VitaminA" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminA];
    } else if ([@"VitaminB12" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB12];
    } else if ([@"VitaminB6" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB6];
    } else if ([@"VitaminC" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminC];
    } else if ([@"VitaminD" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminD];
    } else if ([@"VitaminE" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminE];
    } else if ([@"VitaminK" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminK];
    } else if ([@"Zinc" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryZinc];
    } else if ([@"Water" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryWater];
    } else if ([@"BloodGlucose" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    } else if ([@"InsulinDelivery" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierInsulinDelivery];
    }

    // Vital Signs Identifiers
    if ([@"HeartRate" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    } else if ([@"WalkingHeartRateAverage" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingHeartRateAverage];
    } else if ([@"RestingHeartRate" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRestingHeartRate];
    } else if ([@"HeartRateVariability" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRateVariabilitySDNN];
    }  else if ([@"HeartbeatSeries" isEqualToString: key] && systemVersion >= 13.0) {
        return [HKObjectType seriesTypeForIdentifier:HKDataTypeIdentifierHeartbeatSeries];
    } else if ([@"Vo2Max" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierVO2Max];
    } else if ([@"BodyTemperature" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    } else if ([@"BloodPressureSystolic" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    } else if ([@"BloodPressureDiastolic" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    } else if ([@"RespiratoryRate" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate];
    } else if ([@"OxygenSaturation" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierOxygenSaturation];
    } else if ([@"Electrocardiogram" isEqualToString:key] && systemVersion >= 14.0) {
        return HKObjectType.electrocardiogramType;
    }

    // Sleep
    if ([@"SleepAnalysis" isEqualToString: key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    }

    // workouts
    if ([@"MindfulSession" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession];
    } else if ([@"MindfulSession" isEqualToString: key]){
        return [HKObjectType workoutType];
    } else if ([@"Workout" isEqualToString: key]) {
        return [HKObjectType workoutType];
    }else if ([@"WorkoutRoute" isEqualToString:key]){
        return [HKSeriesType workoutRouteType];
    }

    // Lab and tests
    if ([@"BloodAlcoholContent" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];
    }
    
    // Activity Summary
    if ([@"ActivitySummary" isEqualToString:key]){
        return [HKObjectType activitySummaryType];
    }
    
    // Clinical Records
    if ([@"AllergyRecord" isEqualToString:key]) {
        return [RCTAppleHealthKit clinicalTypeFromName:@"AllergyRecord"];
    } else if ([@"ConditionRecord" isEqualToString:key]) {
        return [RCTAppleHealthKit clinicalTypeFromName:@"ConditionRecord"];
    } else if ([@"CoverageRecord" isEqualToString:key]) {
        return [RCTAppleHealthKit clinicalTypeFromName:@"CoverageRecord"];
    } else if ([@"ImmunizationRecord" isEqualToString:key]) {
        return [RCTAppleHealthKit clinicalTypeFromName:@"ImmunizationRecord"];
    } else if ([@"LabResultRecord" isEqualToString:key]) {
        return [RCTAppleHealthKit clinicalTypeFromName:@"LabResultRecord"];
    } else if ([@"MedicationRecord" isEqualToString:key]) {
        return [RCTAppleHealthKit clinicalTypeFromName:@"MedicationRecord"];
    } else if ([@"ProcedureRecord" isEqualToString:key]) {
        return [RCTAppleHealthKit clinicalTypeFromName:@"ProcedureRecord"];
    } else if ([@"VitalSignRecord" isEqualToString:key]) {
        return [RCTAppleHealthKit clinicalTypeFromName:@"VitalSignRecord"];
    }

    HKObjectType *wellbeingOrMedication = [RCTAppleHealthKit wellbeingOrMedicationTypeFromName:key];
    if (wellbeingOrMedication != nil) {
        return wellbeingOrMedication;
    }
    return [RCTAppleHealthKit extendedSampleTypeFromName:key];
}

- (nullable HKObjectType *)getWritePermFromText:(nonnull NSString*) key {
    // Body Measurements
    if ([@"Height" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    } else if ([@"PeakFlow" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPeakExpiratoryFlowRate];
    } else if ([@"WaistCircumference" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierWaistCircumference];
    } else if ([@"Weight" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    } else if ([@"BodyMass" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    } else if ([@"BodyFatPercentage" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    } else if ([@"BodyMassIndex" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    } else if ([@"LeanBodyMass" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass];
    } else if ([@"BodyTemperature" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    }

    // Fitness Identifiers
    if ([@"Steps" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if ([@"StepCount" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if ([@"DistanceWalkingRunning" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    } else if ([@"RunningSpeed" isEqualToString:key]) {
        if (@available(iOS 16.0, *)) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningSpeed];
        } else {
            return nil;
        }
    } else if ([@"DistanceCycling" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    } else if ([@"DistanceSwimming" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceSwimming];
    } else if ([@"DistanceWheelchair" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWheelchair];
    } else if ([@"DistanceDownhillSnowSports" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceDownhillSnowSports];
    } else if ([@"BasalEnergyBurned" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    } else if ([@"ActiveEnergyBurned" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    } else if ([@"FlightsClimbed" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    } else if ([@"RunningPower" isEqualToString:key]) {
        if (@available(iOS 16.0, *)) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningPower];
        } else {
            return nil;
        }
    } else if ([@"RunningStrideLength" isEqualToString:key]) {
        if (@available(iOS 16.0, *)) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningStrideLength];
        } else {
            return nil;
        }
    } else if ([@"RunningVerticalOscillation" isEqualToString:key]) {
        if (@available(iOS 16.0, *)) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningVerticalOscillation];
        } else {
            return nil;
        }
    } else if ([@"RunningGroundContactTime" isEqualToString:key]) {
        if (@available(iOS 16.0, *)) {
            return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningGroundContactTime];
        } else {
            return nil;
        }
    }

    // Nutrition Identifiers
    if ([@"Biotin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryBiotin];
    } else if ([@"Caffeine" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCaffeine];
    } else if ([@"Calcium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCalcium];
    } else if ([@"Carbohydrates" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates];
    } else if ([@"Chloride" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryChloride];
    } else if ([@"Cholesterol" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCholesterol];
    } else if ([@"Copper" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCopper];
    } else if ([@"EnergyConsumed" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    } else if ([@"FatMonounsaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatMonounsaturated];
    } else if ([@"FatPolyunsaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatPolyunsaturated];
    } else if ([@"FatSaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatSaturated];
    } else if ([@"FatTotal" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatTotal];
    } else if ([@"Fiber" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFiber];
    } else if ([@"Folate" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFolate];
    } else if ([@"Iodine" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIodine];
    } else if ([@"Iron" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIron];
    } else if ([@"Magnesium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMagnesium];
    } else if ([@"Manganese" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryManganese];
    } else if ([@"Molybdenum" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMolybdenum];
    } else if ([@"Niacin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryNiacin];
    } else if ([@"PantothenicAcid" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPantothenicAcid];
    } else if ([@"Phosphorus" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPhosphorus];
    } else if ([@"Potassium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPotassium];
    } else if ([@"Protein" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryProtein];
    } else if ([@"Riboflavin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryRiboflavin];
    } else if ([@"Selenium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySelenium];
    } else if ([@"Sodium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySodium];
    } else if ([@"Sugar" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySugar];
    } else if ([@"Thiamin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryThiamin];
    } else if ([@"VitaminA" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminA];
    } else if ([@"VitaminB12" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB12];
    } else if ([@"VitaminB6" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB6];
    } else if ([@"VitaminC" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminC];
    } else if ([@"VitaminD" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminD];
    } else if ([@"VitaminE" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminE];
    } else if ([@"VitaminK" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminK];
    } else if ([@"Zinc" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryZinc];
    } else if ([@"Water" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryWater];
    } else if ([@"BloodGlucose" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    } else if ([@"InsulinDelivery" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierInsulinDelivery];
    }

    // Sleep
    if ([@"SleepAnalysis" isEqualToString:key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    }

    // Mindfulness
    if ([@"MindfulSession" isEqualToString:key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession];
    }

    // Workout
    if ([@"Workout" isEqualToString:key]) {
        return [HKObjectType workoutType];
    }
    
    // Workout Route
    if ([@"WorkoutRoute" isEqualToString:key]) {
        if (@available(iOS 11.0, *)) {
            return [HKSeriesType workoutRouteType];
        } else {
            return nil;
        }
    }

    // Lab and tests
    if ([@"BloodAlcoholContent" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];
    }
    if ([@"HeartRate" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    } else if ([@"RestingHeartRate" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRestingHeartRate];
    } else if ([@"HeartRateVariability" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRateVariabilitySDNN];
    } else if ([@"ActiveEnergyBurned" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    } else if ([@"BasalEnergyBurned" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    } else if ([@"Vo2Max" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierVO2Max];
    } else if ([@"OxygenSaturation" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierOxygenSaturation];
    } else if ([@"RespiratoryRate" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate];
    }

    if ([RCTAppleHealthKit isReadOnlyTypeName:key]) {
        RCTLogWarn(@"[HealthKit] %@ is read-only in HealthKit; ignoring it in the write permissions", key);
        return nil;
    }
    HKObjectType *wellbeingOrMedication = [RCTAppleHealthKit wellbeingOrMedicationTypeFromName:key];
    if (wellbeingOrMedication != nil) {
        return wellbeingOrMedication;
    }
    return [RCTAppleHealthKit extendedSampleTypeFromName:key];
}

// Returns HealthKit read permissions from options array
- (NSSet *)getReadPermsFromOptions:(NSArray *)options {
    NSMutableSet *readPermSet = [NSMutableSet setWithCapacity:1];

    for(int i=0; i<[options count]; i++) {
        NSString *optionKey = options[i];
        if (optionKey != nil){
            HKObjectType *val = [self getReadPermFromText:optionKey];
            if (val != nil) {
                [readPermSet addObject:val];
            }
        }
    }
    return readPermSet;
}


// Returns HealthKit write permissions from options array
- (NSSet *)getWritePermsFromOptions:(NSArray *)options {
    NSMutableSet *writePermSet = [NSMutableSet setWithCapacity:1];

    for(int i=0; i<[options count]; i++) {
        NSString *optionKey = options[i];
        if (optionKey != nil){
            HKObjectType *val = [self getWritePermFromText:optionKey];
            if (val != nil) {
                [writePermSet addObject:val];
            }
        }
    }
    return writePermSet;
}

- (HKObjectType *)getWritePermFromString:(NSString *)writePerm {
    return [self getWritePermFromText:writePerm];
}

- (NSString *)getAuthorizationStatusString:(HKAuthorizationStatus)status {
    switch (status) {
        case HKAuthorizationStatusNotDetermined:
            return @"NotDetermined";
        case HKAuthorizationStatusSharingDenied:
            return @"SharingDenied";
        case HKAuthorizationStatusSharingAuthorized:
            return @"SharingAuthorized";
    }
}


#pragma mark - Extended identifiers

/*!
    Quantity identifiers that are not covered by the hand-written maps above. Names are the
    HKQuantityTypeIdentifier suffix. Entries that need a newer iOS are only added when running on it.
 */
+ (NSDictionary<NSString *, HKQuantityTypeIdentifier> *)extendedQuantityIdentifiers
{
    static NSDictionary *map = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *m = [NSMutableDictionary dictionary];
        [m addEntriesFromDictionary:@{
            @"AppleMoveTime": HKQuantityTypeIdentifierAppleMoveTime,
            @"AppleWalkingSteadiness": HKQuantityTypeIdentifierAppleWalkingSteadiness,
            @"BasalBodyTemperature": HKQuantityTypeIdentifierBasalBodyTemperature,
            @"DietaryChromium": HKQuantityTypeIdentifierDietaryChromium,
            @"ElectrodermalActivity": HKQuantityTypeIdentifierElectrodermalActivity,
            @"ForcedExpiratoryVolume1": HKQuantityTypeIdentifierForcedExpiratoryVolume1,
            @"ForcedVitalCapacity": HKQuantityTypeIdentifierForcedVitalCapacity,
            @"InhalerUsage": HKQuantityTypeIdentifierInhalerUsage,
            @"NumberOfAlcoholicBeverages": HKQuantityTypeIdentifierNumberOfAlcoholicBeverages,
            @"NumberOfTimesFallen": HKQuantityTypeIdentifierNumberOfTimesFallen,
            @"PeripheralPerfusionIndex": HKQuantityTypeIdentifierPeripheralPerfusionIndex,
            @"PushCount": HKQuantityTypeIdentifierPushCount,
            @"SixMinuteWalkTestDistance": HKQuantityTypeIdentifierSixMinuteWalkTestDistance,
            @"StairAscentSpeed": HKQuantityTypeIdentifierStairAscentSpeed,
            @"StairDescentSpeed": HKQuantityTypeIdentifierStairDescentSpeed,
            @"SwimmingStrokeCount": HKQuantityTypeIdentifierSwimmingStrokeCount,
            @"UVExposure": HKQuantityTypeIdentifierUVExposure,
            @"WalkingAsymmetryPercentage": HKQuantityTypeIdentifierWalkingAsymmetryPercentage,
            @"WalkingDoubleSupportPercentage": HKQuantityTypeIdentifierWalkingDoubleSupportPercentage,
            @"WalkingSpeed": HKQuantityTypeIdentifierWalkingSpeed,
            @"WalkingStepLength": HKQuantityTypeIdentifierWalkingStepLength,
        }];
        if (@available(iOS 16.0, *)) {
            [m addEntriesFromDictionary:@{
                @"AppleSleepingWristTemperature": HKQuantityTypeIdentifierAppleSleepingWristTemperature,
                @"AtrialFibrillationBurden": HKQuantityTypeIdentifierAtrialFibrillationBurden,
                @"EnvironmentalSoundReduction": HKQuantityTypeIdentifierEnvironmentalSoundReduction,
                @"HeartRateRecoveryOneMinute": HKQuantityTypeIdentifierHeartRateRecoveryOneMinute,
                @"UnderwaterDepth": HKQuantityTypeIdentifierUnderwaterDepth,
                @"WaterTemperature": HKQuantityTypeIdentifierWaterTemperature,
            }];
        }
        if (@available(iOS 17.0, *)) {
            [m addEntriesFromDictionary:@{
                @"CyclingCadence": HKQuantityTypeIdentifierCyclingCadence,
                @"CyclingFunctionalThresholdPower": HKQuantityTypeIdentifierCyclingFunctionalThresholdPower,
                @"CyclingPower": HKQuantityTypeIdentifierCyclingPower,
                @"CyclingSpeed": HKQuantityTypeIdentifierCyclingSpeed,
                @"PhysicalEffort": HKQuantityTypeIdentifierPhysicalEffort,
                @"TimeInDaylight": HKQuantityTypeIdentifierTimeInDaylight,
            }];
        }
        if (@available(iOS 18.0, *)) {
            [m addEntriesFromDictionary:@{
                @"AppleSleepingBreathingDisturbances": HKQuantityTypeIdentifierAppleSleepingBreathingDisturbances,
                @"CrossCountrySkiingSpeed": HKQuantityTypeIdentifierCrossCountrySkiingSpeed,
                @"DistanceCrossCountrySkiing": HKQuantityTypeIdentifierDistanceCrossCountrySkiing,
                @"DistancePaddleSports": HKQuantityTypeIdentifierDistancePaddleSports,
                @"DistanceRowing": HKQuantityTypeIdentifierDistanceRowing,
                @"DistanceSkatingSports": HKQuantityTypeIdentifierDistanceSkatingSports,
                @"EstimatedWorkoutEffortScore": HKQuantityTypeIdentifierEstimatedWorkoutEffortScore,
                @"PaddleSportsSpeed": HKQuantityTypeIdentifierPaddleSportsSpeed,
                @"RowingSpeed": HKQuantityTypeIdentifierRowingSpeed,
                @"WorkoutEffortScore": HKQuantityTypeIdentifierWorkoutEffortScore,
            }];
        }
        map = [m copy];
    });
    return map;
}

/*!
    Category identifiers (symptoms, reproductive health, heart / hearing / mobility events, ...).
    Names are the HKCategoryTypeIdentifier suffix.
 */
+ (NSDictionary<NSString *, HKCategoryTypeIdentifier> *)extendedCategoryIdentifiers
{
    static NSDictionary *map = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *m = [NSMutableDictionary dictionary];
        [m addEntriesFromDictionary:@{
            @"AppleStandHour": HKCategoryTypeIdentifierAppleStandHour,
            @"CervicalMucusQuality": HKCategoryTypeIdentifierCervicalMucusQuality,
            @"OvulationTestResult": HKCategoryTypeIdentifierOvulationTestResult,
            @"MenstrualFlow": HKCategoryTypeIdentifierMenstrualFlow,
            @"IntermenstrualBleeding": HKCategoryTypeIdentifierIntermenstrualBleeding,
            @"SexualActivity": HKCategoryTypeIdentifierSexualActivity,
            @"HighHeartRateEvent": HKCategoryTypeIdentifierHighHeartRateEvent,
            @"LowHeartRateEvent": HKCategoryTypeIdentifierLowHeartRateEvent,
            @"IrregularHeartRhythmEvent": HKCategoryTypeIdentifierIrregularHeartRhythmEvent,
            @"AudioExposureEvent": HKCategoryTypeIdentifierAudioExposureEvent,
            @"ToothbrushingEvent": HKCategoryTypeIdentifierToothbrushingEvent,
            @"AbdominalCramps": HKCategoryTypeIdentifierAbdominalCramps,
            @"Acne": HKCategoryTypeIdentifierAcne,
            @"AppetiteChanges": HKCategoryTypeIdentifierAppetiteChanges,
            @"GeneralizedBodyAche": HKCategoryTypeIdentifierGeneralizedBodyAche,
            @"Bloating": HKCategoryTypeIdentifierBloating,
            @"BreastPain": HKCategoryTypeIdentifierBreastPain,
            @"ChestTightnessOrPain": HKCategoryTypeIdentifierChestTightnessOrPain,
            @"Chills": HKCategoryTypeIdentifierChills,
            @"Constipation": HKCategoryTypeIdentifierConstipation,
            @"Coughing": HKCategoryTypeIdentifierCoughing,
            @"Diarrhea": HKCategoryTypeIdentifierDiarrhea,
            @"Dizziness": HKCategoryTypeIdentifierDizziness,
            @"Fainting": HKCategoryTypeIdentifierFainting,
            @"Fatigue": HKCategoryTypeIdentifierFatigue,
            @"Fever": HKCategoryTypeIdentifierFever,
            @"Headache": HKCategoryTypeIdentifierHeadache,
            @"Heartburn": HKCategoryTypeIdentifierHeartburn,
            @"HotFlashes": HKCategoryTypeIdentifierHotFlashes,
            @"LowerBackPain": HKCategoryTypeIdentifierLowerBackPain,
            @"LossOfSmell": HKCategoryTypeIdentifierLossOfSmell,
            @"LossOfTaste": HKCategoryTypeIdentifierLossOfTaste,
            @"MoodChanges": HKCategoryTypeIdentifierMoodChanges,
            @"Nausea": HKCategoryTypeIdentifierNausea,
            @"PelvicPain": HKCategoryTypeIdentifierPelvicPain,
            @"RapidPoundingOrFlutteringHeartbeat": HKCategoryTypeIdentifierRapidPoundingOrFlutteringHeartbeat,
            @"RunnyNose": HKCategoryTypeIdentifierRunnyNose,
            @"ShortnessOfBreath": HKCategoryTypeIdentifierShortnessOfBreath,
            @"SinusCongestion": HKCategoryTypeIdentifierSinusCongestion,
            @"SkippedHeartbeat": HKCategoryTypeIdentifierSkippedHeartbeat,
            @"SleepChanges": HKCategoryTypeIdentifierSleepChanges,
            @"SoreThroat": HKCategoryTypeIdentifierSoreThroat,
            @"Vomiting": HKCategoryTypeIdentifierVomiting,
            @"Wheezing": HKCategoryTypeIdentifierWheezing,
            @"BladderIncontinence": HKCategoryTypeIdentifierBladderIncontinence,
            @"DrySkin": HKCategoryTypeIdentifierDrySkin,
            @"HairLoss": HKCategoryTypeIdentifierHairLoss,
            @"VaginalDryness": HKCategoryTypeIdentifierVaginalDryness,
            @"MemoryLapse": HKCategoryTypeIdentifierMemoryLapse,
            @"NightSweats": HKCategoryTypeIdentifierNightSweats,
            @"EnvironmentalAudioExposureEvent": HKCategoryTypeIdentifierEnvironmentalAudioExposureEvent,
            @"HandwashingEvent": HKCategoryTypeIdentifierHandwashingEvent,
            @"HeadphoneAudioExposureEvent": HKCategoryTypeIdentifierHeadphoneAudioExposureEvent,
            @"Pregnancy": HKCategoryTypeIdentifierPregnancy,
            @"Lactation": HKCategoryTypeIdentifierLactation,
            @"Contraceptive": HKCategoryTypeIdentifierContraceptive,
            @"LowCardioFitnessEvent": HKCategoryTypeIdentifierLowCardioFitnessEvent,
            @"AppleWalkingSteadinessEvent": HKCategoryTypeIdentifierAppleWalkingSteadinessEvent,
            @"PregnancyTestResult": HKCategoryTypeIdentifierPregnancyTestResult,
            @"ProgesteroneTestResult": HKCategoryTypeIdentifierProgesteroneTestResult,
        }];
        if (@available(iOS 16.0, *)) {
            [m addEntriesFromDictionary:@{
                @"InfrequentMenstrualCycles": HKCategoryTypeIdentifierInfrequentMenstrualCycles,
                @"IrregularMenstrualCycles": HKCategoryTypeIdentifierIrregularMenstrualCycles,
                @"PersistentIntermenstrualBleeding": HKCategoryTypeIdentifierPersistentIntermenstrualBleeding,
                @"ProlongedMenstrualPeriods": HKCategoryTypeIdentifierProlongedMenstrualPeriods,
            }];
        }
        if (@available(iOS 18.0, *)) {
            [m addEntriesFromDictionary:@{
                @"BleedingAfterPregnancy": HKCategoryTypeIdentifierBleedingAfterPregnancy,
                @"BleedingDuringPregnancy": HKCategoryTypeIdentifierBleedingDuringPregnancy,
                @"SleepApneaEvent": HKCategoryTypeIdentifierSleepApneaEvent,
            }];
        }
#if defined(__IPHONE_26_2) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_26_2
        // Needs the iOS 26.2 SDK (Xcode 26.2) to compile; older toolchains simply skip it.
        if (@available(iOS 26.2, *)) {
            [m addEntriesFromDictionary:@{
                @"HypertensionEvent": HKCategoryTypeIdentifierHypertensionEvent,
            }];
        }
#endif
        map = [m copy];
    });
    return map;
}

+ (nullable HKSampleType *)extendedSampleTypeFromName:(NSString *)name
{
    HKQuantityTypeIdentifier quantityIdentifier = [self extendedQuantityIdentifiers][name];
    if (quantityIdentifier != nil) {
        return [HKObjectType quantityTypeForIdentifier:quantityIdentifier];
    }
    HKCategoryTypeIdentifier categoryIdentifier = [self extendedCategoryIdentifiers][name];
    if (categoryIdentifier != nil) {
        return [HKObjectType categoryTypeForIdentifier:categoryIdentifier];
    }
    return nil;
}

/*!
    Types HealthKit only lets Apple write. Asking for share authorization on one of these makes
    requestAuthorization fail as a whole, so they are filtered out of the write permissions.
 */
+ (BOOL)isReadOnlyTypeName:(NSString *)name
{
    static NSSet *names = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        names = [NSSet setWithArray:@[
            @"AppleExerciseTime",
            @"AppleStandTime",
            @"AppleMoveTime",
            @"AppleWalkingSteadiness",
            @"AppleSleepingWristTemperature",
            @"AppleSleepingBreathingDisturbances",
            @"AtrialFibrillationBurden",
            @"EstimatedWorkoutEffortScore",
            @"NikeFuel",
            @"AppleStandHour",
            @"HighHeartRateEvent",
            @"LowHeartRateEvent",
            @"IrregularHeartRhythmEvent",
            @"AudioExposureEvent",
            @"EnvironmentalAudioExposureEvent",
            @"HeadphoneAudioExposureEvent",
            @"LowCardioFitnessEvent",
            @"AppleWalkingSteadinessEvent",
            @"SleepApneaEvent",
            @"HypertensionEvent",
            @"MedicationDoseEvent",
            @"UserAnnotatedMedications",
        ]];
    });
    return [names containsObject:name];
}

/*!
    State of Mind / scored assessments (iOS 18) and the Medications API (iOS 26). These are neither
    quantity nor category types, so they get their own lookup.
 */
+ (nullable HKObjectType *)wellbeingOrMedicationTypeFromName:(NSString *)name
{
#if defined(__IPHONE_18_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_18_0
    if (@available(iOS 18.0, *)) {
        if ([name isEqualToString:@"StateOfMind"]) {
            return [HKObjectType stateOfMindType];
        } else if ([name isEqualToString:@"GAD7Assessment"]) {
            return [HKObjectType scoredAssessmentTypeForIdentifier:HKScoredAssessmentTypeIdentifierGAD7];
        } else if ([name isEqualToString:@"PHQ9Assessment"]) {
            return [HKObjectType scoredAssessmentTypeForIdentifier:HKScoredAssessmentTypeIdentifierPHQ9];
        }
    }
#endif
#if defined(__IPHONE_26_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_26_0
    if (@available(iOS 26.0, *)) {
        if ([name isEqualToString:@"MedicationDoseEvent"]) {
            return [HKObjectType medicationDoseEventType];
        } else if ([name isEqualToString:@"UserAnnotatedMedications"]) {
            return [HKObjectType userAnnotatedMedicationType];
        }
    }
#endif
    return nil;
}

+ (NSDictionary *)getStringToWorkoutActivityTypeDictionary {
    NSDictionary *elem = @{
        @"AmericanFootball": @(HKWorkoutActivityTypeAmericanFootball),
        @"Archery": @(HKWorkoutActivityTypeArchery),
        @"AustralianFootball": @(HKWorkoutActivityTypeAustralianFootball),
        @"Badminton": @(HKWorkoutActivityTypeBadminton),
        @"Baseball": @(HKWorkoutActivityTypeBaseball),
        @"Basketball": @(HKWorkoutActivityTypeBasketball),
        @"Bowling": @(HKWorkoutActivityTypeBowling),
        @"Boxing": @(HKWorkoutActivityTypeBoxing),
        @"Climbing": @(HKWorkoutActivityTypeClimbing),
        @"Cricket": @(HKWorkoutActivityTypeCricket),
        @"CrossTraining": @(HKWorkoutActivityTypeCrossTraining),
        @"Curling": @(HKWorkoutActivityTypeCurling),
        @"Cycling": @(HKWorkoutActivityTypeCycling),
        @"Dance": @(HKWorkoutActivityTypeDance),
        @"DanceInspiredTraining": @(HKWorkoutActivityTypeDanceInspiredTraining),
        @"Elliptical": @(HKWorkoutActivityTypeElliptical),
        @"EquestrianSports": @(HKWorkoutActivityTypeEquestrianSports),
        @"Fencing": @(HKWorkoutActivityTypeFencing),
        @"Fishing": @(HKWorkoutActivityTypeFishing),
        @"FunctionalStrengthTraining": @(HKWorkoutActivityTypeFunctionalStrengthTraining),
        @"Golf": @(HKWorkoutActivityTypeGolf),
        @"Gymnastics": @(HKWorkoutActivityTypeGymnastics),
        @"Handball": @(HKWorkoutActivityTypeHandball),
        @"Hiking": @(HKWorkoutActivityTypeHiking),
        @"Hockey": @(HKWorkoutActivityTypeHockey),
        @"Hunting": @(HKWorkoutActivityTypeHunting),
        @"Lacrosse": @(HKWorkoutActivityTypeLacrosse),
        @"MartialArts": @(HKWorkoutActivityTypeMartialArts),
        @"MindAndBody": @(HKWorkoutActivityTypeMindAndBody),
        @"MixedMetabolicCardioTraining": @(HKWorkoutActivityTypeMixedMetabolicCardioTraining),
        @"PaddleSports": @(HKWorkoutActivityTypePaddleSports),
        @"Play": @(HKWorkoutActivityTypePlay),
        @"PreparationAndRecovery": @(HKWorkoutActivityTypePreparationAndRecovery),
        @"Racquetball": @(HKWorkoutActivityTypeRacquetball),
        @"Rowing": @(HKWorkoutActivityTypeRowing),
        @"Rugby": @(HKWorkoutActivityTypeRugby),
        @"Running": @(HKWorkoutActivityTypeRunning),
        @"Sailing": @(HKWorkoutActivityTypeSailing),
        @"SkatingSports": @(HKWorkoutActivityTypeSkatingSports),
        @"SnowSports": @(HKWorkoutActivityTypeSnowSports),
        @"Soccer": @(HKWorkoutActivityTypeSoccer),
        @"Softball": @(HKWorkoutActivityTypeSoftball),
        @"Squash": @(HKWorkoutActivityTypeSquash),
        @"StairClimbing": @(HKWorkoutActivityTypeStairClimbing),
        @"SurfingSports": @(HKWorkoutActivityTypeSurfingSports),
        @"Swimming": @(HKWorkoutActivityTypeSwimming),
        @"TableTennis": @(HKWorkoutActivityTypeTableTennis),
        @"Tennis": @(HKWorkoutActivityTypeTennis),
        @"TrackAndField": @(HKWorkoutActivityTypeTrackAndField),
        @"TraditionalStrengthTraining": @(HKWorkoutActivityTypeTraditionalStrengthTraining),
        @"Volleyball": @(HKWorkoutActivityTypeVolleyball),
        @"Walking": @(HKWorkoutActivityTypeWalking),
        @"WaterFitness": @(HKWorkoutActivityTypeWaterFitness),
        @"WaterPolo": @(HKWorkoutActivityTypeWaterPolo),
        @"WaterSports": @(HKWorkoutActivityTypeWaterSports),
        @"Wrestling": @(HKWorkoutActivityTypeWrestling),
        @"Yoga": @(HKWorkoutActivityTypeYoga),
        @"Barre": @(HKWorkoutActivityTypeBarre),
        @"CoreTraining": @(HKWorkoutActivityTypeCoreTraining),
        @"CrossCountrySkiing": @(HKWorkoutActivityTypeCrossCountrySkiing),
        @"DownhillSkiing": @(HKWorkoutActivityTypeDownhillSkiing),
        @"Flexibility": @(HKWorkoutActivityTypeFlexibility),
        @"HighIntensityIntervalTraining": @(HKWorkoutActivityTypeHighIntensityIntervalTraining),
        @"JumpRope": @(HKWorkoutActivityTypeJumpRope),
        @"Kickboxing": @(HKWorkoutActivityTypeKickboxing),
        @"Pilates": @(HKWorkoutActivityTypePilates),
        @"Snowboarding": @(HKWorkoutActivityTypeSnowboarding),
        @"Stairs": @(HKWorkoutActivityTypeStairs),
        @"StepTraining": @(HKWorkoutActivityTypeStepTraining),
        @"WheelchairWalkPace": @(HKWorkoutActivityTypeWheelchairWalkPace),
        @"WheelchairRunPace": @(HKWorkoutActivityTypeWheelchairRunPace),
        @"TaiChi": @(HKWorkoutActivityTypeTaiChi),
        @"MixedCardio": @(HKWorkoutActivityTypeMixedCardio),
        @"HandCycling": @(HKWorkoutActivityTypeHandCycling),
        @"DiscSports": @(HKWorkoutActivityTypeDiscSports),
        @"FitnessGaming": @(HKWorkoutActivityTypeFitnessGaming),
        @"CardioDance": @(HKWorkoutActivityTypeCardioDance),
        @"SocialDance": @(HKWorkoutActivityTypeSocialDance),
        @"Pickleball": @(HKWorkoutActivityTypePickleball),
        @"Cooldown": @(HKWorkoutActivityTypeCooldown),
        @"SwimBikeRun": @(HKWorkoutActivityTypeSwimBikeRun),
        @"Transition": @(HKWorkoutActivityTypeTransition),
        @"UnderwaterDiving": @(HKWorkoutActivityTypeUnderwaterDiving),
        @"Other": @(HKWorkoutActivityTypeOther),
    };
    return elem;
}


@end
