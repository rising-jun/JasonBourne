


enum CustumAPI {
    case topHeadlines
}
extension CustumAPI: APITarget {
    var baseURL: URL {
        switch self {
        case .topHeadlines:
            return URL(string: "https://newsapi.org/v2")!
        }
    }
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "/top-headlines"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .topHeadlines:
            return .get
        }
    }
    
    var task: Parameter {
        switch self {
        case .topHeadlines:
            let params: [String: String] = [
                "country": "kr",
                "apiKey": "b6e4d3cf120c4f55a73c51be3e570b3d"
            ]
            return .requestParameters(parameters: params)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .topHeadlines:
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        }
    }
    
    var mockData: Data {
        return Data()
    }
}
