//
//  Bourne.swift
//  JasonBourne
//
//  Created by 김동준 on 2022/09/23.
//

import Foundation

open class Bourne {
    private let session = URLSession.shared
    private let stubMode: ResponseSpeed
    
    public init() {
        stubMode = .notStub
    }
    
    public init(stubMode: ResponseSpeed) {
        self.stubMode = stubMode
    }
    
    public func request(api: APITarget, completion: @escaping ((Result<Data, BournError>) -> Void)) {
        switch stubMode {
        case .notStub:
            requestAPI(api: api, completion: completion)
        case .immediately:
            return completion(.success(api.mockData))
        case .normal:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                return completion(.success(api.mockData))
            }
        case .almostNever:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1000) {
                return completion(.success(api.mockData))
            }
        }
    }
    
    private func requestAPI(api: APITarget, completion: @escaping ((Result<Data, BournError>) -> Void)) {
        let serialQueue = DispatchQueue(label: "serialQueue")
        let handler: ((Data?, URLResponse?, Error?) -> Void) = { data, response, error in
            guard error == nil else {
                return completion(.failure(.networkError))
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse else {
                return completion(.failure(.httpResponse))
            }
            
            guard (200...299) ~= httpURLResponse.statusCode else {
                return completion(.failure(.responseCode))
            }
            
            guard let data = data else {
                return completion(.failure(.nilDataInSession))
            }
            
            serialQueue.async {
                completion(.success(data))
            }
        }
        
        switch api.method {
        case .get:
            guard let url = makeURL(from: api) else {
                return completion(.failure(.urlInvailed)) }
            session.dataTask(with: url, completionHandler: handler)
                .resume()
        case .post:
            guard let urlRequest = makeURLRequest(from: api) else {
                return completion(.failure(.urlInvailed)) }
            session.dataTask(with: urlRequest, completionHandler: handler)
                .resume()
        }
    }
    
    private func makeURL(from api: APITarget) -> URL? {
        var url = api.baseURL
        url.appendPathComponent(api.path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        switch api.task {
        case .requestParameters(let parameter):
            components.queryItems = parameter.map {
                URLQueryItem(name: $0, value: $1)
            }
        case .requestBody(_):
            break
        }
        return components.url
    }
    
    private func makeURLRequest(from api: APITarget) -> URLRequest? {
        var url = api.baseURL
        url.appendPathComponent(api.path)
        var urlRequest = URLRequest(url: url)
        switch api.task {
        case .requestBody(let data):
            urlRequest.httpBody = data
        case .requestParameters(_) :
            break
        }
        urlRequest.httpMethod = api.method.rawValue
        let _ = api.headers?.compactMap { $0 }
            .map { urlRequest.addValue($0.key, forHTTPHeaderField: $0.value) }
        return urlRequest
    }
}
