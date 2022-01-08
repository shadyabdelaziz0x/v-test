//
//  UserDefaultsManager.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import Foundation
import SwiftyUserDefaults

enum LocalStorageKeys: String, CaseIterable {
    case mainSyncDone         = "mainSyncDone"
    case isCashFull           = "isCashFull"
}
    
extension DefaultsKeys {
    var mainSyncDone         : DefaultsKey<Bool> { .init(LocalStorageKeys.mainSyncDone.rawValue, defaultValue: false) }
    var isCashFull           : DefaultsKey<Bool> { .init(LocalStorageKeys.isCashFull.rawValue, defaultValue: false) }
}
