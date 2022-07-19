//
//  twoWeeksChallengeApp.swift
//  twoWeeksChallenge
//
//  Created by Kentaro Mihara on 2022/07/19.
//

import SwiftUI
import Firebase

@main
struct twoWeeksChallengeApp: App {
    // MARK: Initialize Firebase
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
