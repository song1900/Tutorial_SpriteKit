//
//  PopViewController.swift
//  Tutorial_SpliteKit
//
//  Created by 송우진 on 2021/02/16.
//

import UIKit
import SpriteKit

class PopViewController: UIViewController {

    // MARK: - Properties
    var isButtonAvailable: Bool = true
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Song1900"
        return label
    }()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var paticleView: SKView = {
        let view = SKView()
        view.backgroundColor = .clear
        let scene = SKScene()
        scene.backgroundColor = .clear
        view.presentScene(scene)
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
        view.addSubview(paticleView)
        view.addSubview(container)
        container.addSubview(myLabel)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImage))
        container.addGestureRecognizer(tapRecognizer)
        
        [paticleView, container, myLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        myLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        myLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        
        paticleView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        paticleView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        paticleView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        paticleView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    // MARK: - Actions
    @objc func setImage() {
        guard isButtonAvailable, let image = container.asUIImage() else { return }
        isButtonAvailable = false

        let texture = SKTexture(image: image)
        let scene = PopScene()
        scene.emitter?.particleTexture = texture
        paticleView.presentScene(scene)

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) { [weak self] in
            self?.isButtonAvailable = true
        }
    }
    
}


extension UIView {
    func asUIImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.frame.width, height: self.frame.height), true, 1)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}

class PopScene: SKScene {
    let emitter: SKEmitterNode? = {
        let node = SKEmitterNode(fileNamed: "Paticle")
        node?.position = .zero
        return node
    }()

    override func didMove(to view: SKView) {
        setScene(view)
        guard let emitter = emitter else { return }
        scene?.addChild(emitter)
    }

    override func didApplyConstraints() {
        guard let view = view else { return }
        scene?.size = view.frame.size
    }

    private func setScene(_ view: SKView) {
        backgroundColor = .clear
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene?.scaleMode = .aspectFill
    }
}
