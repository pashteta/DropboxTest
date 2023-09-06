//
//  BaseEmptyModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import Foundation

/// Needs to be struct othervise will not function correctly
/// with BaseViewModel
public protocol BaseEmptyModel {
    static func createEmpty() -> Self
}


