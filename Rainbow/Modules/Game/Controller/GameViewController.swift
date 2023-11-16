//
//  GameViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Properties
    
    private var timer: Timer!
    private var viewTimer: Timer!
    private var totalTime = 60
    
    //MARK: - UI Elements
    
    private lazy var colorView = GameView()
    private lazy var speedButtonTitle = ["X1", "X2", "X3", "X4", "X5"]
    private lazy var valueTitle = 0
    private lazy var speedButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.frame = .zero
        btn.backgroundColor = .red
        btn.widthAnchor.constraint(equalToConstant: 75).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 73).isActive = true
        return btn
        
    }()
    
    //Get bounds size
    private lazy var mainViewHeight = Int(UIScreen.main.bounds.height) - Int(view.safeAreaInsets.bottom + view.safeAreaInsets.top + 40)
    private lazy var mainViewWidth = Int(UIScreen.main.bounds.width - 238)
    
    //Navigation bar button
    private lazy var rightBarButton = UIBarButtonItem(image: UIImage(systemName: "pause.fill"), style: .plain, target: self, action: #selector(pauseButtonTapped))
    private lazy var isPlaying = false
    
    //MARK: - Life cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "1:00"
        
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton

        //Call functions
        timeCount(totalTime)
        configureView()
        setupSpeedButton()
        colorViewTimer()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(self.view.safeAreaInsets)
        constranints()
        print(mainViewHeight)
    }
    
    //MARK: - Methods
    
    func configureView() {
        //Setup views
        self.view.backgroundColor = .grayBackgroundColor
        self.view.addSubviews(
            colorView,
            speedButton
        )
        colorView.addTarget(target: self, action: #selector(checkButtonTapped))
    }
    
    //MARK: - Private methods
    
    private func timeCount(_ time: Int) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { Timer in
            if self.totalTime > 0 {
                self.totalTime -= 1
                print(self.totalTime)
                self.navigationItem.title = self.formatTime(self.totalTime)
            } else {
                self.timer.invalidate()
            }
        }
    }
    
    private func setupSpeedButton() {
        //Speed button
        speedButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        speedButton.titleLabel?.textAlignment = .center
        speedButton.setTitle(speedButtonTitle[0], for: .normal)
        speedButton.layer.cornerRadius = 36
        speedButton.layer.shadowColor = UIColor.black.cgColor
        speedButton.layer.shadowOpacity = 0.8
        speedButton.layer.shadowOffset = CGSizeMake(0, 4)
        speedButton.layer.shadowRadius = 1
        speedButton.addTarget(self, action: #selector(speedButtonTapped), for: .touchUpInside)
    }
    
    private func getRandom() -> (CGFloat, CGFloat) {
        var height = CGFloat(Int.random(in: 50...mainViewHeight))
        var widht = CGFloat(Int.random(in: 0...mainViewWidth))
        if height >= 679 && widht >= 100 {
            widht = 60
            height = 640
        }
        print(height, widht)
        return (height, widht)
    }
    
   private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func colorViewTimer() {
        viewTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(toggleView), userInfo: nil, repeats: true)
    }
    
    //MARK: - @objc methods
    
    @objc func checkButtonTapped(_ sender: UIButton) {
        sender.currentImage == nil ? sender.setImage(UIImage(named: "check"), for: .normal) : sender.setImage(UIImage(named: " "), for: .normal)
    }
    
    @objc func pauseButtonTapped() {
        isPlaying.toggle()
        if isPlaying {
            rightBarButton.image = UIImage(systemName: "play.fill")
            timer.invalidate()
        } else {
            rightBarButton.image = UIImage(systemName: "pause.fill")
            timeCount(totalTime)
        }
    }
    
    @objc func speedButtonTapped() {
        switch valueTitle {
        case 0:
            speedButton.setTitle(speedButtonTitle[valueTitle], for: .normal)
            valueTitle += 1
        case 1:
            speedButton.setTitle(speedButtonTitle[valueTitle], for: .normal)
            valueTitle += 1
        case 2:
            speedButton.setTitle(speedButtonTitle[valueTitle], for: .normal)
            valueTitle += 1
        case 3:
            speedButton.setTitle(speedButtonTitle[valueTitle], for: .normal)
            valueTitle += 1
        case 4:
            speedButton.setTitle(speedButtonTitle[valueTitle], for: .normal)
            valueTitle = 0
        default:
            print("error")
        }
        
    }
    
    @objc func toggleView() {
        colorView.isHidden = !colorView.isHidden
    }
}

//MARK: - Extension

extension GameViewController {
    
    
    // Setup constraints
    private func constranints() {
        
        let (height, width) = getRandom()
        
        NSLayoutConstraint.activate([
            //First color view
            colorView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: height),
            colorView.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: width),
            colorView.heightAnchor.constraint(equalToConstant: 40),
            colorView.widthAnchor.constraint(equalToConstant: 238),
            
            //Second color view
            //            secondColorView.topAnchor.constraint(equalTo: firstColorView.bottomAnchor, constant: 60),
            //            secondColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            //            secondColorView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 119),
            //            secondColorView.heightAnchor.constraint(equalToConstant: 40),
            //            secondColorView.widthAnchor.constraint(equalToConstant: 238),
            //
            //            //Third color view
            //            thirdColorView.topAnchor.constraint(equalTo: secondColorView.bottomAnchor, constant: 95),
            //            thirdColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 68),
            //            thirdColorView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -102),
            //            thirdColorView.heightAnchor.constraint(equalToConstant: 40),
            //            thirdColorView.widthAnchor.constraint(equalToConstant: 238),
            //
            //            //Fourth color view
            //            fourthColorView.topAnchor.constraint(equalTo: thirdColorView.bottomAnchor, constant: 143),
            //            fourthColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -53),
            //            fourthColorView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            //            fourthColorView.heightAnchor.constraint(equalToConstant: 40),
            //            fourthColorView.widthAnchor.constraint(equalToConstant: 238),
            //
            //            //Fifth color view
            //            fifthColorView.topAnchor.constraint(equalTo: fourthColorView.topAnchor, constant: 103),
            //            fifthColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            //            fifthColorView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -140),
            //            fifthColorView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            //            fifthColorView.heightAnchor.constraint(equalToConstant: 40),
            //            fifthColorView.widthAnchor.constraint(equalToConstant: 238),
            
            //Speed button constaints
            speedButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            speedButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -34)
        ])
    }
}
