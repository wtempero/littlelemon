//
//  Menu.swift
//  littlelemon
//
//  Created by William Tempero on 2/28/26.
//

import SwiftUI

struct Menu: View {
    @State private var menuItems: [MenuItem] = []
    @State private var isLoading = false
    @State private var errorMessage: String? = nil
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header section (matches your mockup)
                VStack(spacing: 8) {
                    Text("Little Lemon")
                        .font(.system(size: 48, weight: .bold, design: .serif))
                        .foregroundColor(.littleLemonYellow)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    Text("Chicago")
                        .font(.system(size: 28, weight: .semibold, design: .serif))
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(6)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 8)
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                }
                .padding(.top, 40) // space from top of screen

                // Search bar (simple TextField)
                TextField("Search menu...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.vertical, 8)

                // Menu content area
                Group {
                    if isLoading {
                        ProgressView("Loading menu…")
                            .padding()
                    } else if let errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else if menuItems.isEmpty {
                        Text("No menu items available")
                            .foregroundStyle(.secondary)
                            .padding()
                    } else {
                        List(filteredMenuItems) { item in
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text("$\(item.price)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                // Add image, description later
                            }
                        }
                    }
                }
            }
            //.navigationTitle("Menu")
            // use task to run automatically on appear
            .task {
                await fetchMenuData()
            }
        }
    }

    // Computed property: filter + sort
    private var filteredMenuItems: [MenuItem] {
        let filtered = menuItems.filter { item in
            searchText.isEmpty ||
            item.title.localizedCaseInsensitiveContains(searchText)
            // Add more fields later, e.g. || item.description?.contains(searchText) ?? false
        }
        
        return filtered.sorted { $0.title < $1.title }
    }

    private func fetchMenuData() async {
        // use async above to allow caller to wait with await
        guard !isLoading else { return }  // don't restart if we're already loading
        isLoading = true
        errorMessage = nil

        // use defer to exit with isLoading false regardless of outcome
        defer { isLoading = false }

        do {
            let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
            // asynchronous fetch, error caught with try, returns Data, URL response
            // await allows non-blocking pause; no explicit completion handler needed
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            let menuList = try decoder.decode(MenuList.self, from: data)

            menuItems = menuList.menu
        } catch {
            errorMessage = "Failed to load menu: \(error.localizedDescription)"
        }
    }
}

#Preview {
    Menu()
}
