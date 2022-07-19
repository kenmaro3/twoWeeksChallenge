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
    
    var body: some View {
        NavigationView{
            if logStatus{
                Home()
                
            }
            else{
                LoginPage()
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
