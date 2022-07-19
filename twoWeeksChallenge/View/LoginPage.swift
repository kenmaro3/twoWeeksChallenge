//
//  LoginPage.swift
//  twoWeeksChallenge
//
//  Created by Kentaro Mihara on 2022/07/19.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var vm: LoginViewModel = LoginViewModel()
    
    // MARK: FaceID Properties
    @State var useFaceID: Bool = false
    var body: some View {
        VStack{
            Circle()
                .trim(from: 0, to: 0.5)
                .fill(.black)
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: -90))
                .hLeading()
                .offset(x: -23)
                .padding(.bottom, 30)
            Text("Login Now")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .hLeading()
            
            // MARK: TextFields
            TextField("Email", text: $vm.email)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            vm.email == "" ? Color.black.opacity(0.05) : Color.orange
                        )
                }
                .textInputAutocapitalization(.never)
                .padding(.top, 20)
            
            SecureField("Password", text: $vm.password)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            vm.password == "" ? Color.black.opacity(0.05) : Color.orange
                        )
                }
                .textInputAutocapitalization(.never)
                .padding(.top, 15)
            
            // MARK: User prompt to ask to store login using FaceID on next time
            if vm.getBioMetricStatus(){
                Group{
                    if vm.useFaceID{
                        Button{
                            Task{
                                do{
                                    try await vm.authenticateUser()
                                }catch{
                                    vm.errorMessage = error.localizedDescription
                                    vm.showError.toggle()
                                    
                                }
                                
                            }
                            
                        }label: {
                            VStack(alignment: .leading, spacing: 10, content: {
                                Label{
                                    Text("use FaceID to login")
                                    
                                } icon: {
                                    Image(systemName: "faceid")
                                    
                                }
                                .font(.caption)
                                .foregroundColor(.gray)
                                
                                Text("You can turn it on in settings")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                
                            })
                        }
                        
                    }
                    else{
                        Toggle(isOn: $useFaceID){
                            Text("Use FaceID to Login")
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
                .padding(.vertical, 15)
                
            }

            
            Button{
                Task{
                    do{
                        try await vm.loginUser(useFaceID: useFaceID)
                        
                    }
                    catch{
                        vm.errorMessage = error.localizedDescription
                        vm.showError.toggle()
                        
                    }
                }
                
            }label:{
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .hCenter()
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.brown)
                    }
            }
            .padding(.top, 25)
            .disabled(vm.email == "" || vm.password == "")
            .opacity(vm.email == "" || vm.password == "" ? 0.5 : 1)
            .alert(vm.errorMessage, isPresented: $vm.showError){
                
            }
            
            NavigationLink{
                // MARK: Going home without login
                
            } label : {
                Text("Skip Now")
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 15)
        }
        .padding(.horizontal, 25)
        .padding(.vertical)
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

// MARK: Extension for UI Designing
extension View{
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing()->some View{
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View{
        self.frame(maxWidth: .infinity, alignment: .center)
    }
}
