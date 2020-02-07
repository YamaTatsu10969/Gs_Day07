//
//  TaskUseCase.swift
//  GsTodo
//
//  Created by Tatsuya Yamamoto on 2020/02/07.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class TaskUseCase {
    let db = Firestore.firestore()
    
    private func getCollectionRef () -> CollectionReference {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError ("Uidを取得出来ませんでした。") //本番環境では使わない
        }
        return self.db.collection("users").document(uid).collection("tasks")
    }
    
    func createTaskId() -> String {
        let id = self.getCollectionRef().document().documentID
        print("taskIdは",id)
        return id
    }
    
    func addTask(_ task: Task){
        let documentRef = self.getCollectionRef().document(task.id)
        // TODO: 修正する
        let encodeTask:[String: Any] = [:]
        documentRef.setData(encodeTask) { (err) in
            if let _err = err {
                print("データ追加失敗",_err)
            } else {
                print("データ追加成功")
            }
        }
    }
}
