//
//  Onboarding.swift
//  littlelemon
//
//  Created by William Tempero on 2/28/26.
//

import SwiftUI

let kFirstName = "firstName"
let kLastName = "lastName"
let kEmail = "email"
let kIsLoggedIn = "isLoggedIn"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack{
            VStack {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                TextField("Last Name", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)

                Button {
                    // Basic validation
                    guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty else {
                        print("Please fill in all fields")
                        return
                    }
                    
                    guard email.contains("@"), email.contains(".") else {
                        print("Please enter a valid email address")
                        return
                    }
                    
                    // Save data
                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName,  forKey: kLastName)
                    UserDefaults.standard.set(email,     forKey: kEmail)
                    UserDefaults.standard.set(true,      forKey: kIsLoggedIn)
                    isLoggedIn = true
                    
                    // force write (helps in some simulator/debug situations)
                    UserDefaults.standard.synchronize()
                    
                    print("Registration successful — navigating to Home")
                    
                 } label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
            // Modern programmatic navigation trigger — no NavigationLink needed
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
        }
    }
}

#Preview {
    Onboarding()
}

