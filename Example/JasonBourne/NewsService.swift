//
//  NewsService.swift
//  JasonBourne_Example
//
//  Created by 김동준 on 2022/09/23.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import JasonBourne

final class NewsService {
    private var bourne: Bourne!
    
    func fetchNews() {
        bourne = Bourne()
        bourne.request(api: NewsAPI.topHeadlines) { result in
            switch result {
            case .success(let responseData):
                print(String(data: responseData, encoding: .utf8))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchFakeNews() {
        bourne = Bourne(stubMode: .immediately)
        bourne.request(api: NewsAPI.topHeadlines) { result in
            switch result {
            case .success(let responseData):
                print(String(data: responseData, encoding: .utf8))
            case .failure(let error):
                print(error)
            }
        }
    }
}
