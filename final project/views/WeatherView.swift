import SwiftUI

struct WeatherView: View {
    
    @StateObject var weatherLocationItem = WeatherData()
    @State private var showAlert = false
    @State private var error: Error?
    
    var body: some View{
        List{
            ForEach(weatherLocationItem.weatherLocationItems, id: \.locationName){item in
                DisclosureGroup{
                    WeatherItemView(weather: item)
                } label: {
                    Text(item.locationName)
                }
            }
        }
        .task {
            do{
                try await weatherLocationItem.getWeatherData(searchText: nil)
            } catch {
                showAlert = true
            }
        }
        .alert("獲取天氣失敗", isPresented: $showAlert, actions: {
            Button("OK") {self.error = nil}
        })
        .overlay{
            if weatherLocationItem.weatherLocationItems.isEmpty {
                ProgressView()
            }
        }
        .refreshable{
            do{
                try await weatherLocationItem.getWeatherData(searchText: nil)
            } catch {
                showAlert = true
            }
        }
    }
    
}

struct WeatherViewPreview: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}


