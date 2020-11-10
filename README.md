# Slow Network Detector

[![Maintainability](https://api.codeclimate.com/v1/badges/027b21e2c814370917dc/maintainability)](https://codeclimate.com/github/winston0410/slow-network-checker/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/027b21e2c814370917dc/test_coverage)](https://codeclimate.com/github/winston0410/slow-network-checker/test_coverage) [![Known Vulnerabilities](https://snyk.io/test/github/winston0410/slow-network-checker/badge.svg?targetFile=package.json)](https://snyk.io/test/github/winston0410/slow-network-checker?targetFile=package.json) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/41dc6aaa27f54a54b0b14a3114a09ce0)](https://www.codacy.com/gh/winston0410/slow-network-checker/dashboard?utm_source=github.com&utm_medium=referral&utm_content=winston0410/slow-network-checker&utm_campaign=Badge_Grade)

A simple package that uses [NetworkInformation API](https://developer.mozilla.org/en-US/docs/Web/API/NetworkInformation) to check if the user's network is slow.

## Usage

```javascript
import {
  isSlowNetwork
} from '@blackblock/slow-network-checker'

const slowNetworkDefinition = {
  effectiveType: '2g',
  downlink: 1,
  saveData: true,
  rtt: 10
}

const networkInformation = navigator.connection || navigator.mozConnection || navigator.webkitConnection

const result = isSlowNetwork(slowNetworkDefinition)(networkInformation) //Return Boolean
```

## Installation

```
npm i @blackblock/slow-network-checker
```

## API Reference

### Type Definition

#### Definition

An object that lists the definition of a slow network based on different metrics.

```purescript
type Definition = { effectiveType :: String,
saveData :: Boolean,
downlink :: Int,
rtt :: Int}
```

#### NetworkPerformance

An object that records the performance of a network in different metrics. The [NetworkInformation](https://developer.mozilla.org/en-US/docs/Web/API/NetworkInformation) object should be passed in here.

You should also pass in the online status from [Navigator.onLine](https://developer.mozilla.org/en-US/docs/Web/API/NavigatorOnLine/onLine) in the performance object as **`online`**, so that the status of offline and slow network can be differentiated.

```purescript
type NetworkPerformance = {
online :: Boolean,
effectiveType :: String,
saveData :: Boolean,
downlink :: Int,
rtt :: Int}
```

### Function

#### `isSlowNetwork`

Main function of this package. Test if the `NetworkInformation` object met the definition of a slow network.

If the actual network performance is slower or equal to your definition defined as `Definition`, it will be regarded as a slow network and return `true`, `false` otherwise.

If the user is offline, `isSlowNetwork` will always return `false`, so that the status of offline and slow network can be differentiated.

**`isSlowNetwork :: Definition -> NetworkPerformance -> Boolean`**
