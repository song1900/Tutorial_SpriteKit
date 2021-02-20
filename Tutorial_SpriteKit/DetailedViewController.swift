//
//  DetailedViewController.swift
//  Tutorial_SpriteKit
//
//  Created by 송우진 on 2021/02/19.
//

import UIKit
import SpriteKit

class DetailedViewController: UIViewController {
    
    // MARK: - Properties
    var isButtonAvailable: Bool = true
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        view.textColor = .label
        view.text = "A Cup of Coffee"
        return view
    }()
    
    lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = .systemGray
        view.text = "Photo by tabitha turner on Unsplash"
        return view
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cup")
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 6
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImage))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()

    lazy var labelStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
        ])

        view.spacing = 4
        view.axis = .vertical

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
        view.backgroundColor = .white
        
        view.addSubview(paticleView)
        view.addSubview(container)
        
        [paticleView, container].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [imageView, labelStack].forEach {
            container.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        labelStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        labelStack.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        labelStack.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
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
        let scene = DetailedPopScene()
        scene.emitter?.particleTexture = texture
        paticleView.presentScene(scene)

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) { [weak self] in
            self?.isButtonAvailable = true
        }
    }

    

}

class DetailedPopScene: SKScene {
    let emitter: SKEmitterNode? = {
        let node = SKEmitterNode(fileNamed: "Magic")
        node?.position = .zero
        return node
    }()

    // MARK: Lifecycle

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
