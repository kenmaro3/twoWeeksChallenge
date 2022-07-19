//
//  Home.swift
//  twoWeeksChallenge
//
//  Created by Kentaro Mihara on 2022/07/19.
//

import SwiftUI
import Firebase

struct Home: View {
    // MARK: Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    // MARK: FaceID Properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    // MARK: Keychain Properties
    @KeyChain(key: "use_face_email", account: "FaceIDLogin") var storedEmail
    @KeyChain(key: "use_face_password", account: "FaceIDLogin") var storedPassword
    
    var body: some View {
        VStack(spacing: 20){
            if logStatus{
                Text("Logged in")
                Button("Logout"){
                    try? Auth.auth().signOut()
                    logStatus = false
                    
                }
            }
            else{
                Text("Came as a guest")
            }
            if useFaceID{
                Button("Disable Face ID"){
                    useFaceID = false
                    storedEmail = nil
                    storedPassword = nil
                }
            }
            
        }
        .navigationBarHidden(true)
        .navigationTitle("Home")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
