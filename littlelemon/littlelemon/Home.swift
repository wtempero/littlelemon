//
//  Home.swift
//  littlelemon
//
//  Created by William Tempero on 2/28/26.
//

import SwiftUI
import CoreData

struct Home: View {
    let persistence = PersistenceController.shared

    var body: some View {
        //TabView{
        VStack {
            Menu()
                //.tabItem {
                    //Label("Menu", systemImage: "list.dash")
                //}

            //UserProfile()
                //.tabItem {
                    //Label("Profile", systemImage: "square.and.pencil")
                //}
        }
        .navigationBarBackButtonHidden(true)
        //.navigationTitle("Home")
        .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}

#Preview {
    Home()
}
