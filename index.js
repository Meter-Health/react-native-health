import { Activities, Observers, Permissions, Units } from './src/constants'
import NativeAppleHealthKit from './src/NativeAppleHealthKit'

// TurboModuleRegistry (New Architecture) first, legacy NativeModules as a fallback
// for apps still running the old bridge / interop layer.
const AppleHealthKit =
  NativeAppleHealthKit ?? require('react-native').NativeModules.AppleHealthKit

export const HealthKit = Object.assign({}, AppleHealthKit, {
  Constants: {
    Activities,
    Observers,
    Permissions,
    Units,
  },
})

module.exports = HealthKit
