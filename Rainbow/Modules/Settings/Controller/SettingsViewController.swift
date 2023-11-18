//
//  SettingsViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let dataSource: SettingsDataSource
    private var gameTimeValue = 2
    private var speedTimeValue = 0
    private var selectedColors: [UIColor] = []
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var gameTimeView: SettingView = {
        let view = SettingView(labelText: "время игры")
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.tintColor = .orange
        
        let valueLabel = UILabel()
        let value = Int(slider.value)
        gameTimeValue = value

        valueLabel.text = "\(gameTimeValue)"
        view.addSubviews(slider,valueLabel)
        
        NSLayoutConstraint.activate([
            
            valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: 36),
            
            slider.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -8),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.widthAnchor.constraint(equalToConstant: 110)
            
        ])
        
        return view
    }()
    
    
    private lazy var speedTimeView: SettingView = {
        let view = SettingView(labelText: "скорость смены заданий, сек")
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.tintColor = .orange
        
        let valueLabel = UILabel()
        let value = Int(slider.value)
        speedTimeValue = value
        
        valueLabel.text = "\(speedTimeValue)"
        view.addSubviews(slider,valueLabel)
        
        NSLayoutConstraint.activate([

            valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: 36),
            
            slider.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -8),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.widthAnchor.constraint(equalToConstant: 110)
        ])
        return view
    }()
    
    private lazy var witchCheckView: SettingView = {
        let view = SettingView(labelText: "игра с проверкой заданий")
        let control = UISwitch()
        control.isOn = true
        view.addSubviews(control)
        
        NSLayoutConstraint.activate([
            
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            control.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            control.widthAnchor.constraint(equalToConstant: 57)
        ])
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        let colors: [UIColor] =  [ .greenGameColor, .darkGreenGameColor, .pinkGameColor, .lightBlueGameColor, .darkRedGameColor, .purpleGameColor, .blueGameColor, .orangeGameColor, .redGameColor, .yellowGameColor, .black, .grayGameColor]
        
        var rowStackView: UIStackView?
        
        for (index, color) in colors.enumerated() {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = color
            
            let checkmarkView = UIImageView(image: UIImage(systemName: "checkmark"))
                    checkmarkView.tintColor = .white
                    checkmarkView.isHidden = false
                    button.addSubview(checkmarkView)
                    checkmarkView.translatesAutoresizingMaskIntoConstraints = false
            
                    NSLayoutConstraint.activate([
                        checkmarkView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                        checkmarkView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                    ])
            
            let widthConstraint = button.widthAnchor.constraint(equalToConstant: 25)
            let heightConstraint = button.heightAnchor.constraint(equalToConstant: 25)
            
            NSLayoutConstraint.activate([
                widthConstraint,
                heightConstraint,
            ])
            
            button.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
            
            if index % 6 == 0 {
                rowStackView = UIStackView()
                rowStackView?.translatesAutoresizingMaskIntoConstraints = false
                rowStackView?.axis = .horizontal
                rowStackView?.spacing = 5
                
                stackView.addArrangedSubview(rowStackView!)
            }
            
            rowStackView?.addArrangedSubview(button)
            
        }
        
        return stackView
    }()
    
    @objc private func colorButtonTapped(_ sender: UIButton) {
        sender.subviews.forEach { view in
            if let checkmarkView = view as? UIImageView {
                checkmarkView.isHidden = !checkmarkView.isHidden
            }
        }
    }
    
    private lazy var letterColorsView: SettingView = {
        let view = SettingView(labelText: "цвета букв")
        let stackView = buttonStackView
        
        view.addSubviews(stackView)
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return view
    }()
    
    private lazy var letterSizeView: SettingView = {
        let view = SettingView(labelText: "размер букв")
        let stepperLabel = UILabel(text: "Aa",font: .systemFont(ofSize: 15), color: .black)
        stepperLabel.text = "Aa"
        let stepper = UIStepper()
        
        view.addSubviews(stepper,stepperLabel)
        NSLayoutConstraint.activate([
            
            stepperLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stepperLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            stepperLabel.widthAnchor.constraint(equalToConstant: 27),
            stepper.trailingAnchor.constraint(equalTo: stepperLabel.leadingAnchor, constant: -20),
            stepper.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stepper.widthAnchor.constraint(lessThanOrEqualToConstant: 110)
        ])
        
        return view
    }()
    
    private lazy var letterBackgroundView: SettingView = {
        let view = SettingView(labelText: "подложка для букв")
        let control = UISwitch()
        control.isOn = true
        view.addSubviews(control)
        NSLayoutConstraint.activate([
            
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            control.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            control.widthAnchor.constraint(equalToConstant: 57)
        ])
        return view
    }()
    
    private lazy var backgroundColorView: SettingView = {
        let view = SettingView(labelText: "")
        let label = UILabel(text: "цвет фона",font: .systemFont(ofSize: 15))
        label.numberOfLines = 1
        
        let segmentedControl = UISegmentedControl(items: ["Серый", "Белый", "Черный"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        view.addSubviews(segmentedControl,label)
        
        NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
                
                segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                segmentedControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                segmentedControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
        
        return view
    }()

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Обработка изменения значения сегментированного контроля
        // Можете использовать sender.selectedSegmentIndex для получения выбранного индекса
    }

    private lazy var wordsPosition: SettingView = {
        let view = SettingView(labelText: "")
        let label = UILabel(text: "расположение слова на экране",font: .systemFont(ofSize: 15))
        label.numberOfLines = 1
        
        let segmentedControl = UISegmentedControl(items: ["Случайное","По центру"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(wordsPositionValueChanged(_:)), for: .valueChanged)
        
        view.addSubviews(segmentedControl,label)
        
        NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
                
                segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                segmentedControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                segmentedControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
        
        return view
    }()
    
    @objc private func wordsPositionValueChanged(_ sender: UISegmentedControl) {
        // Обработка изменения значения сегментированного контроля
        // Можете использовать sender.selectedSegmentIndex для получения выбранного индекса
    }
    
    //    private lazy var gameTimeView: SettingView = {
    //        let view = SettingView(labelText: "время игры")
    //        view.addSlider(minValue: 1, maxValue: 10)
    //        return view
    //    }()
    //
    //    private lazy var speedTimeView: SettingView = {
    //        let view = SettingView(labelText: "скорость смены заданий, сек")
    //        view.addSlider(minValue: 1, maxValue: 5)
    //        return view
    //    }()
    //
    //    private lazy var witchCheckView: SettingView = {
    //        let view = SettingView(labelText: "игра с проверкой заданий")
    //        view.addControl(UISwitch())
    //        return view
    //
    //    }()
    //
    //    private lazy var letterColorsView: SettingView = {
    //        let view = SettingView(labelText: "цвета букв")
    //        view.addColorButtons(colors: [.greenGameColor, .darkGreenGameColor, .pinkGameColor, .lightBlueGameColor, .darkRedGameColor, .purpleGameColor, .blueGameColor, .orangeGameColor, .redGameColor, .yellowGameColor, .black, .grayGameColor])
    //        return view
    //    }()
    //
    //    private lazy var letterSizeView: SettingView = {
    //        let view = SettingView(labelText: "размер букв")
    //        view.addControl(UIStepper())
    //        return view
    //    }()
    //
    //    private lazy var letterBackgroundView: SettingView = {
    //        let view = SettingView(labelText: "подложка для букв")
    //        view.addControl(UISwitch())
    //        return view
    //    }()
    //
    //    private lazy var backgroundColorView: SettingView = {
    //        let view = SettingView(labelText: "цвет фона")
    //        view.addSegmentedControl(titles: ["Cерый","Белый","Черный"], defaultSelectedIndex: 0)
    //        return view
    //    }()
    //
    //    private lazy var wordsPosition: SettingView = {
    //        let view = SettingView(labelText: "расположение слова на экране")
    //        view.addSegmentedControl(titles: ["Случайное","По центру"], defaultSelectedIndex: 1)
    //        return view
    //    }()
    
    
    //    private func setupUI() {
    //
    //        view.addSubviews(scrollView)
    //
    //        scrollView.addSubviews(gameTimeView,speedTimeView,witchCheckView,letterColorsView,letterSizeView,letterBackgroundView,backgroundColorView,wordsPosition)
    //
    //          NSLayoutConstraint.activate([
    //            gameTimeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
    //            gameTimeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //
    //            speedTimeView.topAnchor.constraint(equalTo: gameTimeView.bottomAnchor, constant: 14),
    //            speedTimeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //
    //            witchCheckView.topAnchor.constraint(equalTo: speedTimeView.bottomAnchor, constant: 14),
    //            witchCheckView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //
    //            letterColorsView.topAnchor.constraint(equalTo: witchCheckView.bottomAnchor, constant: 14),
    //            letterColorsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //
    //            letterSizeView.topAnchor.constraint(equalTo: letterColorsView.bottomAnchor, constant: 14),
    //            letterSizeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //
    //            letterBackgroundView.topAnchor.constraint(equalTo: letterSizeView.bottomAnchor, constant: 14),
    //            letterBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //
    //            backgroundColorView.topAnchor.constraint(equalTo: letterBackgroundView.bottomAnchor, constant: 14),
    //            backgroundColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //
    //            wordsPosition.topAnchor.constraint(equalTo:  backgroundColorView.bottomAnchor, constant: 14),
    //            wordsPosition.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //
    //          ])
    //      }
    
    private func setupUI() {
        
        
        view.addSubviews(scrollView)
        scrollView.addSubviews(gameTimeView,speedTimeView,witchCheckView,letterColorsView,letterSizeView,letterBackgroundView,backgroundColorView,wordsPosition)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            gameTimeView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            gameTimeView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            speedTimeView.topAnchor.constraint(equalTo: gameTimeView.bottomAnchor, constant: 14),
            speedTimeView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            witchCheckView.topAnchor.constraint(equalTo: speedTimeView.bottomAnchor, constant: 14),
            witchCheckView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            letterColorsView.topAnchor.constraint(equalTo: witchCheckView.bottomAnchor, constant: 14),
            letterColorsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            letterSizeView.topAnchor.constraint(equalTo: letterColorsView.bottomAnchor, constant: 14),
            letterSizeView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            letterBackgroundView.topAnchor.constraint(equalTo: letterSizeView.bottomAnchor, constant: 14),
            letterBackgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            backgroundColorView.topAnchor.constraint(equalTo: letterBackgroundView.bottomAnchor, constant: 14),
            backgroundColorView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            wordsPosition.topAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: 14),
            wordsPosition.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .grayBackgroundColor
        navigationItem.title = "Настройки"
        setupUI()
    }
    
    init(dataSource: SettingsDataSource) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//final class MockSettingsDataSource: SettingsDataSource {
//    init() {}
//
//    func getSettings() -> Settings {
//        Settings(gameTime: 2, speed: 3, isSubstrate: true)
//    }
//
//    func saveSettings(_ settings: Settings) {
//        //        datasource.gameTime = 1
//        //        speed = 2
//        //        isSubstrate = true
//        //
//    }
//}

//func saveGame() {
//    let frameView = self.colorView.frame
//    let colorView = self.colorView.backgroundColor?.cgColor.components
//    let colorTitle = self.colorView.getLabelTextColor().cgColor.components
//    let currentTime = self.totalTime
//    let title = self.colorView.getTitle()
//    let saveGa = Save(frame: frameView, viewColor: colorView!, isSubstrate: isSubstrate, time: currentTime, title: title)
//    dataSource.saveGame(saveGa)
//}
