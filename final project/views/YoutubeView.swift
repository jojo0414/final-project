//
//  YoutubeView.swift
//  final project
//
//  Created by 陳昕喬🐷 on 2022/1/11.
//

import SwiftUI

struct YoutubeView: View{
    @StateObject var youtubePlaylistData = YoutubePlaylistData()
    @State private var searchText = ""
    
    var body: some View{
        NavigationView {
            List{
                ForEach(youtubePlaylistData.youtubePlaylistDataItem){item in
                    DisclosureGroup{
                        NavigationLink{
                            WebView(urlString: "https://www.youtube.com/watch?v=" + item.contentDetails.videoId)
                        } label: {
                            Text(item.snippet.description)
                        }
                    } label: {
                        VideoItemView(item: item)
                    }
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                if searchText == ""{
                    youtubePlaylistData.getYoutubeContent(searchText: nil)
                }
                else{
                    youtubePlaylistData.getYoutubeContent(searchText: searchText)
                }
            }
            .overlay {
                if youtubePlaylistData.youtubePlaylistDataItem.isEmpty {
                    ProgressView()
                }
            }
            .refreshable {
                youtubePlaylistData.getYoutubeContent(searchText: nil)
            }
            .navigationTitle("官方Youtube頻道")
        }
    }
}

struct YoutubeView_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeView()
    }
}
