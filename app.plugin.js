const path = require('path')

// Resolve `@expo/config-plugins` through the app's `expo` install so the plugin
// runs against the config-plugins version that matches the SDK doing the prebuild.
function requireConfigPlugins(subpath) {
  const id = subpath ? `@expo/config-plugins/${subpath}` : '@expo/config-plugins'
  try {
    const expoRoot = path.dirname(
      require.resolve('expo/package.json', { paths: [process.cwd(), __dirname] }),
    )
    return require(require.resolve(id, { paths: [expoRoot] }))
  } catch (e) {
    return require(id)
  }
}

const { withAppDelegate, withEntitlementsPlist, withInfoPlist } = requireConfigPlugins()
const { mergeContents } = requireConfigPlugins('build/utils/generateCode')

const HEALTH_SHARE = 'Allow $(PRODUCT_NAME) to check health info'
const HEALTH_UPDATE = 'Allow $(PRODUCT_NAME) to update health info'
const HEALTH_CLINIC_SHARE = 'Allow $(PRODUCT_NAME) to check health clinical info'

// Same anchor expo's own Maps plugin uses for the Swift AppDelegate template.
const SWIFT_INIT_ANCHOR = /\bsuper\.application\(\w+?, didFinishLaunchingWithOptions: \w+?\)/
const OBJC_INIT_ANCHOR = /\[super application:\w+? didFinishLaunchingWithOptions:\w+?\]/

const withBackgroundObserversAppDelegate = (config) =>
  withAppDelegate(config, (config) => {
    const { language } = config.modResults
    let { contents } = config.modResults

    try {
      if (language === 'swift') {
        contents = mergeContents({
          tag: 'react-native-health-import',
          src: contents,
          newSrc: 'import RNAppleHealthKit',
          anchor: /(@main|@UIApplicationMain)/,
          offset: 0,
          comment: '//',
        }).contents
        contents = mergeContents({
          tag: 'react-native-health-observers',
          src: contents,
          newSrc: '    RCTAppleHealthKit().initializeBackgroundObservers()',
          anchor: SWIFT_INIT_ANCHOR,
          offset: 0,
          comment: '//',
        }).contents
      } else if (language === 'objc' || language === 'objcpp') {
        contents = mergeContents({
          tag: 'react-native-health-import',
          src: contents,
          newSrc: '#import <RNAppleHealthKit/RCTAppleHealthKit.h>',
          anchor: /#import "AppDelegate\.h"/,
          offset: 1,
          comment: '//',
        }).contents
        contents = mergeContents({
          tag: 'react-native-health-observers',
          src: contents,
          newSrc: '  [[RCTAppleHealthKit new] initializeBackgroundObservers];',
          anchor: OBJC_INIT_ANCHOR,
          offset: 0,
          comment: '//',
        }).contents
      } else {
        throw new Error(
          `react-native-health: unsupported AppDelegate language "${language}"`,
        )
      }
    } catch (error) {
      if (error.code === 'ERR_NO_MATCH') {
        throw new Error(
          'react-native-health: could not find the didFinishLaunchingWithOptions call in AppDelegate to register background observers. ' +
            'Add `RCTAppleHealthKit().initializeBackgroundObservers()` manually or disable `enableBackgroundObservers`.',
        )
      }
      throw error
    }

    config.modResults.contents = contents
    return config
  })

const withHealthKit = (
  config,
  {
    healthSharePermission,
    healthUpdatePermission,
    isClinicalDataEnabled,
    healthClinicalDescription,
    enableBackgroundObservers,
  } = {},
) => {
  // Add permissions
  config = withInfoPlist(config, (config) => {
    config.modResults.NSHealthShareUsageDescription =
      healthSharePermission ||
      config.modResults.NSHealthShareUsageDescription ||
      HEALTH_SHARE
    config.modResults.NSHealthUpdateUsageDescription =
      healthUpdatePermission ||
      config.modResults.NSHealthUpdateUsageDescription ||
      HEALTH_UPDATE
    isClinicalDataEnabled ?
      config.modResults.NSHealthClinicalHealthRecordsShareUsageDescription =
        healthClinicalDescription ||
        config.modResults.NSHealthClinicalHealthRecordsShareUsageDescription ||
        HEALTH_CLINIC_SHARE :
      null

    return config
  })

  // Add entitlements. These are automatically synced when using EAS build for production apps.
  config = withEntitlementsPlist(config, (config) => {
    config.modResults['com.apple.developer.healthkit'] = true
    if (
      !Array.isArray(config.modResults['com.apple.developer.healthkit.access'])
    ) {
      config.modResults['com.apple.developer.healthkit.access'] = []
    }

    if (isClinicalDataEnabled) {
      config.modResults['com.apple.developer.healthkit.access'].push(
        'health-records',
      )

      // Remove duplicates
      config.modResults['com.apple.developer.healthkit.access'] = [
        ...new Set(config.modResults['com.apple.developer.healthkit.access']),
      ]
    }

    if (enableBackgroundObservers) {
      // Required for HealthKit to wake the app for background delivery.
      config.modResults['com.apple.developer.healthkit.background-delivery'] = true
    }

    return config
  })

  if (enableBackgroundObservers) {
    config = withBackgroundObserversAppDelegate(config)
  }

  return config
}
module.exports = withHealthKit
