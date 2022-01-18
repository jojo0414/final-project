//
//  VideoItemViewModel.swift
//  final project
//
//  Created by 陳昕喬🐷 on 2022/1/11.
//

import SwiftUI


struct VideoItemView: View {
    let item: YoutubePlaylistData.Items
    
    var body: some View{
        HStack{
            AsyncImage(url: item.snippet.thumbnails.medium.url){ image in
                image
                    .resizable()
                    .scaledToFill()
            }placeholder: {
                Image("小恐龍")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 160, height: 90)
            
            VStack(alignment: .leading){
                Text(item.snippet.title)
                    .bold()
            }
        }
    }
}
