//
//  BluetoothService.swift
//  BlueToo
//
//  Created by Jakub Tudruj on 21/07/2019.
//  Copyright © 2019 Jakub Tudruj. All rights reserved.
//

import CoreBluetooth
import Foundation

open class BluetoothService {
    
    public weak var delegate: BluetoothServiceDelegate?
    
    private lazy var centralManagerDelegate = BluetoothServiceCBCentralManagerDelegate(bluetoothService: self)
    
    private lazy var centralManager = CBCentralManager(delegate: centralManagerDelegate, queue: DispatchQueue.main)
    
    public init() {}
    
    public func scanForDevices() {
        let state = BluetoothState(state: centralManager.state)
        switch state {
        case .enabled:
            let options = [CBCentralManagerScanOptionAllowDuplicatesKey : NSNumber(booleanLiteral: false)]
            centralManager.scanForPeripherals(withServices: nil, options: options)
            break
        case .disabled:
            delegate?.bluetoothService(self, didFailScanForDevicesWithError: .bluetoothIsDisabled)
        case .resetting:
            delegate?.bluetoothService(self, didFailScanForDevicesWithError: .serviceIsResetting)
        }
    }
    
}

private class BluetoothServiceCBCentralManagerDelegate: NSObject, CBCentralManagerDelegate {
    
    weak var bluetoothService: BluetoothService?
    
    init(bluetoothService: BluetoothService) {
        self.bluetoothService = bluetoothService
        super.init()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard let service = bluetoothService else { return }
        let state = BluetoothState(state: central.state)
        bluetoothService?.delegate?.bluetoothService(service, didUpdateBluetoothState: state)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        guard let service = bluetoothService else { return }
        let device = BluetoothDevice(peripheral: peripheral)
        bluetoothService?.delegate?.bluetoothService(service, didDiscover: device)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        guard let service = bluetoothService else { return }
        let device = BluetoothDevice(peripheral: peripheral)
        bluetoothService?.delegate?.bluetoothService(service, didFailConnectTo: device, withError: BluetoothServiceError.unknown)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        guard let service = bluetoothService else { return }
        let device = BluetoothDevice(peripheral: peripheral)
        bluetoothService?.delegate?.bluetoothService(service, didConnectTo: device)
    }
}
//
//extension BluetoothService: CBCentralManagerDelegate {
//
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        let state = BluetoothState(state: central.state)
//        delegate?.bluetoothService(self, didUpdateBluetoothState: state)
//    }
//
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
//        let device = BluetoothDevice(peripheral: peripheral)
//        delegate?.bluetoothService(self, didDiscover: device)
//    }
//
//    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
//        let device = BluetoothDevice(peripheral: peripheral)
//        delegate?.bluetoothService(self, didFailConnectTo: device, withError: BluetoothServiceError.unknown)
//    }
//
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        let device = BluetoothDevice(peripheral: peripheral)
//        delegate?.bluetoothService(self, didConnectTo: device)
//    }
//
//}
