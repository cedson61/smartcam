//
//  ContentView.swift
//  smartcam
//
//  Created by Chase Edson on 2/14/21.
//

import SwiftUI
import AVFoundation



struct ContentView: View {
    @State var isCamEnabled = false
    
    var body: some View {
            
        if isCamEnabled{
            CameraUIView()
        } else{
            ZStack(alignment: .bottom) {
                Color.black
                    .ignoresSafeArea()
                
                Text("waiting for camera access...")
                    .foregroundColor(Color.white)
                    .padding()
                    .font(.custom("Menlo", size: 14))
                    .onAppear(perform: checkForAccess)

            }.onAppear(perform: checkForAccess)

            
        }
            
            
        
        
        
    }
    func checkForAccess() {

        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                print ("already authorized")
                isCamEnabled = true
                break
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        print ("recieved access!")
                        isCamEnabled = true
                        
                    }
                }
                break
            
            case .denied: // The user has previously denied access.
                print ("previously denied access")
                break
                
            case .restricted: // The user can't grant access due to restrictions.
                print ("user is a child and probably wouldn't have taken good photos anyways")
                break
            @unknown default:
                print ("unknown error, can't get camera")
                break
        }
        if (isCamEnabled == true){
            print ("switching now...")
        }
        
        
    }
}

//handles cases where camera access is allowed/not allowed





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
