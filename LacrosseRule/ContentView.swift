//
//  ContentView.swift
//  LacrosseRule
//
//  Created by Gaku Takahashi on 2024/12/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Lax Learner")
                    .font(.system(size: 60))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                    .foregroundColor(.white)
                    .shadow(color: .red, radius: 5, x: 2, y: 2)
                NavigationLink(destination: MainView()){
                    Text("スタート")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct MainView: View{
    @Environment(\.dismiss) var dismiss
    var body: some View{
        VStack{
            NavigationLink(destination: TestModeView()){
                Text("テストモード")
                    .font(.title)
                    .frame(width: 250, height:100)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            NavigationLink(destination: StudyModeView()){
                Text("復習モード")
                    .font(.title)
                    .frame(width: 250, height:100)
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            NavigationLink(destination: StudyModeView()){
                Text("試合モード")
                    .font(.title)
                    .frame(width: 250, height:100)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .opacity(0.5)
            }
            .disabled(true)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action:{
                    dismiss()
                }){
                    HStack{
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue)
                        Text("タイトルに戻る")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

struct TestModeView: View{
    var body: some View{
        Text("モードを選んでください")
            .font(.largeTitle)
    }
}

struct StudyModeView: View{
    var body: some View{
        Text("出題範囲を選んでください")
            .font(.largeTitle)
    }
}

#Preview {
    ContentView()
}
