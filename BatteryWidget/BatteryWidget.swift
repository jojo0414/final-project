//
//  BatteryWidget.swift
//  BatteryWidget
//
//  Created by 陳昕喬🐷 on 2022/1/26.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    var batteryLevel: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryData = Int(UIDevice.current.batteryLevel * 100)
        return batteryData
    }
    
    func battery() -> Int{
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batterylevel = Int(UIDevice.current.batteryLevel * 100)
        return batterylevel
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), currentBattery: battery())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), currentBattery: battery())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, currentBattery: battery())
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .after(currentDate.addingTimeInterval(60)))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let currentBattery: Int
}

struct BatteryWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct BatteryWidget: Widget {
    let kind: String = "BatteryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BatteryView(entry: entry)
        }
        .configurationDisplayName("電池")
        .description("查看電池電量")
    }
}

struct BatteryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        let currentBattery = entry.currentBattery
        if currentBattery < 25{
            ZStack {
                HStack{
                    Image(systemName: "battery.0")
                    Text("\(currentBattery) %")
                    Spacer()
                }
                .offset(x: 10, y: -40)
                Image("0")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding()
                    .offset(x: 10, y: 20)
            }
        }else if (currentBattery >= 25 && currentBattery < 75) {
            ZStack {
                HStack{
                    Image(systemName: "battery.25")
                    Text("\(currentBattery) %")
                    Spacer()
                }
                .offset(x: 10, y: -40)
                Image("75%")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding()
                    .offset(x: 10, y: 20)
            }
        }else{
            ZStack {
                HStack{
                    Image(systemName: "battery.100")
                    Text("\(currentBattery) %")
                    Spacer()
                }
                .offset(x: 10, y: -40)
                Image("100")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding()
                    .offset(x: 10, y: 20)
            }
        }
    }
}

struct BatteryWidget_Previews: PreviewProvider {
    static var previews: some View {
        BatteryWidgetEntryView(entry: SimpleEntry(date: Date(), currentBattery: 100))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
