# JasonBourne

[![CI Status](https://img.shields.io/travis/rising-jun/JasonBourne.svg?style=flat)](https://travis-ci.org/rising-jun/JasonBourne)
[![Version](https://img.shields.io/cocoapods/v/JasonBourne.svg?style=flat)](https://cocoapods.org/pods/JasonBourne)
[![License](https://img.shields.io/cocoapods/l/JasonBourne.svg?style=flat)](https://cocoapods.org/pods/JasonBourne)
[![Platform](https://img.shields.io/cocoapods/p/JasonBourne.svg?style=flat)](https://cocoapods.org/pods/JasonBourne)

## Intro
<img width="650" alt="스크린샷 2022-09-23 오후 7 46 38" src="https://user-images.githubusercontent.com/62687919/191944772-aae07b70-d377-4ab8-b2e8-1cf1b2196df3.png">

### This is JsonBourne

## it is Network Library, What i usually use networking features.
### First. Support StubMode with MockData
>
> it can be more testable.
> 
> So, i implemented Test with mock features.
>
### Second. comfortable to use more than URLSession
> 
> it using all network feature to use URLSession.
>
> it support APITarget, so you can use attach parameter, Header easily more than URLSession
>
### Third, ThreadSafety! Reponse Closure must excute in SerialQueue!
>
> Like Alamofire.
>
#### Actually it hasn't any relationship with Json Bourne

### How to use?
- in Service class
```swift
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
```
- If you want to StubMode, `Bourne(stubMode: .immediately)`

in TargetAPI
```swift
import JasonBourne

public enum NewsAPI {
    case topHeadlines
}
extension NewsAPI: APITarget {
    public var baseURL: URL {
        switch self {
        case .topHeadlines:
            return URL(string: "BaseURL")!
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
                "apiKey": "private"
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
            return Data()
        }
    }
}
```
- the way is simillar way with Moya.

its done! Thank you.

## Planning Feature Update
1. DownLoadTask - for DiskCaching
2. async, await

i'm planing!

## Requirements

## Installation

JasonBourne is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JasonBourne'
```

## Author

rising-jun, jun36817@naver.com

## License

JasonBourne is available under the MIT license. See the LICENSE file for more info.
