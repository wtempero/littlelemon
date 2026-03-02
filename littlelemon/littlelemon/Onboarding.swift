//
//  Onboarding.swift
//  littlelemon
//
//  Created by William Tempero on 2/28/26.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"

struct Onboarding: View {
    @State var isLoggedIn = false
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
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
                    if (!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName,  forKey: kLastName)
                        UserDefaults.standard.set(email,     forKey: kEmail)
                        
                        if email.contains("@") && email.contains(".") {
                            print("Registration data saved — would navigate now")
                            isLoggedIn = true
                        } else {
                            print("Please enter a valid email address")
                        }
                    } else {
                        print("Please fill in all fields")
                    }
                    
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

