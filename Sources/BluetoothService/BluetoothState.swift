//
//  BluetoothState.swift
//  
//
//  Created by Jakub Tudruj on 22/07/2019.
//

import CoreBluetooth

public enum BluetoothState {
    case enabled
    case disabled
    case resetting
}

extension BluetoothState {
    init(state: CBManagerState) {
        switch state {
        case .unknown, .unsupported, .unauthorized, .poweredOff:
            self = .disabled
        case .resetting:
            self = .resetting
        case .poweredOn:
            self = .enabled
        @unknown default:
            print("unknown CBManagerState: \(state)")
            self = .disabled
        }
    }
}
