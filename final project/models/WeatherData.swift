import SwiftUI

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
