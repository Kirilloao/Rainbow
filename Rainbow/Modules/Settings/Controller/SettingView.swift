//
//  SettingCell.swift
//  Rainbow
//
//  Created by Anna Zaitsava on 15.11.23.
//

import UIKit


class SettingView: UIView {
    
    private var label = UILabel()
    private var control: UIControl?
    
    init(labelText: String) {
        label = UILabel()
        super.init(frame: .zero)
        setupView()
        addLabel(withText: labelText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 298),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 66)
        ])
    }
    
    func addLabel(withText text: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        addSubviews(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
    
    func addControl(_ control: UIControl) {
        control.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(control)
        
        NSLayoutConstraint.activate([
            
            label.widthAnchor.constraint(lessThanOrEqualToConstant: 133),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            control.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            control.centerYAnchor.constraint(equalTo: centerYAnchor),
            control.widthAnchor.constraint(lessThanOrEqualToConstant: 110)
        ])
        
        self.control = control
    }
        
    func addSlider(_ slider: UIControl) {
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .orange
        
        var valueLabel = UILabel()
        valueLabel.text = "0"
        
        addSubviews(slider)
        addSubviews(valueLabel)
        
        NSLayoutConstraint.activate([
            
            label.widthAnchor.constraint(lessThanOrEqualToConstant: 133),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            slider.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -8),
            slider.centerYAnchor.constraint(equalTo: centerYAnchor),
            slider.widthAnchor.constraint(equalToConstant: 110)
            
        ])
        
        self.control = slider
    }
    
    func addSegmentedControl(titles: [String], defaultSelectedIndex: Int) {
        let segmentedControl = UISegmentedControl(items: titles)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = defaultSelectedIndex
        
        addSubviews(segmentedControl)
        label.numberOfLines = 1
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            segmentedControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        control = segmentedControl
    }
    
    func addColorButtons(colors: [UIColor]) {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5

        addSubviews(stackView)

        var rowStackView: UIStackView?
        
        for (index, color) in colors.enumerated() {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = color
            button.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)

            let widthConstraint = button.widthAnchor.constraint(equalToConstant: 25)
            let heightConstraint = button.heightAnchor.constraint(equalToConstant: 25)

            NSLayoutConstraint.activate([
                widthConstraint,
                heightConstraint,
            ])

            if index % 6 == 0 {
                rowStackView = UIStackView()
                rowStackView?.translatesAutoresizingMaskIntoConstraints = false
                rowStackView?.axis = .horizontal
                rowStackView?.spacing = 5

                stackView.addArrangedSubview(rowStackView!)
            }

            rowStackView?.addArrangedSubview(button)
        }

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

        @objc private func colorButtonTapped(_ sender: UIButton) {
    
        }
    }


