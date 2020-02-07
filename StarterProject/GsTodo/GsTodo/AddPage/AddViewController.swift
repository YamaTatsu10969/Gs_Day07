//
//  AddViewController.swift
//  GsTodo
//
//  Created by yamamototatsuya on 2020/01/15.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import UIKit
import PKHUD

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    
    // 判定に使用するプロパティ
    var selectIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMemoTextView()
        setupNavigationBar()
        
        // Editかどうかの判定
        if let index = selectIndex {
            title = "編集"
            titleTextField.text = TaskCollection.shared.getTask(at: index).title
            memoTextView.text = TaskCollection.shared.getTask(at: index).memo
        }
    }
    
    // MARK: Setup
    fileprivate func setupMemoTextView() {
        memoTextView.layer.borderWidth = 1
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        memoTextView.layer.cornerRadius = 3
    }
    
    fileprivate func setupNavigationBar() {
        title = "Add"
        let rightButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    
    // MARK: Other Method
    @objc func tapSaveButton() {
        print("Saveボタンを押したよ！")
        
        guard let title = titleTextField.text else {
            return
        }
        
        if title.isEmpty {
            print(title, "👿titleが空っぽだぞ〜")
            
            HUD.flash(.labeledError(title: nil, subtitle: "👿 タイトルが入力されていません！！！"), delay: 1)
            // showAlert("👿 タイトルが入力されていません！！！")
            return // return を実行すると、このメソッドの処理がここで終了する。
        }
        
        // ここで Edit か Add　かを判定している
        if let index = selectIndex {
            // Edit
            let editTask = Task(title: title, memo: memoTextView.text)
            TaskCollection.shared.editTask(task: editTask, index: index)
        } else {
            // Add
            let task = Task(title: title, memo: memoTextView.text)
            TaskCollection.shared.addTask(task)
        }
        
        HUD.flash(.success, delay: 0.3)
        // 前の画面に戻る
        navigationController?.popViewController(animated: true)
    }
        
    #warning("他のViewController でも使えるように、UIViewController の Extension にする")

    
}

