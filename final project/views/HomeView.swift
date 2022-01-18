//
//  HomeView.swift
//  final project
//
//  Created by 陳昕喬🐷 on 2022/1/11.
//

import SwiftUI

struct Home: View {
    @State private var showHoYoLab = false
    @State private var showFB = false
    @State private var showIG = false
    @State private var tabSelection = 0
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    TabView(selection: $tabSelection){
                        ForEach(PVs){item in
                            NavigationLink{
                                WebView(urlString: "https://www.youtube.com/watch?v=" + item.videoId)
                            } label: {
                                Image(item.name)
                                    .resizable()
                                    .scaledToFit()
                            }
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
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

