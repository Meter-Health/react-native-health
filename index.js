import { Activities, Observers, Permissions, Units } from './src/constants'
import NativeAppleHealthKit from './src/NativeAppleHealthKit'

// TurboModuleRegistry (New Architecture) first, legacy NativeModules as a fallback
// for apps still running the old bridge / interop layer.
const AppleHealthKit =
  NativeAppleHealthKit ?? require('react-native').NativeModules.AppleHealthKit

const Constants = {
  Activities,
  Observers,
  Permissions,
  Units,
}

// TurboModule methods are resolved lazily on first access, so they are not
// enumerable own properties yet when this module is evaluated. Copying with
// Object.assign / spread would therefore drop every method under the New
// Architecture; forward property access to the native module instead.
export const HealthKit = new Proxy(AppleHealthKit ?? {}, {
  get(target, prop) {
    return prop === 'Constants' ? Constants : Reflect.get(target, prop)
  },
  has(target, prop) {
    return prop === 'Constants' || Reflect.has(target, prop)
  },
})

module.exports = HealthKit
