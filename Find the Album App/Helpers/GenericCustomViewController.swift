//
//  GenericCustomViewController.swift
//  Find the Album App
//
//  Created by Nikita Seliverstov on 14.12.2020.
//

import UIKit

class GenericCustomViewController<CustomView: UIView>: UIViewController {
    
    var customView: CustomView {
        return view as! CustomView
    }

    override func loadView() {
        view = CustomView()
    }
}
