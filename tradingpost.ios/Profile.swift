//
//  Profile.swift
//  tradingpost.ios
//
//  Created by Nolan Shepherd on 6/23/23.
//

import Foundation
import SwiftUI

struct Profile: Codable {
    let username: String
    let email: String
    let password: String
}

class ProfileData: ObservableObject {
    @Published var currentProfile: Profile?
    
    func signUp(username: String, email: String, password: String) {
        let profile = Profile(username: username, email: email, password: password)
        // future: save to mongodb
        
        currentProfile = profile
    }
    
    func logIn(email: String, password: String) {
        // future: auth  user with email and password and retrieve data from mongodb

        let profile = Profile(username: "JohnDoe", email: email, password: password)
        currentProfile = profile
    }
}

struct ProfileView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    @ObservedObject var profileData: ProfileData
    
    var body: some View {
        VStack {
            if let profile = profileData.currentProfile {
                Text("Username: \(profile.username)")
                Text("Email: \(profile.email)")
                Text("Password: \(profile.password)")
            } else {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    profileData.signUp(username: username, email: email, password: password)
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    profileData.logIn(email: email, password: password)
                }) {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileData: ProfileData())
    }
}
