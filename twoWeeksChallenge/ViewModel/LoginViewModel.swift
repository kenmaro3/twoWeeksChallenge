//
//  LoginViewModel.swift
//  twoWeeksChallenge
//
//  Created by Kentaro Mihara on 2022/07/19.
//

import SwiftUI
import Firebase
import LocalAuthentication

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: FaceID Properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    // MARK: Keychain Properties
    @KeyChain(key: "use_face_email", account: "FaceIDLogin") var storedEmail
    @KeyChain(key: "use_face_password", account: "FaceIDLogin") var storedPassword
    
    // MARK: Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    // MARK: Error
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: Firebase Login
    func loginUser(useFaceID: Bool, email: String = "", password: String = "")async throws{
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email : self.email, password: password != "" ? password : self.password)
        
        DispatchQueue.main.async {
            // Storing Once
            if useFaceID && self.storedEmail == nil{
                self.useFaceID = useFaceID
                
                // Setting Data is simple as @AppStorage
                let emailData = self.email.data(using: .utf8)
                let passwordData = self.password.data(using: .utf8)
                self.storedEmail = emailData
                self.storedPassword = passwordData
            }
            
            self.logStatus = true
        }
        
    }
    
    // MARK: FaceID Usage
    func getBioMetricStatus()->Bool{
        let scanner = LAContext()
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    // MARK: FaceID Login
    func authenticateUser()async throws{
        let status = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Login Into App")
        
        if let emailData = storedEmail, let passwordData = storedPassword, status{
            try await loginUser(useFaceID: useFaceID, email: String(data: emailData, encoding: .utf8) ?? "", password: String(data: passwordData, encoding: .utf8) ?? "")
        }
    }
    
    
}

