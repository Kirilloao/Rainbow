//
//  SettingsViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private lazy var gameTimeView: SettingView = {
        let view = SettingView(labelText: "время игры")
        view.addSlider(UISlider())
        return view
    }()
    
    private lazy var speedTimeView: SettingView = {
        let view = SettingView(labelText: "скорость смены заданий, сек")
        view.addSlider(UISlider())
        return view
    }()
    
    private lazy var witchCheckView: SettingView = {
        let view = SettingView(labelText: "игра с проверкой заданий")
        view.addControl(UISwitch())
        return view
    }()
    
//    private lazy var letterColorsView: SettingView = {
//        let view = SettingView(labelText: "цвета букв")
//        return view
//    }()
    
    private lazy var letterColorsView: SettingView = {
        let view = SettingView(labelText: "цвета букв")
        view.addColorButtons(colors: [.red, .blue, .green, .yellow, .purple, .orange, .red, .blue, .green, .yellow, .purple, .orange])
        return view
    }()
    
    private lazy var letterSizeView: SettingView = {
        let view = SettingView(labelText: "размер букв")
        view.addControl(UIStepper())
        return view
    }()
    
    private lazy var letterBackgroundView: SettingView = {
        let view = SettingView(labelText: "подложка для букв")
        view.addControl(UISwitch())
        return view
    }()
    
    private lazy var backgroundColorView: SettingView = {
        let view = SettingView(labelText: "цвет фона")
        view.addSegmentedControl(titles: ["Cерый","Белый","Черный"], defaultSelectedIndex: 0)
        return view
    }()
    
    private lazy var wordsPosition: SettingView = {
        let view = SettingView(labelText: "расположение слова на экране")
        view.addSegmentedControl(titles: ["Случайное","По центру"], defaultSelectedIndex: 1)
        return view
    }()
    
    
    private func setupUI() {
            
        view.addSubviews(gameTimeView,speedTimeView,witchCheckView,letterColorsView,letterSizeView,letterBackgroundView,backgroundColorView,wordsPosition)
        
          NSLayoutConstraint.activate([
            gameTimeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            gameTimeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            speedTimeView.topAnchor.constraint(equalTo: gameTimeView.bottomAnchor, constant: 14),
            speedTimeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            witchCheckView.topAnchor.constraint(equalTo: speedTimeView.bottomAnchor, constant: 14),
            witchCheckView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            letterColorsView.topAnchor.constraint(equalTo: witchCheckView.bottomAnchor, constant: 14),
            letterColorsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            letterSizeView.topAnchor.constraint(equalTo: letterColorsView.bottomAnchor, constant: 14),
            letterSizeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            letterBackgroundView.topAnchor.constraint(equalTo: letterSizeView.bottomAnchor, constant: 14),
            letterBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backgroundColorView.topAnchor.constraint(equalTo: letterBackgroundView.bottomAnchor, constant: 14),
            backgroundColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            wordsPosition.topAnchor.constraint(equalTo:  backgroundColorView.bottomAnchor, constant: 14),
            wordsPosition.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
          ])
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .grayBackgroundColor
        navigationItem.title = "Настройки"
        setupUI()
        
    }
    
}



import SwiftUI
struct Provider_SettingsViewController : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return SettingsViewController()
        }
        
        typealias UIViewControllerType = UIViewController
        
        
        let viewController = SettingsViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<Provider_SettingsViewController.ContainterView>) -> SettingsViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: Provider_SettingsViewController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<Provider_SettingsViewController.ContainterView>) {
            
        }
    }
    
}
