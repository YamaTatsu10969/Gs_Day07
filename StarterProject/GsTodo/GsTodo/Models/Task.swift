//
//  Task.swift
//  GsTodo
//
//  Created by yamamototatsuya on 2020/01/15.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import Foundation

// Task のクラス。
// プロパティに title と memo を持っている
class Task: Codable {
    var title: String
    var memo: String?
    
    // init とは、Task を作るときに呼ばれるメソッド。(イニシャライザという)
    // 使い方： let task = Task(title: "プログラミング")
    init(title: String, memo: String = "") {
        self.title = title
        self.memo = memo
    }
}
