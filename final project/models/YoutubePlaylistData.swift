//
//  YoutubePlaylistData.swift
//  final project
//
//  Created by 陳昕喬🐷 on 2022/1/11.
//

import Foundation
import CoreImage
import SwiftUI

class YoutubePlaylistData: ObservableObject
{
    @Published var youtubePlaylistDataItem = [Items]()
    
    init(){
        getYoutubeContent(searchText: nil)
    }

    struct SearchResponse: Codable {
        let items: [Items]
    }
    
    struct Items: Codable, Identifiable {
        var id: String {contentDetails.videoId}
        let snippet: Snippet
        let contentDetails: ContentDetails
        
        struct Snippet: Codable{
            let publishedAt: Date
            let title: String
            let description: String
            let thumbnails: Thumbnails
            
            struct Thumbnails: Codable {
                let medium: Image
                
                struct Image: Codable{
                    let url: URL
                    
                }
            }
        }
        
        struct ContentDetails: Codable{
            let videoId: String
        }
        

    }

    func getYoutubeContent(searchText: String?)
    {
        let urlString =  "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UUapD-I9_3ujAA1mvk_uLmGA&key=AIzaSyA_6zy7q4JIF770Ph3biswgwtCS7Ghzwbc&maxResults=50"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do {
                        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                        DispatchQueue.main.async {
                            if let searchText = searchText{
                                self.youtubePlaylistDataItem = searchResponse.items.filter({
                                    $0.snippet.title.contains(searchText)
                                })
                            }
                            else{
                                self.youtubePlaylistDataItem = searchResponse.items
                            }
                        }
                        print("載入成功")
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}

