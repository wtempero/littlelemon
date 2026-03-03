//
//  Menu.swift
//  littlelemon
//
//  Created by William Tempero on 2/28/26.
//

import SwiftUI

struct Menu: View {
    @State private var userAvatar: Image? = nil  // or URL / initials fallback
    // or better: @ObservedObject var userViewModel: UserViewModel
    @State private var menuItems: [MenuItem] = []
    @State private var isLoading = false
    @State private var errorMessage: String? = nil
    @State private var searchText = ""

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Little Lemon")
                    .font(.system(size: 48, weight: .bold, design: .serif))
                    .foregroundColor(.littleLemonYellow)
                    //.background(Color.pink.opacity(0.3))

                HStack {
                    VStack(alignment: .leading, spacing: 0) {
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
                    } //location, description text vstack
                    //.background(Color.blue.opacity(0.2))
                    .padding(.trailing, 8)
                    .frame(maxWidth: .infinity)

                    Image(.hero)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1.0, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                } //location, description, hero image hstack

                // Search bar (simple TextField)
                TextField("Search menu...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, 8)
                    .padding(.bottom, 12)
            } // static title area vstack
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .background(Color.littleLemonGreen)

            // Menu content area
            NavigationStack {
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
                            } // menu item vstack
                        } // list
                    } // if isloading
                } // menu item group
                .frame(maxHeight: .infinity)  // ← key: let this grow

            } // navigation menu item stack
            .background(Color.pink.opacity(0.3))
        } // whole screen vstack
        // use task to run automatically on appear
        .task {
            await fetchMenuData()
        }
        .safeAreaInset(edge: .top) {
            // The top bar — white bg, fixed, overlays content below
            HStack {
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
            .padding(.vertical, 12)  // Tune height ~44-56pt standard
            .background(.white)      // White bg as per mockup
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)  // Optional subtle  shadow
            // .ignoresSafeArea(.top) if you want it under notch/status bar (common for     branded bars)
            }
            // Optional: .navigationBarHidden(true) if you want to fully hide default nav bar

    } // view

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
