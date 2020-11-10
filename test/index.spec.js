import {
  isSlowNetwork
} from '../src/index.js'
const chai = require('chai')
const expect = chai.expect

describe('isSlowNetwork', function () {
  describe('if saveData matched', function () {
    it('should return true', function () {
      const networkDefinition = {
        effectiveType: '2g',
        downlink: 1,
        saveData: true,
        rtt: 10
      }

      const mockNetworkCondition = {
        effectiveType: '4g',
        downlink: 10,
        saveData: true,
        rtt: 0,
        online: true
      }

      const result = isSlowNetwork(networkDefinition)(mockNetworkCondition)

      expect(result).to.eql(true)
    })
  })

  describe('if the downlink of network is less than definition', function () {
    it('should return true', function () {
      const networkDefinition = {
        effectiveType: '2g',
        downlink: 10,
        saveData: true,
        rtt: 10
      }

      const mockNetworkCondition = {
        effectiveType: '4g',
        downlink: 5,
        saveData: false,
        rtt: 20,
        online: true
      }

      const result = isSlowNetwork(networkDefinition)(mockNetworkCondition)

      expect(result).to.eql(true)
    })
  })

  describe('if the effectiveType of network is slower than definition', function () {
    it('should return true', function () {
      const networkDefinition = {
        effectiveType: '3g',
        downlink: 10,
        saveData: true,
        rtt: 10
      }

      const mockNetworkCondition = {
        effectiveType: '2g',
        downlink: 20,
        saveData: false,
        rtt: 20,
        online: true
      }

      const result = isSlowNetwork(networkDefinition)(mockNetworkCondition)

      expect(result).to.eql(true)
    })
  })
})
