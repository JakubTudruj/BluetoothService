//
//  BluetoothServiceDelegate.swift
//  
//
//  Created by Jakub Tudruj on 22/07/2019.
//

import Foundation

public protocol BluetoothServiceDelegate: class {
    func bluetoothService(_ service: BluetoothService, didFailScanForDevicesWithError error: BluetoothServiceError)
    func bluetoothService(_ service: BluetoothService, didUpdateBluetoothState state: BluetoothState)
    func bluetoothService(_ service: BluetoothService, didDiscover device: BluetoothDevice)
    func bluetoothService(_ service: BluetoothService, didConnectTo device: BluetoothDevice)
    func bluetoothService(_ service: BluetoothService, didFailConnectTo device: BluetoothDevice, withError error: BluetoothServiceError)
}
