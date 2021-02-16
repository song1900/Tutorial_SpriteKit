//
//  RootViewController.swift
//  Tutorial_SpliteKit
//
//  Created by 송우진 on 2021/02/16.
//

import UIKit

class RootViewController: UIViewController {
    // MARK: - Properties
    lazy var popButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pop", for: .normal)
        button.addTarget(self, action: #selector(mainToPopView), for: .touchUpInside)
        return button
    }()
    
    lazy var detailedPopButton: UIButton = {
        let button = UIButton()
        button.setTitle("DetailedPop", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(mainToPopView), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [popButton, detailedPopButton])
        view.axis = .vertical
        view.spacing = 15
        return view
    }()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    // MARK: - Configure
    func configureUI() {
        view.backgroundColor = .black
        
        view.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    // MARK: - Actions
    @objc func mainToPopView() {
        let vc = PopViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func mainToDetailedPopView() {
        
    }
    

}
