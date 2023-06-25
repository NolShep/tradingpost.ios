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
    //Init object vars
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
        
    //validation messages
    @State private var usernameValidationMessage = ""
    @State private var passwordValidationMessage = ""
    @State private var emailValidationMessage = ""
    
    @ObservedObject var profileData: ProfileData
    
    var body: some View {
        VStack {
            if let profile = profileData.currentProfile {
                Text("Username: \(profile.username)")
                Text("Email: \(profile.email)")
                Text("Password: \(profile.password)")
            } else {
                //User text w/ error checking
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Text(usernameValidationMessage)
                    .foregroundColor(.red)
                
                //Email text w/ error checking
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Text(emailValidationMessage)
                    .foregroundColor(.red)
                
                //Pass text w/ error checking
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Text(passwordValidationMessage)
                    .foregroundColor(.red)
                
                //Sign Up/Login options
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
    
    //check for valid username
    private func validateUsername(_ username: String) {
        if username.count > 12 {
            usernameValidationMessage = "Username cannot exceed 12 characters"
        }
        else{
            usernameValidationMessage = ""
        }
    }
    
    //check for valid pass
    private func validatePassword(_ password: String) {
        if password.count < 7 || password.count > 15 {
            passwordValidationMessage = "Password must be between 7 and 15 characters"
        } else if !containsNumber(password) || !containsSpecialCharacter(password) {
            passwordValidationMessage = "Password must contain at least one number and one special character"
        } else {
            passwordValidationMessage = ""
        }
    }
    
    //helper for pass validation
    private func containsNumber(_ password: String) -> Bool {
        let numberRegex = ".*\\d.*"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberPredicate.evaluate(with: password)
    }
    
    //helper for pass validation
    private func containsSpecialCharacter(_ password: String) -> Bool {
        let specialCharRegex = ".*[@$!%*#?&].*"
        let specialCharPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharRegex)
        return specialCharPredicate.evaluate(with: password)
    }
    
    //check for valid email
    private func validateEmail(_ email: String) {
        if !email.contains("@") {
            emailValidationMessage = "Email must be valid"
        }
        else {
            emailValidationMessage = ""
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileData: ProfileData())
    }
}
