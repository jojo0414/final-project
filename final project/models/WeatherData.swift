import SwiftUI

let weatherPicthre = ["晴天": "sun.max", "晴時多雲": "cloud.sun", "多雲時晴": "cloud.sun", "多雲": "cloud.sun", "多雲時陰": "smoke", "陰時多雲": "smoke", "陰天": "cloud", "多雲陣雨": "cloud.drizzle", "  多雲短暫雨":"cloud.drizzle", "多雲短暫陣雨": "cloud.drizzle", "午後短暫陣雨": "cloud.drizzle", "短暫陣雨": "cloud.drizzle", "多雲時晴短暫陣雨": "cloud.drizzle", "多雲時晴短暫雨": "cloud.drizzle", "晴時多雲短暫陣雨": "cloud.drizzle", "晴短暫陣雨": "cloud.drizzle", "短暫雨": "cloud.drizzle", "多雲時陰短暫雨": "cloud.drizzle", "多雲時陰短暫陣雨": "cloud.drizzle", "陰時多雲短暫雨": "cloud.drizzle", "雨天": "cloud.drizzle", "晴午後短暫雨": "cloud.drizzle", "晴午後短暫陣雨": "cloud.drizzle", "陰短暫雨": "cloud.drizzle", "陰短暫陣雨": "cloud.drizzle", "陰午後短暫陣雨": "cloud.drizzle", "多雲時陰有雨": "cloud.rain", "多雲時陰陣雨": "cloud.rain", "晴時多雲陣雨": "cloud.rain", "多雲時晴陣雨": "cloud.rain", "陰時多雲有雨": "cloud.rain", "陰時多雲有陣雨": "cloud.rain", "陰時多雲陣雨": "cloud.rain", "陰有雨": "cloud.rain", "陰有陣雨": "cloud.rain", "陰雨": "cloud.rain", "陰陣雨": "cloud.rain", "陣雨": "cloud.rain", "午後陣雨": "cloud.rain", "有雨": "cloud.rain"]

@MainActor
class WeatherData: ObservableObject{
    
    @Published var weatherLocationItems = [Locations]()
    
    struct WeatherResponse: Codable{
        let records: Records
        
        struct Records: Codable{
            let location: [Locations]
        }
    }
    
    struct Locations: Codable{
        let locationName: String
        let weatherElement: [WeatherElement]
        
        struct WeatherElement: Codable{
            let elementName: String
            let time: [Time]
            
            struct Time: Codable{
                let startTime: String
                let endTime: String
                let parameter: Parameter
                
                struct Parameter: Codable{
                    let parameterName: String
                    let parameterUnit: String?
                }
            }
        }
    }
    
    enum FetchError: Error {
        case invalidURL
        case badRequest
    }
    
    func getWeatherData(searchText: String?) async throws{
        let urlString = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-B75CED6D-83D6-4979-B24F-26BAB535EB85&format=JSON"
        
        guard let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else {
                  throw FetchError.invalidURL
              }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard(response as? HTTPURLResponse)?.statusCode == 200 else{ throw FetchError.badRequest}
        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        self.weatherLocationItems = weatherResponse.records.location
    }
}
