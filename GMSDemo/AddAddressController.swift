//
//  AddAddressController.swift
//  GMSDemo
//
//  Created by Rey Cerio on 2018-06-15.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class AddAddressController: UIViewController {
    
    
    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "enter address..."
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let instructionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Instructions: Enter Address in this order: apartment, street, city,province/state, country."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBackTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
    }
    
    private func setupViews() {
        view.addSubview(addressTextField)
        view.addSubview(lineView)
        view.addSubview(instructionLabel)
        
        addressTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        addressTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        addressTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 10).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lineView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        lineView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 10).isActive = true
        
        instructionLabel.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 8).isActive = true
        instructionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        instructionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 10).isActive = true
        instructionLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func handleSubmit() {
        guard let location = self.addressTextField.text else {
            //alert here stating address textfield is empty
            return
        }
        presentMapView(location: location)
    }
    
    @objc func handleBackTap() {
        guard let location = self.addressTextField.text else {
            //alert here stating address textfield is empty
            return
        }
        presentMapView(location: location)
    }
    
    private func presentMapView(location: String) {
        let mapViewController = MapViewController()
        mapViewController.addressLocation = location
        let mapViewNav = UINavigationController(rootViewController: mapViewController)
        self.present(mapViewNav, animated: true, completion: nil)
    }
}
