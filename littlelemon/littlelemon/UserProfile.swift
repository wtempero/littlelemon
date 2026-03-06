//
//  UserProfile.swift
//  littlelemon
//
//  Created by William Tempero on 3/1/26.
//

import SwiftUI

struct UserProfile: View {

    //optional vars, but it should not be possible to reach this screen if not set
    @State var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? "Place"
    @State var lastName = UserDefaults.standard.string(forKey: kLastName) ?? "Holder"
    @State var email = UserDefaults.standard.string(forKey: kEmail) ?? "place@holder.com"
    @State var phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ??  "(800)555-5555"

    // bools are never optional, if they don't exist they return false
    @State var isUseAvatar = UserDefaults.standard.bool(forKey: kIsUseAvatar)
    @State var isOrderStatuses = UserDefaults.standard.bool(forKey: kIsOrderStatuses)
    @State var isPasswordChanges = UserDefaults.standard.bool(forKey: kIsPasswordChanges)
    @State var isSpecialOffers = UserDefaults.standard.bool(forKey: kIsSpecialOffers)
    @State var isNewsletter = UserDefaults.standard.bool(forKey: kIsNewsletter)
    
    @State var isUseAvatarTemp = UserDefaults.standard.bool(forKey: kIsUseAvatar)
    @State private var goToOnboarding = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack
            {
                // Custom back button
                Button(action: {
                    dismiss() // This will pop the current view if it's in a navigation stack
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .padding(8)
                }

                Spacer()

                Image(.logo)
                    .resizable()
                    .frame(maxWidth: 200, maxHeight: 50)
                    //.aspectRatio(1.0, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                    if isUseAvatar {
                        Image.avatar
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.gray)
                            .background(
                                Circle()
                                    .fill(.ultraThinMaterial)
                            )
                    }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .background(.white)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

            ScrollView {
                Text("Personal Information")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 6)
                    .padding(.bottom, 2)
                    //.border(Color.red)
    
                Text("Avatar")
                    .padding(.bottom, -12)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.border(Color.red)
    
                HStack {
                    
                    if isUseAvatarTemp {
                        Image.avatar
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.gray)
                            .background(
                                Circle()
                                    .fill(.ultraThinMaterial)
                            )
                    }
                        
                        Spacer()
                        
                        Button() {
                            isUseAvatarTemp = !isUseAvatarTemp
                        } label: {
                            Text("Change")
                            .font(.headline)
                            .foregroundColor(.black)
                        }
                        .padding(16)
                        .background(.ultraThinMaterial)
                        .background(Color.littleLemonGreen)
                        .border(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                        
                        Spacer()
                                                
                        Button() {
                            isUseAvatarTemp = false
                        } label: {
                            Text("Remove")
                            .font(.headline)
                            .foregroundColor(.black)
                        }
                        .padding(16)
                        .background(.ultraThinMaterial)
                        .border(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                        
                        Spacer()
                }

                Text("First Name")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 2)
                    .padding(.horizontal, 8)
                    .padding(.bottom, -4)

