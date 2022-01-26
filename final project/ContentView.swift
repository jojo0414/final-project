import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 0
    @StateObject private var background = BackgroundPicture()
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(background.backgroundColor)
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onEnded({ value in
                print(value.translation.width)
                if(value.translation.width > 0){
                    if tabSelection == 0{
                        tabSelection = 0
                    }
                    else{
                        tabSelection = tabSelection - 1
                    }
                }
                if (value.translation.width < 0) {
                    if tabSelection == 3 {
                        tabSelection = 3
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
                }.tag(0)
            YoutubeView()
                .tabItem {
                    Label("Youtube", systemImage: "play.rectangle.fill")
                }.tag(1)
            WeatherView()
                .tabItem {
                    Label("天氣", systemImage:  "thermometer.sun.fill")
                }.tag(2)
            AddEventViewModel()
                .tabItem {
                    Label("行程", systemImage: "calendar")
                }.tag(3)
        }
        .environmentObject(background)
        .gesture(dragGesture)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BackgroundPicture())
    }
}
