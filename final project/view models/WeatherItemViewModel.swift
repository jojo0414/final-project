import SwiftUI
import StepperView

struct WeatherItemView: View {
    let weather: WeatherData.Locations
    
    var body: some View{
        let titles = [TextView(text: weather.weatherElement[0].time[0].startTime + " ~ " + weather.weatherElement[0].time[0].endTime),
                    TextView(text: weather.weatherElement[0].time[1].startTime + " ~ " + weather.weatherElement[0].time[1].endTime),
                      TextView(text: weather.weatherElement[0].time[2].startTime + " ~ " + weather.weatherElement[0].time[2].endTime)]
        
        let indicators = [
            StepperIndicationType.custom(CircledIconView(image: Image(systemName:weatherPicthre[weather.weatherElement[0].time[0].parameter.parameterName] ?? "xmark.octagon"), width: 40, color: .white).font(.largeTitle).eraseToAnyView()),
            StepperIndicationType.custom(CircledIconView(image: Image(systemName:weatherPicthre[weather.weatherElement[0].time[1].parameter.parameterName] ?? "xmark.octagon"), width: 40, color: .white).font(.largeTitle).eraseToAnyView()),
            StepperIndicationType.custom(CircledIconView(image: Image(systemName:weatherPicthre[weather.weatherElement[0].time[2].parameter.parameterName] ?? "xmark.octagon"), width: 40, color: .white).font(.largeTitle).eraseToAnyView())
        ]
        
        let pitstops = [
            TextView(text: "天氣狀況： " + weather.weatherElement[0].time[0].parameter.parameterName + "\n降雨機率： " + weather.weatherElement[1].time[0].parameter.parameterName + "%\n溫度： " + weather.weatherElement[2].time[0].parameter.parameterName + " ~ "  + weather.weatherElement[4].time[0].parameter.parameterName + " °C\n舒適度： " + weather.weatherElement[3].time[0].parameter.parameterName).eraseToAnyView(),
            TextView(text: "天氣狀況： " + weather.weatherElement[0].time[1].parameter.parameterName + "\n降雨機率： " + weather.weatherElement[1].time[1].parameter.parameterName + "%\n溫度： " + weather.weatherElement[2].time[1].parameter.parameterName + " ~ "  + weather.weatherElement[4].time[1].parameter.parameterName + " °C\n舒適度： " + weather.weatherElement[3].time[1].parameter.parameterName).eraseToAnyView(),
            TextView(text: "天氣狀況： " + weather.weatherElement[0].time[2].parameter.parameterName + "\n降雨機率： " + weather.weatherElement[1].time[2].parameter.parameterName + "%\n溫度： " + weather.weatherElement[2].time[2].parameter.parameterName + " ~ "  + weather.weatherElement[4].time[2].parameter.parameterName + " °C\n舒適度： " + weather.weatherElement[3].time[2].parameter.parameterName).eraseToAnyView()]
        VStack{
            StepperView()
                    .addSteps(titles)
                    .indicators(indicators)
                    .addPitStops(pitstops)
                    .spacing(100)
                    .padding()
            Spacer()
        }
    }
    
}
