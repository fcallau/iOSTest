//
//  TestKeyboardViewController.swift
//  TestKeyboard
//
//  Created by Francesc Callau Brull on 4/10/18.
//  Copyright © 2018 fcallau. All rights reserved.
//

import UIKit

class TestKeyboardViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var town: UITextField!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var itemIsFirstResponder: UITextField?
    var keyboardNotificationInfo: [AnyHashable : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(TestKeyboardViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(TestKeyboardViewController.keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(TestKeyboardViewController.keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(TestKeyboardViewController.keyboardDidChangeFrame(notification:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(TestKeyboardViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(TestKeyboardViewController.keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        setupUI()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing (\(textField.placeholder!))" )
        itemIsFirstResponder = textField
        showElementsPosition()
        moveView()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    func showElementsPosition() {
        print("name.frame: \(name.frame)")
        print("name.bounds: \(name.bounds)")
        print("town.frame: \(town.frame)")
        print("town.bounds: \(town.bounds)")
    }
    
    func printInfo() {
        print("self.view.bounds.width: \(self.view.bounds.width)")
        print("self.view.bounds.height: \(self.view.bounds.height)")
        
        print("name.bounds.width: \(name.bounds.width)")
        print("name.bounds.height: \(name.bounds.height)")
        print("name.bounds.origin.x: \(name.bounds.origin.x)")
        print("name.bounds.origin.y: \(name.bounds.origin.y)")
        print("name.bounds.size.width: \(name.bounds.size.width)")
        print("name.bounds.size.height: \(name.bounds.size.height)")
        
        print("name.frame.width: \(name.frame.width)")
        print("name.frame.height: \(name.frame.height)")
        print("name.frame.origin.x: \(name.frame.origin.x)")
        print("name.frame.origin.y: \(name.frame.origin.y)")
        print("name.frame.size.width: \(name.frame.size.width)")
        print("name.frame.size.height: \(name.frame.size.height)")
        
        print("town.bounds.width: \(town.bounds.width)")
        print("town.bounds.height: \(town.bounds.height)")
        print("town.bounds.origin.x: \(town.bounds.origin.x)")
        print("town.bounds.origin.y: \(town.bounds.origin.y)")
        print("town.bounds.size.width: \(town.bounds.size.width)")
        print("town.bounds.size.height: \(town.bounds.size.height)")
        
        print("town.frame.width: \(town.frame.width)")
        print("town.frame.height: \(town.frame.height)")
        print("town.frame.origin.x: \(town.frame.origin.x)")
        print("town.frame.origin.y: \(town.frame.origin.y)")
        print("town.frame.size.width: \(town.frame.size.width)")
        print("town.frame.size.height: \(town.frame.size.height)")
    }
    
    func setupUI() {
        //        printInfo()
        
        name.autocorrectionType = .no
        name.delegate = self
        name.placeholder = "Name"
        
        town.autocorrectionType = .no
        town.delegate = self
        town.placeholder = "Town"
    }
    
    func moveView() {
//        print("delegate.topSafeAreaInset: \(delegate.topSafeAreaInset)")
//        print("delegate.bottomSafeAreaInset: \(delegate.bottomSafeAreaInset)")
        if let item = itemIsFirstResponder {
//            print("keyboardNotificationInfo: \(keyboardNotificationInfo)")
            let yTopItem = item.frame.origin.y + self.view.frame.origin.y
            let yBottomItem = item.frame.origin.y + item.frame.size.height + self.view.frame.origin.y
            let spaceBetweenBottomItemAndTopKeyboard: CGFloat
            
            if let keyboardFrameEndUserInfoKey = keyboardNotificationInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                print("keyboardFrameEndUserInfoKey: \(String(describing: keyboardFrameEndUserInfoKey))")
                print("yTopItem: \(yTopItem)")
                print("yBottomItem: \(yBottomItem)")
                let topKeyboard = (keyboardFrameEndUserInfoKey as CGRect).origin.y
                print("topKeyboard: \(topKeyboard)")
                spaceBetweenBottomItemAndTopKeyboard = topKeyboard - yBottomItem
                print("spaceBetweenBottomItemAndTopKeyboard: \(spaceBetweenBottomItemAndTopKeyboard)")
                
                if yTopItem < 20.0 {
                    let deltaY:CGFloat = yTopItem - delegate.topSafeAreaInset
                    print("deltaY: \(deltaY)")
                    let initialViewFrame = self.view.frame
                    print("initialViewFrame: \(initialViewFrame)")
                    let finalViewFrame = CGRect(x: initialViewFrame.origin.x, y: initialViewFrame.origin.y - deltaY, width: initialViewFrame.size.width, height: initialViewFrame.size.height)
                    print("finalViewFrame: \(finalViewFrame)")
                    
                    self.view.frame = finalViewFrame
                }
                
                if spaceBetweenBottomItemAndTopKeyboard < 20.0 {
                    //                    let deltaY:CGFloat = yBottomItem + 20 - topKeyboard
                    let deltaY:CGFloat = yBottomItem - topKeyboard + delegate.bottomSafeAreaInset + 20
                    print("deltaY: \(deltaY)")
                    let initialViewFrame = self.view.frame
                    print("initialViewFrame: \(initialViewFrame)")
                    let finalViewFrame = CGRect(x: initialViewFrame.origin.x, y: initialViewFrame.origin.y - deltaY, width: initialViewFrame.size.width, height: initialViewFrame.size.height)
                    print("finalViewFrame: \(finalViewFrame)")
                    
                    self.view.frame = finalViewFrame
                }
            }
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        print("keyboardWillShow")
        
        if let nUserInfo = notification.userInfo {
            keyboardNotificationInfo = nUserInfo
        }
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        print("keyboardDidShow")
        
        if let nUserInfo = notification.userInfo {
            keyboardNotificationInfo = nUserInfo
        }
    }
    
    @objc func keyboardWillChangeFrame(notification: Notification) {
        print("keyboardWillChangeFrame")
        
        if let nUserInfo = notification.userInfo {
            keyboardNotificationInfo = nUserInfo
        }
    }
    
    @objc func keyboardDidChangeFrame(notification: Notification) {
        print("keyboardDidChangeFrame")
        
        if let nUserInfo = notification.userInfo {
            keyboardNotificationInfo = nUserInfo
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        print("keyboardWillHide")
        
        if let nUserInfo = notification.userInfo {
            keyboardNotificationInfo = nUserInfo
        }
    }
    
    @objc func keyboardDidHide(notification: Notification) {
        print("keyboardDidHide")
        
        if let nUserInfo = notification.userInfo {
            keyboardNotificationInfo = nUserInfo
        }
    }
    
}
