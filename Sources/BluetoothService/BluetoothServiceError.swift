//
//  BluetoothServiceError.swift
//  
//
//  Created by Jakub Tudruj on 22/07/2019.
//

import Foundation

public enum BluetoothServiceError: LocalizedError {
    case unknown
    case bluetoothIsDisabled
    case serviceIsResetting
    case deviceIsUnreachable
}
