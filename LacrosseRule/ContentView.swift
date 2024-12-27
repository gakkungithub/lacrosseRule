//
//  ContentView.swift
//  LacrosseRule
//
//  Created by Gaku Takahashi on 2024/12/07.
//

import SwiftUI

struct CustomBackButton: View{
    @Environment(\.dismiss) var dismiss
    var label: String
    
    var body: some View {
        Button(action:{
            dismiss()
        }){
            HStack{
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
                    .font(.title)
                Text(label)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct CustomNavigationLink: View{
    var destination: AnyView
    var title: String
    var backgroundColor: Color
    var foregroundColor: Color
    
    var body: some View{
        NavigationLink(destination: destination){
            Text(title)
                .font(.title)
                .frame(width: 250, height:100)
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Text("Lax Learner")
                    .font(.system(size: 60))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                    .foregroundColor(.white)
                    .shadow(color: .red, radius: 5, x: 2, y: 2)
                CustomNavigationLink(destination:AnyView(MainView()), title: "スタート", backgroundColor: Color.red,
                                     foregroundColor: Color.white)
            }
            .padding()
        }
    }
}

struct MainView: View{
    @Environment(\.dismiss) var dismiss
    var body: some View{
        VStack(spacing: 40){
            CustomNavigationLink(destination:AnyView(TestModeSelectView()), title: "テストモード", backgroundColor: Color.red,
                                 foregroundColor: Color.white)
            CustomNavigationLink(destination:AnyView(MainView()), title: "復習モード", backgroundColor: Color.yellow,
                                 foregroundColor: Color.white)
            CustomNavigationLink(destination:AnyView(MainView()), title: "試合モード", backgroundColor: Color.gray,
                                 foregroundColor: Color.white)
            .opacity(0.5)
            .disabled(true)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                CustomBackButton(
                label: "タイトルに戻る"
                )
            }
            ToolbarItem(placement:.navigationBarTrailing){
                NavigationLink(destination:rankingView()){
                    Image(systemName:"trophy.fill")
                        .font(.title)
                }
            }
        }
    }
}

struct TestModeSelectView: View{
    var body: some View{
        VStack(spacing: 40){
            Text("モードを選んでください")
                .font(.largeTitle)
            CustomNavigationLink(destination:AnyView(TestModeView()), title: "審判試験モード", backgroundColor: Color.red,
                                 foregroundColor: Color.white)
            CustomNavigationLink(destination:AnyView(TestModeView()), title: "新人戦モード", backgroundColor: Color.yellow,
                                 foregroundColor: Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                CustomBackButton(
                label: "モード選択画面に戻る"
                )
            }
        }
    }
}

struct TestModeView: View{
    //タイマーモジュールを呼び出す
    @StateObject private var timerController = TimerModel()
    @StateObject private var quizDBController = QuizDBManager()
    var score = 0
    
    var body: some View{
        Text("テストモード")
            .toolbar{
                ToolbarItem(placement:.navigationBarTrailing){
                    HStack(){
                        Image(systemName: "stopwatch.fill")
                        Text("\(timerController.timeString(time: timerController.count))")
                    }
                }
            }
        Text("\(quizDBController.openDB())")
//        ForEach(quizDBController.select(), id: \.self){
//            quiz in Text("\(quiz)")
//        }
        //Text("\(quizDBController.select())")
            .onAppear{
                timerController.start()
            }
            .navigationDestination(isPresented: $timerController.isEnd){
                ResultView(result:score)
            }
    }
}

struct ResultView: View{
    var result: Int
    var body: some View{
        Text("今回のスコアは: \(result) です!!")
            .navigationBarBackButtonHidden(true)
    }
}

struct StudyModeView: View{
    var body: some View{
        Text("出題範囲を選んでください")
            .font(.largeTitle)
    }
}

struct rankingView: View{
    var body: some View{
        Text("ランキング")
            .font(.largeTitle)
    }
}

#Preview {
    ContentView()
}
