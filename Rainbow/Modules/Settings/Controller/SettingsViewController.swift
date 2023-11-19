//
//  SettingsViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let dataSource: SettingsDataSource
    private var gameTimeValue: Float = 2
    private var speedTimeValue = 5
    private var gameTimeSliderValue: Float = 2
    private var speedTimeSliderValue: Float = 5
    private var selectedColors: [UIColor] = []
    private var isSubstrate = true
    private var lettersBackgroundEnabled = true
    private var fontSize = CGFloat(15)
    private var bgColor = UIColor.grayBackgroundColor
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var timeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var speedValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gameTimeView: SettingView = {
        let view = SettingView(labelText: "время игры")
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.tintColor = .orange
        slider.value = self.gameTimeValue
        
        self.timeValueLabel.text = "\(Int(self.gameTimeValue))"
        
        slider.addTarget(self, action: #selector(gameTimeSliderValueChanged(_:)), for: .valueChanged)
        
        view.addSubviews(slider, self.timeValueLabel)
        
        NSLayoutConstraint.activate([
            self.timeValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.timeValueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.timeValueLabel.widthAnchor.constraint(equalToConstant: 36),
            
            slider.trailingAnchor.constraint(equalTo: self.timeValueLabel.leadingAnchor, constant: -8),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.widthAnchor.constraint(equalToConstant: 110)
        ])
        
        return view
    }()
    
    @objc private func gameTimeSliderValueChanged(_ sender: UISlider) {
//        let value = Int(sender.value)
        self.gameTimeValue = sender.value
//        gameTimeValue = Float(value)
        updateTimeLabel()
    }
    
    private func updateTimeLabel() {
        self.timeValueLabel.text = "\(Int(gameTimeValue))"
    }
    
    private lazy var speedTimeView: SettingView = {
        let view = SettingView(labelText: "скорость смены заданий, сек")
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.tintColor = .orange
        slider.value = self.speedTimeSliderValue
        
        slider.addTarget(self, action: #selector(speedTimeSliderValueChanged(_:)), for: .valueChanged)
        
        self.speedValueLabel.text = "\(speedTimeValue)"
        view.addSubviews(slider,self.speedValueLabel)
        
        NSLayoutConstraint.activate([
            self.speedValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.speedValueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.speedValueLabel.widthAnchor.constraint(equalToConstant: 36),
            
            slider.trailingAnchor.constraint(equalTo: self.speedValueLabel.leadingAnchor, constant: -8),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.widthAnchor.constraint(equalToConstant: 110)
        ])
        return view
    }()
    
    @objc private func speedTimeSliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        self.speedTimeSliderValue = sender.value
        speedTimeValue = value
        updateSpeedLabel()
    }
    
    private func updateSpeedLabel() {
        self.speedValueLabel.text = "\(speedTimeValue)"
    }
    
    private lazy var witchCheckView: SettingView = {
        let view = SettingView(labelText: "игра с проверкой заданий")
        let control = UISwitch()
        control.isOn = isSubstrate
        control.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        view.addSubviews(control)
        
        NSLayoutConstraint.activate([
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            control.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            control.widthAnchor.constraint(equalToConstant: 57)
        ])
        return view
    }()
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        isSubstrate = sender.isOn
        print("Switch value changed: \(isSubstrate)")
    }
    
    private lazy var buttonStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        
        var rowStackView: UIStackView?
        
        for (index, color) in dataSource.colors.enumerated() {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = color
            
            let checkmarkView = UIImageView(image: UIImage(systemName: "checkmark"))
            checkmarkView.tintColor = .white
            checkmarkView.isHidden = !selectedColors.contains(where: { $0.cgColor.components == color.cgColor.components })
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
                if let index = selectedColors.firstIndex(where: { $0.cgColor.components == sender.backgroundColor?.cgColor.components }) {
                    print("remove")
                    selectedColors.remove(at: index)
                } else if let color = sender.backgroundColor {
                    print("append")
                    selectedColors.append(color)
                }
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
        let stepperLabel = UILabel(text: "Aa",font: .systemFont(ofSize: fontSize), color: .black)
        stepperLabel.text = "Aa"
        let stepper = UIStepper()
        stepper.minimumValue = 15
        stepper.maximumValue = 20
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
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
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        fontSize = CGFloat(sender.value)
    }
    
    private lazy var letterBackgroundView: SettingView = {
        let view = SettingView(labelText: "подложка для букв")
        let control = UISwitch()
        control.isOn = lettersBackgroundEnabled
        control.addTarget(self, action: #selector(letterBackgroundValueChanged(_:)), for: .valueChanged)
        
        view.addSubviews(control)
        
        NSLayoutConstraint.activate([
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            control.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            control.widthAnchor.constraint(equalToConstant: 57)
        ])
        return view
    }()
    
    @objc private func letterBackgroundValueChanged(_ sender: UISwitch) {
        lettersBackgroundEnabled = sender.isOn
        print("Switch value changed: \(lettersBackgroundEnabled)")
    }
    
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
        switch sender.selectedSegmentIndex {
        case 0:
            bgColor = .grayBackgroundColor
        case 1:
            bgColor = .white
        case 2:
            bgColor = .black
        default:
            return
        }
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
        
    }
    
    func saveSettings() {
        let gameTime = Int(gameTimeValue) * 60
        let speed = speedTimeValue
        let isSubstruct = isSubstrate
        let time = gameTimeSliderValue
        let speedTime = speedTimeSliderValue
        let bg = lettersBackgroundEnabled
        let bgColor = bgColor.cgColor.components
        let buttonColors: [[CGFloat]] = selectedColors.compactMap { $0.cgColor.components }
        print("†† \(buttonColors)")
        let settings = Settings(gameTime: gameTime, gameTimeValueSlider: time,speedTimeValueSlider: speedTime, speed: speed, isSubstrate: isSubstruct, isBackgroundNeed: bg, backgroundColor: bgColor!, buttonColors: buttonColors)
        dataSource.saveSettings(settings)
        
        print(settings)
    }
    
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
            wordsPosition.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor
        navigationItem.title = "Настройки"
        setupUI()
    }
    
    init(dataSource: SettingsDataSource) {
        self.dataSource = dataSource
        let settings = dataSource.getSettings()
        self.gameTimeValue = Float(settings.gameTime / 60)
        self.gameTimeSliderValue = settings.gameTimeValueSlider
        self.speedTimeSliderValue = settings.speedTimeValueSlider
        self.speedTimeValue = settings.speed
        self.isSubstrate = settings.isSubstrate
        self.lettersBackgroundEnabled = settings.isBackgroundNeed
        self.bgColor = UIColor(red: settings.backgroundColor[0], green: settings.backgroundColor[1], blue: settings.backgroundColor[2], alpha: settings.backgroundColor[3])
        self.selectedColors = settings.buttonColors.map({ color in
            UIColor(red: color[0], green: color[1], blue: color[2], alpha: color[3])
        })
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveSettings()
    }
}






