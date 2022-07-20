//
//  CategorisedLoggingViewController.swift
//  LoggerDemo
//

import UIKit

extension AppLogger {
    
    static let ui = AppLogger(category: "ui")
}

class CategorisedLoggingViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Categorised"
        label.textColor = .red
        label.font = .systemFont(ofSize: 30)
        
        let debugButton = UIButton()
        debugButton.setTitle("Debug", for: [])
        debugButton.setTitleColor(.black, for: [])
        debugButton.addTarget(self, action: #selector(self.debugLogTouched(_:)), for: .touchUpInside)
        
        let verboseButton = UIButton()
        verboseButton.setTitle("Verbose", for: [])
        verboseButton.setTitleColor(.black, for: [])
        verboseButton.addTarget(self, action: #selector(self.verboseLogTouched(_:)), for: .touchUpInside)
        
        let infoButton = UIButton()
        infoButton.setTitle("Info", for: [])
        infoButton.setTitleColor(.black, for: [])
        infoButton.addTarget(self, action: #selector(self.infoLogTouched(_:)), for: .touchUpInside)
        
        let warningButton = UIButton()
        warningButton.setTitle("Warning", for: [])
        warningButton.setTitleColor(.black, for: [])
        warningButton.addTarget(self, action: #selector(self.warningLogTouched(_:)), for: .touchUpInside)
        
        let errorButton = UIButton()
        errorButton.setTitle("Error", for: [])
        errorButton.setTitleColor(.black, for: [])
        errorButton.addTarget(self, action: #selector(self.errorLogTouched(_:)), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [label, debugButton, verboseButton, infoButton, warningButton, errorButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerYAnchor)
        ])
    }
    
    
    @objc func debugLogTouched(_ sender: Any) {
        AppLogger.ui.debug("Debug log")
    }
    
    @objc func verboseLogTouched(_ sender: Any) {
        AppLogger.ui.verbose("Verbose log")
    }
    
    @objc func infoLogTouched(_ sender: Any) {
        AppLogger.ui.info("Info log")
    }
    
    @objc func warningLogTouched(_ sender: Any) {
        AppLogger.ui.warning("Warning log")
    }
    
    @objc func errorLogTouched(_ sender: Any) {
        AppLogger.ui.error("Error log")
    }
    
}
