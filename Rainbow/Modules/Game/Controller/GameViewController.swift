//
//  GameViewController.swift
//  Rainbow
//
//  Created by Nikita on 14.11.2023.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var dataSource: GameDataSource
    private var colorView: GameView!
    private var storage = Storage()
    private var timer: Timer!
    private var viewTimer: Timer!
    private var totalTime = 0
    private var initialTime = 0
    private var speedGame = 0
    private var isSubstrate = true
    private var isResume = false
    private var isFirstLayout = true
    private let maxSpeedGame = 5
    private let colorViewHeight: CGFloat = 40
    private let colorViewWidth: CGFloat = 238
    private let speedButtonHeight: CGFloat = 73
    private let speedButtonWidth: CGFloat = 75
    
    //MARK: - UI Elements
    
    private lazy var speedButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.frame = .zero
        btn.backgroundColor = .red
        btn.widthAnchor.constraint(equalToConstant: speedButtonWidth).isActive = true
        btn.heightAnchor.constraint(equalToConstant: speedButtonHeight).isActive = true
        return btn
    }()
    
    //Get bounds size
    private lazy var mainViewHeight = Int(UIScreen.main.bounds.height) - Int(view.safeAreaInsets.bottom + colorViewHeight)
    private lazy var mainViewWidth = Int(UIScreen.main.bounds.width - colorViewWidth - 6)
    
    //Navigation bar button
    private lazy var rightBarButton = UIBarButtonItem(image: UIImage(systemName: "pause.fill"), style: .plain, target: self, action: #selector(pauseButtonTapped))
    private lazy var isPlaying = false
    
    
    init(dataSource: GameDataSource, resume: Bool = false) {
        self.dataSource = dataSource
        let settings = dataSource.getSettings()
        self.isResume = resume
        if resume, let savedGame = dataSource.getGame() {
            self.totalTime = savedGame.time
            self.isSubstrate = savedGame.isSubstrate
            self.speedGame = savedGame.speedGame
            self.colorView = GameView(isSubstrate: settings.isBackgroundNeed)
            self.initialTime = Int(settings.gameTime)
        } else {
            self.totalTime = Int(dataSource.getSettings().gameTime)
            self.speedGame = settings.speed
            self.isSubstrate = settings.isBackgroundNeed
            self.colorView = GameView(isSubstrate: settings.isBackgroundNeed)
            self.initialTime = totalTime
        }
        dataSource.deleteSavedGames()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = formatTime(totalTime)
        
        //Call functions
        timeCount(totalTime)
        configureView()
        setupSpeedButton()
        colorViewTimer()
        constraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
        viewTimer.invalidate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveGame()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard isFirstLayout else { return }
        isFirstLayout = false
        
        //Check saved games
        if isResume, let game = dataSource.getGame() {
            colorView.frame = game.frame
        } else {
            let (height, width) = getRandom()
            colorView.frame = CGRect(x: width, y: height, width: colorViewWidth, height: colorViewHeight)
        }
        colorView.translatesAutoresizingMaskIntoConstraints = true
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
        var color: UIColor? = nil
        var title: String? = nil
        if isResume, let game = dataSource.getGame() {
            color = UIColor(red: game.viewColor[0], green: game.viewColor[1] , blue: game.viewColor[2], alpha: game.viewColor[3])
            title = game.title
        } else {
            title = storage.viewsTitle.randomElement()
            guard let uiColor = dataSource.getSettings().buttonColors.randomElement() else { return }
            color = UIColor(red: uiColor[0], green: uiColor[1], blue: uiColor[2], alpha: uiColor[3])
        }
        guard let color = color else { return }
        guard let title = title else { return }
        colorView.changeColorsAndTitle(color: color, title: title)
    }
    
    func saveGame() {
        guard totalTime > 0 else { return }
        let frameView = self.colorView.frame
        let colorView = self.colorView.backgroundColor?.cgColor.components
        let currentTime = self.totalTime
        let speedGame = self.speedGame
        let title = self.colorView.getTitle()
        let saveGame = Save(frame: frameView, viewColor: colorView!, isSubstrate: isSubstrate, speedGame: speedGame, time: currentTime, title: title)
        dataSource.saveGame(saveGame)
    }
    
    //MARK: - Private methods
    
    private func timeCount(_ time: Int) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] Timer in
            if self.totalTime > 0 {
                self.totalTime -= 1
                print(self.totalTime)
                self.navigationItem.title = self.formatTime(self.totalTime)
            } else {
                self.timer.invalidate()
                self.viewTimer.invalidate()
                let currentGame = ResultsCardModel(gameId: dataSource.count + 1, seconds: initialTime, speedRate: maxSpeedGame / speedGame, rightCount: 10, totalCount: 20)
                dataSource.addGame(currentGame)
                dataSource.deleteSavedGames()
                let resultsModel = ResultsModel(dataSource: dataSource)
                let vc = ResultsViewController(model: resultsModel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    private func setupSpeedButton() {
        //Speed button
        speedButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        speedButton.titleLabel?.textAlignment = .center
        speedButton.setTitle("X\(maxSpeedGame - speedGame + 1)", for: .normal)
        speedButton.layer.cornerRadius = 36
        speedButton.layer.shadowColor = UIColor.black.cgColor
        speedButton.layer.shadowOpacity = 0.8
        speedButton.layer.shadowOffset = CGSizeMake(0, 4)
        speedButton.layer.shadowRadius = 1
        speedButton.addTarget(self, action: #selector(speedButtonTapped), for: .touchUpInside)
    }
    
    private func getRandom() -> (CGFloat, CGFloat) {
        var height = CGFloat(Int.random(in: Int(view.safeAreaInsets.top)...mainViewHeight))
        var width = CGFloat(Int.random(in: Int(view.safeAreaInsets.left + 6)...mainViewWidth))
        let heightDifference = UIScreen.main.bounds.height - view.safeAreaInsets.top - speedButtonHeight
        let widthDifference = UIScreen.main.bounds.width - colorViewWidth - speedButtonWidth
    
        if height >= heightDifference && width >= widthDifference {
            height = heightDifference
            width = widthDifference
        }
        return (height, width)
    }
    
    private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func colorViewTimer() {
        viewTimer = Timer.scheduledTimer(timeInterval: TimeInterval(speedGame), target: self, selector: #selector(toggleView), userInfo: nil, repeats: true)
    }
    
    private func changeViewTimer() {
        viewTimer.invalidate()
        colorViewTimer()
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
        switch speedGame {
        case (2...5):
            self.speedGame -= 1
        case 1:
            self.speedGame = self.maxSpeedGame
        default:
            print("error")
        }
        speedButton.setTitle("X\(maxSpeedGame - speedGame + 1)", for: .normal)
        self.changeViewTimer()
    }
    
    @objc func toggleView() {
        let (height, width) = getRandom()
        print(height, width)
        colorView.frame = CGRect(x: width, y: height, width: colorViewWidth, height: colorViewHeight)
        guard let title = storage.viewsTitle.randomElement() else { return }
       
        guard let uiColor = dataSource.getSettings().buttonColors.randomElement() else { return }
        let color = UIColor(red: uiColor[0], green: uiColor[1], blue: uiColor[2], alpha: uiColor[3])
        colorView.changeColorsAndTitle(color: color, title: title)
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
