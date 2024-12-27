//
//  TimerModel.swift
//  LacrosseRule
//
//  Created by Gaku Takahashi on 2024/12/08.
//

import Foundation
import Combine

class TimerModel: ObservableObject{
    @Published var count: Int = 2400
    @Published var timer: AnyCancellable!
    @Published var isEnd: Bool = false
    
    func start(){
        if let _timer = timer{
            _timer.cancel()
        }
        
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: ({_ in
                self.count -= 1
                if self.count == 0 {
                    self.isEnd = true
                    print("\(self.isEnd)")
                }
            }))
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
