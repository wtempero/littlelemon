//
//  Menu.swift
//  littlelemon
//
//  Created by William Tempero on 2/28/26.
//

import SwiftUI
import CoreData
import Foundation

struct Menu: View {
 
    @Environment(\.managedObjectContext) private var viewContext
 
    @State private var userAvatar: Image? = nil
    @State private var isLoading = false
    @State private var isFirstAppearance = true
    @State private var errorMessage: String? = nil
    @State private var searchText: String = ""
    @State private var selectedCategory: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0)
        {
            VStack(alignment: .leading, spacing: 0)
            {
                Text("Little Lemon")
                    .font(.system(size: 48, weight: .bold, design: .serif))
                    .foregroundColor(.littleLemonYellow)
                    //.background(Color.pink.opacity(0.3))

                HStack
                {
                    VStack(alignment: .leading, spacing: 0)
                    {
                        Text("Chicago")
                            .font(.system(size: 28, weight: .semibold, design: .serif))
                            .foregroundColor(.white)
                            //.background(Color.pink.opacity(0.3))

                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.white)
                            .lineSpacing(2)
                            .padding(.top, 16)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    //.background(Color.blue.opacity(0.2)) //for debug
                    .padding(.trailing, 8)
                    .frame(maxWidth: .infinity)

                    Image(.hero)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1.0, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                } //location, description, hero image hstack

                TextField("Search menu...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            } // static/green title area vstack
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .background(Color.littleLemonGreen)

            Text("ORDER FOR DELIVERY!")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding(.leading, 8)
                .padding(.top, 12)
                .padding(.bottom, 8)
                //.background(Color.pink.opacity(0.3))

            // Category buttons area
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        Button() {
                            selectedCategory = nil
                            searchText = ""
                        } label: {
                            Text("All")
                            .font(.headline)
                            .foregroundColor(.black)
                        }
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                
                        Button() {
                            selectedCategory = "starters"
                        } label: {
                            Text("Starters")
                            .font(.headline)
                            .foregroundColor(.black)
                        }
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                
                        Button() {
                            selectedCategory = "mains"
                        } label: {
                            Text("Mains")
                            .font(.headline)
                            .foregroundColor(.black)
                        }
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                
                        Button() {
                            selectedCategory = "desserts"
                        } label: {
                            Text("Desserts")
                            .font(.headline)
                            .foregroundColor(.black)
                        }
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                
                        Button() {
                            selectedCategory = "drinks"
                        } label: {
                            Text("Drinks")
                            .font(.headline)
                            .foregroundColor(.black)
                        }
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                
                        // allows demonstrating persistent store thru app closure/re-launch
                        // always populate with local copy unless it's empty or button pressed
                        Button {
                            Task {
                                selectedCategory = nil
                                searchText = ""
                                do {
                                    try await PersistenceController.shared.clearAsync()
                                    let fetchRequest: NSFetchRequest<Dish> =        Dish.fetchRequest()
                                    if (try? viewContext.count(for: fetchRequest)) == 0 {
                                        print("Button: clear complete, sending net request")
                                        await getMenuDataAsync()
                                    } else {
                                        print("Already have data, skipping fetch")
                                    }
                                } catch {
                                    await MainActor.run {
                                        errorMessage = "Clear failed:       \(error.localizedDescription)"
                                    }
                                    isLoading = false
                                }
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "icloud.and.arrow.down")
                                    .font(.title3)
                                Text("Menu")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 2)
                        }
                    } // hstack for category buttons
                    .padding(.horizontal)
                } // scrollview for category buttons
            } // vstack for category buttons
            .padding(.bottom, 8)

            // Menu content area
            NavigationStack // for expansion to detailed dish cards
            {
                Group
                {
                    if isLoading
                    {
                        ProgressView("Loading menu…")
                            .padding()
                    } else if let errorMessage
                    {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else
                    {
                        FilteredDishesView(searchText: searchText, selectedCategory: selectedCategory)
                            .listStyle(.plain)
                            .animation(.default, value: searchText)
                    }
                } // menu item group
                .frame(maxHeight: .infinity)  // let this grow
            } // navigation menu item stack
            //.background(Color.pink.opacity(0.3))
        } // whole screen vstack
        .onAppear {
            Task {
                if isFirstAppearance {
                    isFirstAppearance = false
                    let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
                    if (try? viewContext.count(for: fetchRequest)) == 0 {
                        print("First appearance, auto-fetching menu")
                        await getMenuDataAsync()
                    } else {
                        //print("Already have data, skipping fetch")
                    }
                }
            }
        }
        .safeAreaInset(edge: .top)
        {
            HStack
            {
                Spacer()

                Image(.logo)
                    .resizable()
                    .frame(maxWidth: 200, maxHeight: 50)
                    .aspectRatio(1.0, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Image(.avatar)
                    .resizable()
                    .frame(maxWidth: 50, maxHeight: 50)
                    .aspectRatio(1.0, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(.white)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    } // view

    struct FilteredDishesView: View {
        let searchText: String
        let selectedCategory: String?   // nil = no category filter
    
        @FetchRequest private var dishes: FetchedResults<Dish>
    
        init(searchText: String, selectedCategory: String?) {
            self.searchText = searchText
            self.selectedCategory = selectedCategory
    
            let trimmedSearch = searchText.trimmingCharacters(in:   .whitespacesAndNewlines)  // get rid of any invisible chars
    
            let request = Dish.fetchRequest() //create Dish instance
            request.sortDescriptors = [
                NSSortDescriptor(key: "title", ascending: true)
            ]
    
            var subPredicates: [NSPredicate] = [] //allow double filter by title and category
    
            // Title search (if not empty)
            if !trimmedSearch.isEmpty {
                subPredicates.append(NSPredicate(format: "title CONTAINS[cd] %@",   trimmedSearch))
            }
    
            // Category filter (if selected)
            if let cat = selectedCategory {
                subPredicates.append(NSPredicate(format: "category ==[cd] %@", cat))
            }
    
            // assign new predicate
            if !subPredicates.isEmpty {
                request.predicate =     NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)
            }
    
            //print("Creating fetch request for search: '\(trimmedSearch)', category:       \(selectedCategory ?? "nil")")
            //print("Predicate: \(request.predicate?.predicateFormat ?? "nil (all         items)")")
            //print("Sort: \(request.sortDescriptors?.map { $0.key ?? "unknown" } ?? [])")
            // underscore for dishes to point to stored location/property
            _dishes = FetchRequest(fetchRequest: request, animation: .default)
        }

        var body: some View {
            if dishes.isEmpty
            {
                Text("No menu items available")
                .foregroundStyle(.secondary)
                .padding()
            }

            List(dishes) { dish in
                HStack
                {
                    VStack
                    {
                        Text("\(dish.title ?? "Untitled")")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 1)
                        
                        Text("\(dish.itemDescription ?? "Untitled")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .padding(.bottom, 1)

                        let priceString = dish.price ?? "0.00"
                        let priceValue = Double(priceString) ?? 0.0
                        Text(String(format: "$%.2f", priceValue))
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer()
                    
                    if dish.title == "Lemon Desert" {
                        Image.lemonDessert
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.gray)
                    } else if dish.title == "Grilled Fish" {
                        Image.grilledFish
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.gray)
                      } else if let filename = dish.image,
                        let url = URL(string: filename) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 80, height: 80)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.gray)
                    }
                } // hstack for dish display
                .onAppear {
                    //print("dish.image =", dish.image ?? "nil")
                }
                .padding(.vertical, 8)
            }
            .onAppear {
                print("FilteredDishesView appeared — dishes count: \(dishes.count)")
                if dishes.isEmpty {
                    print("Empty results — check if data exists in context")
                }
            }

        }
    }

    private func getMenuDataAsync() async {
        guard !isLoading else { return }
    
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
    
        let serverURLString =   "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
    
        guard let url = URL(string: serverURLString) else {
            await MainActor.run {
                errorMessage = "Invalid server URL"
                isLoading = false
            }
            return
        }
    
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
    
            // Optional: check HTTP status
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                await MainActor.run {
                    errorMessage = "Server error"
                    isLoading = false
                }
                return
            }
    
            let decoder = JSONDecoder()
            let menuResponse = try decoder.decode(MenuList.self, from: data)
    
            // Save to Core Data
            let context = PersistenceController.shared.container.viewContext
    
            for menuItem in menuResponse.menu {
                //print("Raw JSON item:")
                //print("  title: \(menuItem.title ?? "NIL")")
                //print("  price: \(menuItem.price ?? "NIL")")
                //print("  image: \(menuItem.image ?? "NIL")")
                //print("  category: \(menuItem.category ?? "NIL")")
                //print("  description: \(menuItem.description ?? "NIL")")

                let dish = Dish(context: context)
                dish.title = menuItem.title ?? "Untitled"
                dish.price = menuItem.price ?? "0.00"
                dish.image = menuItem.image ?? ""
                dish.category = menuItem.category ?? ""
                dish.itemDescription = menuItem.description ?? ""
            }
    
            try context.save()
            //print("Saved \(menuResponse.menu.count) dishes to Core Data")
    
            await MainActor.run {
                isLoading = false
            }
        } catch {
            await MainActor.run {
                errorMessage = "Failed to load menu: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
}

#Preview {
    Menu()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}

