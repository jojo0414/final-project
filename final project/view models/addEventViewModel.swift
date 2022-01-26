//
//  addEventViewModel.swift
//  final project
//
//  Created by 陳昕喬🐷 on 2022/1/21.
//

import SwiftUI

struct AddEventViewModel: View {
    @EnvironmentObject var background: BackgroundPicture
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.eventDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Event>
    
    @State private var eventName = ""
    @State private var eventDate = Date()
    @State private var showSheet = false
    
    
    private func addItem(eventName: String, eventDate: Date) {
        withAnimation {
            let newItem = Event(context: viewContext)
            newItem.eventDate = eventDate
            newItem.eventName = eventName

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func getDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
    
    private func getTime(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(items){ item in
//                    NavigationLink {
                    HStack{
                        Text(getDate(date: item.eventDate!))
                        Text(item.eventName!)
                        Text(getTime(date: item.eventDate!))
                        
                    }
                }
                .onDelete(perform: deleteItems)
                .listRowBackground(background.backgroundColor)
            }
            .navigationBarTitle("新增活動")
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                    
                }
                ToolbarItem{
                    Button {
                        showSheet = true
                        eventName = ""
                        eventDate = Date()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $showSheet) {
                        Form{
                            TextField("輸入活動名稱", text: $eventName)
                                .padding()
                            DatePicker("時間", selection: $eventDate)
                                .padding()
                            Button("完成"){
                                addItem(eventName: eventName, eventDate: eventDate)
                                showSheet = false
                            }
                        }
                    }

                }
            }
        }
    }
}

struct AddEventViewModel_Previews: PreviewProvider {
    static var previews: some View {
        AddEventViewModel().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