                TextField("First Name", text: $firstName)
                    .font(.headline)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 4)

                Text("Last Name")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 2)
                    .padding(.horizontal, 8)
                    .padding(.bottom, -4)

                TextField("Last Name", text: $lastName)
                    .font(.headline)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 4)
    
                Text("Email")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 2)
                    .padding(.horizontal, 8)
                    .padding(.bottom, -4)

                TextField("Email", text: $email)
                    .font(.headline)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 4)

                Text("Phone number")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 2)
                    .padding(.horizontal, 8)
                    .padding(.bottom, -4)

                TextField("Phone Number", text: $phoneNumber)
                    .font(.headline)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 4)
                
                Text("Email Notifications")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                    .padding(.bottom, 2)
                    //.border(Color.red)
    
                Toggle("Order Statuses", isOn: $isOrderStatuses)
                    .padding(.vertical, 0)
                    .padding(.horizontal, 2)
                Toggle("Password changes", isOn: $isPasswordChanges)
                    .padding(.vertical, 0)
                    .padding(.horizontal, 2)
                Toggle("Special offers", isOn: $isSpecialOffers)
                    .padding(.vertical, 0)
                    .padding(.horizontal, 2)
                Toggle("Newsletter", isOn: $isNewsletter)
                    .padding(.vertical, 0)
                    .padding(.horizontal, 2)
    
                Spacer()
    
                Button("Log out") {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    
                    UserDefaults.standard.set("", forKey: kFirstName)
                    UserDefaults.standard.set("", forKey: kLastName)
                    UserDefaults.standard.set("", forKey: kEmail)
                    UserDefaults.standard.set("", forKey: kPhoneNumber)
 
                    UserDefaults.standard.set(true, forKey: kIsUseAvatar)
                    UserDefaults.standard.set(false, forKey: kIsOrderStatuses)
                    UserDefaults.standard.set(false, forKey: kIsPasswordChanges)
                    UserDefaults.standard.set(false, forKey: kIsSpecialOffers)
                    UserDefaults.standard.set(false, forKey: kIsNewsletter)

                    goToOnboarding = true
                }
                .padding()                             // space inside button
                .frame(maxWidth: .infinity)            // stretches horizontally
                .background(Color.littleLemonYellow)
                .foregroundColor(.black)
                .border(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .font(.headline)
                .padding(.horizontal, 2)
                .padding(.top, 12)
                    
                HStack {
                    Button("Discard changes") {
                        firstName = UserDefaults.standard.string(forKey: kFirstName) ?? "Place"
                        lastName = UserDefaults.standard.string(forKey: kLastName) ?? "Holder"
                        email = UserDefaults.standard.string(forKey: kEmail) ?? "place@holder.com"
                        phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ??  "(800)555-5555"
                    
                        isUseAvatar = UserDefaults.standard.bool(forKey: kIsUseAvatar)
                        isUseAvatarTemp = UserDefaults.standard.bool(forKey: kIsUseAvatar)
                        isOrderStatuses = UserDefaults.standard.bool(forKey: kIsOrderStatuses)
                        isPasswordChanges = UserDefaults.standard.bool(forKey: kIsPasswordChanges)
                        isSpecialOffers = UserDefaults.standard.bool(forKey: kIsSpecialOffers)
                        isNewsletter = UserDefaults.standard.bool(forKey: kIsNewsletter)
                    }
                    .padding()                             // space inside button
                    .frame(maxWidth: .infinity)            // stretches horizontally
                    .background(Color.white)
                    .foregroundColor(.black)
                    .border(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .font(.headline)
                    .padding(.horizontal, 2)
                    .padding(.top, 8)
    
                    Button("Save changes") {
                        // Save data
                        isUseAvatar = isUseAvatarTemp
                        
                        UserDefaults.standard.set(firstName,   forKey: kFirstName)
                        UserDefaults.standard.set(lastName,    forKey: kLastName)
                        UserDefaults.standard.set(email,       forKey: kEmail)
                        UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
    
                        UserDefaults.standard.set(isUseAvatar,       forKey: kIsUseAvatar)
                        UserDefaults.standard.set(isOrderStatuses,   forKey: kIsOrderStatuses)
                        UserDefaults.standard.set(isPasswordChanges, forKey: kIsPasswordChanges)
                        UserDefaults.standard.set(isSpecialOffers,   forKey: kIsSpecialOffers)
                        UserDefaults.standard.set(isNewsletter,      forKey: kIsNewsletter)
    
                        // force write (helps in some simulator/debug situations)
                        UserDefaults.standard.synchronize()
                    }
                    .padding()                             // space inside button
                    .frame(maxWidth: .infinity)            // stretches horizontally
                    .background(Color.littleLemonGreen)
                    .foregroundColor(.black)
                    .border(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .font(.headline)
                    .padding(.horizontal, 2)
                    .padding(.top, 8)
                }
                
                //Spacer()
            } // scrollview
        }
        .navigationDestination(isPresented: $goToOnboarding) {
            Onboarding()}
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 12)
        //.padding(.vertical, 24)

        //.background(Color.red.opacity(0.3))
    }
}

#Preview {
    UserProfile()
}
