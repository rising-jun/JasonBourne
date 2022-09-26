//
//  BournError.swift
//  JasonBourne
//
//  Created by 김동준 on 2022/09/23.
//

import Foundation

public enum BournError: Error {
    case networkError
    case httpResponse
    case responseCode
    case nilDataInSession
    case urlInvailed
}
