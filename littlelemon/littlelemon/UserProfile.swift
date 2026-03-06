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

    @Environment(\.dismiss) private var dismiss
    
    @State private var isOrderStatusesChecked = false
    @State private var isPasswordChangesChecked = false
    @State private var isSpecialOffersChecked = false
    @State private var isNewsletterChecked = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack
            {
                Spacer()

                Image(.logo)
                    .resizable()
                    .frame(maxWidth: 200, maxHeight: 50)
                    //.aspectRatio(1.0, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Image(.avatar)
                    .resizable()
                    .frame(maxWidth: 50, maxHeight: 50)
                    .aspectRatio(1.0, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .background(.white)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

            Text("Personal Information")
                .font(.headline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                //.border(Color.red)

            Text("Avatar")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                //.border(Color.red)

            HStack {
                Image.avatar
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    
                    Button() {
                        
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
                    

                    Button() {
                        
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

            }

            Text("First Name")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)

           Text(firstName)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .border(Color.black)

            Text("Last Name")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)

            Text(lastName)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .border(Color.black)

            Text("Email")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)

            Text(email)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .border(Color.black)

            /*Text("Phone number")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)

            Text("(217)555-0113")
                .font(.headline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .border(Color.black)
*/
            
            Text("Email Notifications")
                .font(.headline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 4)
                .padding(.top, 16)
                //.border(Color.red)

            //Toggle("Subscribe to newsletter", isOn: true)
            Toggle("Order Statuses", isOn: $isOrderStatusesChecked)
                .padding(.vertical, 2)
            Toggle("Password changes", isOn: $isPasswordChangesChecked)
                .padding(.vertical, 2)
            Toggle("Special offers", isOn: $isSpecialOffersChecked)
                .padding(.vertical, 2)
            Toggle("Newsletter", isOn: $isNewsletterChecked)
                .padding(.vertical, 2)

            Spacer()

            Button("Log out") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                dismiss()
            }
            .padding()                             // space inside button
            .frame(maxWidth: .infinity)            // stretches horizontally
            .background(Color.littleLemonYellow)              // yellow background
            .foregroundColor(.black)               // text color
            .border(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .font(.headline)
            .padding(.horizontal, 2)
            .padding(.top, 0)
                
            HStack {
                Button("Discard changes") {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    dismiss()
                }
                .padding()                             // space inside button
                .frame(maxWidth: .infinity)            // stretches horizontally
                .background(Color.white)    // yellow background
                .foregroundColor(.black)               // text color
                .border(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .font(.headline)
                .padding(.horizontal, 2)
                .padding(.top, 24)

                 Button("Save changes") {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    dismiss()
                }
                .padding()                             // space inside button
                .frame(maxWidth: .infinity)            // stretches horizontally
                .background(Color.littleLemonGreen)
                .foregroundColor(.black)               // text color
                .border(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .font(.headline)
                .padding(.horizontal, 2)
                .padding(.top, 24)
           }
            
            //Spacer()

       }
        .padding(.horizontal, 12)
        //.padding(.vertical, 24)

        //.background(Color.red.opacity(0.3))


    }
}

#Preview {
    UserProfile()
}
