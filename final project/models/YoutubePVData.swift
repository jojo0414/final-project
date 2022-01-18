//
//  YoutubePVData.swift
//  final project
//
//  Created by 陳昕喬🐷 on 2022/1/11.
//

import Foundation

struct PV: Identifiable{
    let id = UUID()
    let videoId: String
    let name: String
}

let PVs = [PV(videoId: "l8CjqG5Rkgs", name: "1.0"),
           PV(videoId: "Ac0Fk2IB1To", name: "1.1"),
           PV(videoId: "z5ztw7yIoOI", name: "1.2"),
           PV(videoId: "rEeh-b_GJzQ", name: "1.3"),
           PV(videoId: "ybpCvOsJZZw", name: "1.4"),
           PV(videoId: "87GHgNN0Ju8", name: "1.5"),
           PV(videoId: "kDBmYK3ef6w", name: "1.6"),
           PV(videoId: "xlR3LEVg_V8", name: "2.0"),
           PV(videoId: "Un4ffkOn3tI", name: "2.1"),
           PV(videoId: "m3CmH6rV-jw", name: "2.2"),
           PV(videoId: "trceEtPgZVY", name: "2.3"),
           PV(videoId: "BlKa_l_Wtsk", name: "2.4") ]
