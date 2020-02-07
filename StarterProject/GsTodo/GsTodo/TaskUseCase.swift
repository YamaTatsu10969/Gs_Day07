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
import FirebaseFirestoreSwift

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
        let encodeTask = try! Firestore.Encoder().encode(task)
        documentRef.setData(encodeTask) { (err) in
            if let _err = err {
                print("データ追加失敗",_err)
            } else {
                print("データ追加成功")
            }
        }
    }
    
    func editTask(_ task: Task){
        let documentRef = self.getCollectionRef().document(task.id)
        let encodeTask = try! Firestore.Encoder().encode(task)
        documentRef.updateData(encodeTask) { (err) in
            if let _err = err {
                print("データ修正失敗",_err)
            } else {
                print("データ修正成功")
            }
        }
    }
    
    func removeTask(taskId: String){
        let documentRef = self.getCollectionRef().document(taskId)
        documentRef.delete { (err) in
            if let _err = err {
                print("データ取得",_err)
            } else {
                print("データ削除成功")
            }
        }
    }
}
