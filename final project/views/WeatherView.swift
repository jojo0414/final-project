import SwiftUI
import WidgetKit

struct WeatherView: View {
    @EnvironmentObject var background: BackgroundPicture
    
    @StateObject var weatherLocationItem = WeatherData()
    @State private var showAlert = false
    //    @State private var error: Error?
    
    var body: some View{
        NavigationView {
            List{
                ForEach(weatherLocationItem.weatherLocationItems, id: \.locationName){item in
                    NavigationLink {
                        WeatherItemView(weather: item)
                    } label: {
                        Text(item.locationName)
                    }
                    .listRowBackground(background.backgroundColor)
                }
                .navigationTitle("天氣預報")
            }
            .task {
                do{
                    try await
                    weatherLocationItem.getWeatherData(searchText: nil)
                } catch {
                    showAlert = true
                }
            }
            .alert("獲取天氣失敗", isPresented: $showAlert, actions: {
                Button("OK") {}
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
    
}

struct WeatherViewPreview: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}


