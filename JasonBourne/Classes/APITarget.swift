//
//  APITarget.swift
//  JasonBourne
//
//  Created by 김동준 on 2022/09/23.
//

import Foundation

public protocol APITarget {
    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: APIMethod { get }

    /// The type of HTTP task to be performed.
    var task: Parameter { get }

    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    
    /// The MockData response when Bourne is StubMode
    var mockData: Data { get }
}

public enum APIMethod: String {
    case get = "GET"
    case post = "POST"
}

public enum Parameter {
    case requestParameters(parameters: [String: String])
    case requestBody(data: Data)
}

public enum ResponseSpeed {
    case notStub
    case immediately
    case normal
    case almostNever
}
