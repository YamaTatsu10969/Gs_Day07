//
//  TaskUseCase.swift
//  GsTodo
//
//  Created by Tatsuya Yamamoto on 2020/02/05.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class TaskUseCase {
    
    let db = Firestore.firestore()
    
    // ユーザー毎のデータベースへの参照を取得する
    private func getCollectionRef () -> CollectionReference {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError ("Uidを取得出来ませんでした。")
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
    

    
    func fetchTaskDocuments(callback: @escaping ([Task]?) -> Void){
        let collectionRef = getCollectionRef()
        collectionRef.getDocuments(source: .default) { (snapshot, err) in
            guard err == nil,
                let snapshot = snapshot,
                !snapshot.isEmpty else {
                    print("データ取得失敗",err.debugDescription)
                    callback(nil)
                    return
            }
            
            print("データ取得成功")
            
//            let tasks = try? Firestore.Decoder().decode([Task], from: snapshot.documents)
            
            let tasks = snapshot.documents.compactMap { snapshot in
                return try? Firestore.Decoder().decode(Task.self, from: snapshot.data())
            }
//            let taskCollection: [Task] = _snapshot.documents.compactMap{ (snapshot) in
//                let id = snapshot.documentID
//                let value = snapshot.data()
//                return Task(id : id ,value: value)
//            }
            
            callback(tasks)
        }
    }
}
