//
//  HomeView.swift
//  final project
//
//  Created by 陳昕喬🐷 on 2022/1/11.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 2.0)){timeline in
            TabItemView(date: timeline.date)
        }
    }
}

struct TabItemView: View {
    
    @State private var showHoYoLab = false
    @State private var showFB = false
    @State private var showIG = false
    @State private var tabSelection = 0
    let date: Date
    
    func addTab(){
        if tabSelection == PVs.count - 1 {
            tabSelection = 0
        }
        else{
            tabSelection += 1
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    TabView(selection: $tabSelection){
                        ForEach(PVs.indices){index in
                            NavigationLink{
                                WebView(urlString: "https://www.youtube.com/watch?v=" + PVs[index].videoId)
                            } label: {
                                Image(PVs[index].name)
                                    .resizable()
                                    .scaledToFit()
                            }.tag(index)
                        }
                    }
                    .tabViewStyle(.page)
                    .animation(.spring(), value: tabSelection)
                    .frame(height: 200)
                    .navigationTitle("首頁")
                    
                    ZStack{
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180)
                        
                        Text("前往未知的冒險旅程")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .offset(x: 0, y: 65)
                    }
                    .padding()
                    
                    Spacer(minLength: 30)
                    
                    GameInfo()
                    
                    HStack{
                        Button {
                            showHoYoLab = true
                        } label: {
                            Image("HoYoLabLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                        .sheet(isPresented: $showHoYoLab) {
                            SafariView(url: URL(string: "https://www.hoyolab.com/home")!)
                        }
                        
                        Button {
                            showFB = true
                        } label: {
                            Image("FBLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45)
                        }
                        .sheet(isPresented: $showFB) {
                            SafariView(url: URL(string: "https://www.facebook.com/Genshinimpact.tw/")!)
                        }
                        
                        Button {
                            showIG = true
                        } label: {
                            Image("IGLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                        .sheet(isPresented: $showIG) {
                            SafariView(url: URL(string: "https://www.instagram.com/genshinimpact/")!)
                        }
                    }
                    Spacer(minLength: 30)
                }
            }
        }
        .onChange(of: date) { _ in
            addTab()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

