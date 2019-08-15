//
//  BluetoothDevice.swift
//  
//
//  Created by Jakub Tudruj on 22/07/2019.
//

import CoreBluetooth
import Foundation

public struct BluetoothDevice {
    
    public enum State {
        case connected
        case connecting
        case disconnected
        case disconnecting
    }
    
    public let id: UUID
    public let name: String?
    public let state: State
    
    public init(id: UUID = UUID(), name: String? = nil, state: State = .disconnected) {
        self.id = id
        self.name = name
        self.state = state
    }

}

extension BluetoothDevice {
    
    init(peripheral: CBPeripheral) {
        self.id = peripheral.identifier
        self.name = peripheral.name
        self.state = State(cbPeripheralState: peripheral.state)
    }
    
}

extension BluetoothDevice.State {
    
    init(cbPeripheralState: CBPeripheralState) {
        switch cbPeripheralState {
        case .disconnected:
            self = .disconnected
        case .connecting:
            self = .connecting
        case .connected:
            self = .connected
        case .disconnecting:
            self = .disconnecting
        @unknown default:
            fatalError("unknown CBPeripheralState: \(cbPeripheralState)")
        }
    }
    
}
