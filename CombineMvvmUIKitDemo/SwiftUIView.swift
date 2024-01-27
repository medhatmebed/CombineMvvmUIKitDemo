//
//  SwiftUIView.swift
//  CombineMvvmUIKitDemo
//
//  Created by Medhat Mebed on 1/26/24.
//

import SwiftUI

struct SwiftUIView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 50, height: 50)
                .onTapGesture {
                    dismiss()
                }
            
            Text("Hello, World!")
            
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    SwiftUIView()
}
