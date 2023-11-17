//
//  GameViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var appState = AppState.shared
    private var colorView: GameView!
    private var storage = Storage()
    private var timer: Timer!
    private var viewTimer: Timer!
    private var totalTime = 0
    private var speedGame = 0
    private var letterColor = true
    
    //MARK: - UI Elements
    
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
    
    init() {
        let settings = AppState.shared.getSettings()
        self.totalTime = 60 * settings.gameTime
        self.speedGame = settings.speed
        self.letterColor = settings.isSubstrate
        self.colorView = GameView(letterColor: settings.isSubstrate)
        super.init(nibName: nil, bundle: nil)
    }
    
    init(appState: AppState = AppState.shared, timer: Timer!, viewTimer: Timer!, totalTime: Int = 0) {
        super.init(nibName: nil, bundle: nil)
        self.appState = appState
        self.timer = timer
        self.viewTimer = viewTimer
        self.totalTime = totalTime
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "1:00"
        
        //Call functions
        timeCount(totalTime)
        configureView()
        setupSpeedButton()
        colorViewTimer()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        constraints()
        let (height, width) = getRandom()
        print(height, width)
        colorView.frame = CGRect(x: width, y: height, width: 238, height: 40)
        colorView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
        viewTimer.invalidate()
    }
    
    //MARK: - Methods
    
    func configureView() {
        //Setup views
        self.view.backgroundColor = .grayBackgroundColor
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
        self.view.addSubviews(
            colorView,
            speedButton
        )
        colorView.addTarget(target: self, action: #selector(checkButtonTapped))
        guard let title = storage.viewsTitle.randomElement() else { return }
        guard let backColor = storage.viewsColor.randomElement() else { return }
        guard let textColor = storage.viewsColor.randomElement() else { return }
        colorView.changeColorsAndTitle(backColor: backColor, textColor: textColor, title: title)
    }
    
    //MARK: - Private methods
    
    private func timeCount(_ time: Int) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { Timer in
            if self.totalTime > 0 {
                self.totalTime -= 1
                print(self.totalTime)
                self.navigationItem.title = self.formatTime(self.totalTime)
            } else {
                self.timer.invalidate()
                self.viewTimer.invalidate()
            }
        }
    }
    
    private func setupSpeedButton() {
        //Speed button
        speedButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        speedButton.titleLabel?.textAlignment = .center
        speedButton.setTitle(storage.speedButtonTitle[0], for: .normal)
        speedButton.layer.cornerRadius = 36
        speedButton.layer.shadowColor = UIColor.black.cgColor
        speedButton.layer.shadowOpacity = 0.8
        speedButton.layer.shadowOffset = CGSizeMake(0, 4)
        speedButton.layer.shadowRadius = 1
        speedButton.addTarget(self, action: #selector(speedButtonTapped), for: .touchUpInside)
    }
    
    private func getRandom() -> (CGFloat, CGFloat) {
        var height = CGFloat(Int.random(in: Int(view.safeAreaInsets.top)...mainViewHeight))
        var widht = CGFloat(Int.random(in: Int(view.safeAreaInsets.left)...mainViewWidth))
        let heightDifference = UIScreen.main.bounds.height - view.safeAreaInsets.bottom - 73
        let widhtDifference = UIScreen.main.bounds.width - 313
        if height >= heightDifference && widht >= widhtDifference {
            widht = widhtDifference
            height = heightDifference
        }
        return (height, widht)
    }
    
    private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func colorViewTimer() {
        viewTimer = Timer.scheduledTimer(timeInterval: TimeInterval(speedGame), target: self, selector: #selector(toggleView), userInfo: nil, repeats: true)
    }
    
    
    //MARK: - @objc methods
    
    @objc func checkButtonTapped(_ sender: UIButton) {
        sender.currentImage == nil ? sender.setImage(UIImage(named: "check"), for: .normal) : sender.setImage(UIImage(named: " "), for: .normal)
    }
    
    @objc func pauseButtonTapped() {
        isPlaying.toggle()
        if !isPlaying {
            rightBarButton.image = UIImage(systemName: "pause.fill")
            timeCount(totalTime)
            self.colorViewTimer()
        } else {
            rightBarButton.image = UIImage(systemName: "play.fill")
            timer.invalidate()
            viewTimer.invalidate()
        }
    }
    
    @objc func speedButtonTapped() {
        switch self.storage.valueTitle {
        case 0:
            speedButton.setTitle(self.storage.speedButtonTitle[self.storage.valueTitle], for: .normal)
            self.storage.valueTitle += 1
        case 1:
            speedButton.setTitle(self.storage.speedButtonTitle[self.storage.valueTitle], for: .normal)
            self.storage.valueTitle += 1
        case 2:
            speedButton.setTitle(self.storage.speedButtonTitle[self.storage.valueTitle], for: .normal)
            self.storage.valueTitle += 1
        case 3:
            speedButton.setTitle(self.storage.speedButtonTitle[self.storage.valueTitle], for: .normal)
            self.storage.valueTitle += 1
        case 4:
            speedButton.setTitle(self.storage.speedButtonTitle[self.storage.valueTitle], for: .normal)
            self.storage.valueTitle = 0
        default:
            print("error")
        }
    }
    
    @objc func toggleView() {
        let (height, width) = getRandom()
        print(height, width)
        colorView.frame = CGRect(x: width, y: height, width: 238, height: 40)
        guard let title = storage.viewsTitle.randomElement() else { return }
        guard let backColor = storage.viewsColor.randomElement() else { return }
        guard let textColor = storage.viewsColor.randomElement() else { return }
        colorView.changeColorsAndTitle(backColor: backColor, textColor: textColor, title: title)
    }
}

//MARK: - Extension

extension GameViewController {
    
    // Setup constraints
    private func constraints() {
        
        NSLayoutConstraint.activate([
            //Speed button constaints

            speedButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            speedButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -34)
        ])
    }
}
