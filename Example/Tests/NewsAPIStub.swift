//
//  NewsAPIStub.swift
//  JasonBourne_Example
//
//  Created by 김동준 on 2022/09/23.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import JasonBourne

public enum NewsAPI {
    case topHeadlines
}
extension NewsAPI: APITarget {
    public var baseURL: URL {
        switch self {
        case .topHeadlines:
            return URL(string: "https://newsapi.org/v2")!
        }
    }
    
    public var path: String {
        switch self {
        case .topHeadlines:
            return "/top-headlines"
        }
    }
    
    public var method: APIMethod {
        switch self {
        case .topHeadlines:
            return .get
        }
    }
    
    public var task: Parameter {
        switch self {
        case .topHeadlines:
            let params: [String: String] = [
                "country": "kr",
                "apiKey": "b6e4d3cf120c4f55a73c51be3e570b3d"
            ]
            return .requestParameters(parameters: params)
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .topHeadlines:
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        }
    }
    
    public var mockData: Data {
        switch self {
        case .topHeadlines:
            return Data(
                            """
                            {\"status\":\"ok\",\"totalResults\":34,\"articles\":[{\"source\":{\"id\":null,\"name\":\"Hankyung.com\"},\"author\":null,\"title\":\"중국, 북한 핵무력 법제화에 \\\"한반도 문제 입장 변화없어\\\" - 한국경제\",\"description\":\"중국, 북한 핵무력 법제화에 \\\"한반도 문제 입장 변화없어\\\", 국제\",\"url\":\"https://www.hankyung.com/international/article/202209092536Y\",\"urlToImage\":\"https://img.hankyung.com/photo/202209/ZK.31176259.1.jpg\",\"publishedAt\":\"2022-09-09T08:11:55Z\",\"content\":\"\' \' .8() BBC . () (SAR) . 1954 , 2018 2020 . , BBC . 7000( 970) 22000( 3050) . , 2019 . , . (NGO) 2016 · , · . \\\"\"}]}
                            """.utf8
            )
        }
    }
}
