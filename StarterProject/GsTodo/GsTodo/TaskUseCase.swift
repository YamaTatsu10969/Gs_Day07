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
}
