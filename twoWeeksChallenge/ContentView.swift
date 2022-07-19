//
//  ContentView.swift
//  twoWeeksChallenge
//
//  Created by Kentaro Mihara on 2022/07/19.
//

import SwiftUI

struct ContentView: View {
    // MARK: Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    @KeyChain(key: "use_face_email", account: "FaceIDLogin") var storedEmail
    
    var body: some View {
        NavigationView{
            if logStatus{
                Home()
                    .onTapGesture {
                        print(storedEmail)
                    }
                
            }
            else{
                LoginPage()
                    .navigationBarHidden(true)
                    .onTapGesture {
                        print(storedEmail)
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
