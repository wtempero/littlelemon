//
//  UserProfile.swift
//  littlelemon
//
//  Created by William Tempero on 3/1/26.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? "John"
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? "Doe"
    let email = UserDefaults.standard.string(forKey: kEmail) ?? "No email"
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image.avatar
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            Text(firstName)
            Text(lastName)
            Text(email)
            Button("Log out") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    UserProfile()
}
