import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 0
    
    var dragGesture: some Gesture {
        DragGesture()
                .onChanged({ value in
                    print(value.translation.width)
                    if(value.translation.width < 0){
                        if tabSelection == 0{
                            tabSelection = 2
                        }
                        else{
                            tabSelection = tabSelection - 1
                        }
                    }
                    if (value.translation.width > 0) {
                        if tabSelection == 2 {
                            tabSelection = 0
                        }
                        else {
                            tabSelection = tabSelection + 1
                        }
                    }
                })
    }
    
    var body: some View {
        TabView(selection: $tabSelection){
            Home()
                .tabItem{
                    Label("主頁", systemImage: "house.fill")
                }
            YoutubeView()
                .tabItem {
                    Label("Youtube", systemImage: "play.rectangle.fill")
                }
            WeatherView()
                .tabItem {
                    Label("天氣", systemImage:  "thermometer.sun.fill")
                }
        }
        .gesture(dragGesture)
        
        
    }
}
