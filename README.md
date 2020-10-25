# Slow Network Detector

A simple package that uses [NetworkInformation API](https://developer.mozilla.org/en-US/docs/Web/API/NetworkInformation) to check if the user's network is slow.

## Installation

```
npm i @blackblock/slow-network-checker
```

## API Reference

### Type Definition

#### Definition

An object that lists the definition of a slow network in different metrics.

```
type Definition = { effectiveType :: String,
saveData :: Boolean,
downlink :: Int,
rtt :: Int}
```

#### NetworkPerformance

An object that records the performance of a network in different metrics. The [NetworkInformation](https://developer.mozilla.org/en-US/docs/Web/API/NetworkInformation) object should be passed in here.

```
type NetworkPerformance = { effectiveType :: String,
saveData :: Boolean,
downlink :: Int,
rtt :: Int}
```

### Function

#### `isSlowNetwork`

Main function of this package. Test if the `NetworkInformation` object met the definition of a slow network.

**`isSlowNetwork :: Definition -> NetworkPerformance -> Boolean`**
