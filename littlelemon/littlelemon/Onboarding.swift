//
//  Onboarding.swift
//  littlelemon
//
//  Created by William Tempero on 2/28/26.
//

import SwiftUI

// bool user data keys
let kIsLoggedIn = "isLoggedIn"
let kIsUseAvatar = "isUseAvatar"
let kIsOrderStatuses = "isOrderStatuses"
let kIsPasswordChanges = "isPasswordChanges"
let kIsSpecialOffers = "isSpecialOffers"
let kIsNewsletter = "isNewsletter"

// string user data keys
let kFirstName = "firstName"
let kLastName = "lastName"
let kEmail = "email"
let kPhoneNumber = "phoneNumber"

struct Onboarding: View {

    // user data bools
    @State var isLoggedIn = false
    @State var isUseAvatar = true
    @State var isOrderStatuses = false
    @State var isPasswordChanges = false
    @State var isSpecialOffers = false
    @State var isNewsletter = false

    // user data strings
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var phoneNumber = ""
    
    var body: some View {
        NavigationStack{
            HStack {
                Image(.logo)
                    .resizable()
                    .frame(maxWidth: 250, maxHeight: 40)
                    //.aspectRatio(1.0, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .background(.white)
            }

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

            } // static/green title area vstack
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .padding(.bottom, 16)
            .background(Color.littleLemonGreen)

            VStack {
                Text("Please Register")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.top, 8)
                    .padding(.bottom, 2)

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

                TextField("Phone Number", text: $phoneNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)

                Text("Email Notifications")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.top, 8)
                    .padding(.bottom, 2)
                    //.border(Color.red)
    
                 Toggle("Order Statuses", isOn: $isOrderStatuses)
                    .padding(.vertical, 2)
                    .padding(.horizontal)
                Toggle("Password changes", isOn: $isPasswordChanges)
                    .padding(.vertical, 2)
                    .padding(.horizontal)
                Toggle("Special offers", isOn: $isSpecialOffers)
                    .padding(.vertical, 2)
                    .padding(.horizontal)
                Toggle("Newsletter", isOn: $isNewsletter)
                    .padding(.vertical, 2)
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
                    UserDefaults.standard.set(firstName,   forKey: kFirstName)
                    UserDefaults.standard.set(lastName,    forKey: kLastName)
                    UserDefaults.standard.set(email,       forKey: kEmail)
                    UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
 
                    UserDefaults.standard.set(isUseAvatar,       forKey: kIsUseAvatar)
                    UserDefaults.standard.set(isOrderStatuses,   forKey: kIsOrderStatuses)
                    UserDefaults.standard.set(isPasswordChanges, forKey: kIsPasswordChanges)
                    UserDefaults.standard.set(isSpecialOffers,   forKey: kIsSpecialOffers)
                    UserDefaults.standard.set(isNewsletter,      forKey: kIsNewsletter)

                    UserDefaults.standard.set(true, forKey: kIsLoggedIn)
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
                } else { // clear all
                    print("Clearing user data")
                    UserDefaults.standard.set("", forKey: kFirstName)
                    UserDefaults.standard.set("", forKey: kLastName)
                    UserDefaults.standard.set("", forKey: kEmail)
                    UserDefaults.standard.set("", forKey: kPhoneNumber)
 
                    UserDefaults.standard.set(true, forKey: kIsUseAvatar)
                    UserDefaults.standard.set(false, forKey: kIsOrderStatuses)
                    UserDefaults.standard.set(false, forKey: kIsPasswordChanges)
                    UserDefaults.standard.set(false, forKey: kIsSpecialOffers)
                    UserDefaults.standard.set(false, forKey: kIsNewsletter)

                    isLoggedIn = false
                    isUseAvatar = true
                    isOrderStatuses = false
                    isPasswordChanges = false
                    isSpecialOffers = false
                    isNewsletter = false
                    
                    firstName = ""
                    lastName = ""
                    email = ""
                    phoneNumber = ""
                }
            }
            .navigationBarBackButtonHidden(true)
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

