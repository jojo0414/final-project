import SwiftUI

struct WeatherItemView: View {
    let weather: WeatherData.Locations
    
    var body: some View{
        ScrollView(.horizontal){
            HStack{
                ForEach(weather.weatherElement[0].time.indices){ index in
                    VStack{
                        Text(weather.weatherElement[0].time[index].startTime)
                        Text("—")
                        Text(weather.weatherElement[0].time[index].endTime)
                        Text("天氣狀況：") + Text(weather.weatherElement[0].time[index].parameter.parameterName)
                        Text("降雨機率：") + Text(weather.weatherElement[1].time[index].parameter.parameterName) + Text(" %")
                        Text("溫度：") + Text(weather.weatherElement[2].time[index].parameter.parameterName) + Text(" ~ ") + Text(weather.weatherElement[4].time[index].parameter.parameterName) + Text(" °C")
                        Text("舒適度：") + Text(weather.weatherElement[3].time[index].parameter.parameterName)
                    }
                }
            }
            
        }
        
    }
    
}
