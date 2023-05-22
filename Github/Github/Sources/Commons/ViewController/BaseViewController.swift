//
//  BaseViewController.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//
import SnapKit
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Outlets
    lazy var navigationBar: StoneNavigationBar = {
        let navigation = StoneNavigationBar(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: self.view.safeAreaLayoutGuide.layoutFrame.width,
                                                          height: 64))
        return navigation
    }()
    
    // MARK: - Constants
    let loadingView = LoadingView()
    
    // MARK: - Init
    init(frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
        addSubviews()
        setConstraints()
        setNavigationBarActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setConstraints()
        setNavigationBarActions()
    }
    
    func addSubviews() {
        self.view.addSubview(navigationBar)
    }
    
    // MARK: - SetConstraints
    func setConstraints() {
        setNavigationBarConstraints()
    }
    
    private func setNavigationBarConstraints() {
        DispatchQueue.main.async {
            self.navigationBar.snp.remakeConstraints{ make in
                make.top.equalToSuperview().inset(Margin.getSafeAreas().top)
                make.leading.equalToSuperview().inset(Margin.getSafeAreas().left)
                make.trailing.equalToSuperview().inset(Margin.getSafeAreas().right)
                make.height.equalTo(NavBar.height)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.navigationBar.setDegradeBackgroundColor(invert: false)
        })
    }
    
    private func setNavigationBarActions() {
        self.navigationBar.actionLeftButton = didTapLeftButton
        self.navigationBar.actionRightButton = didTapRightButton
    }
    
    // MARK: - Loading
    func showLoading(_ loading: Bool) {        
        loadingView.loadSpinner(loading)
        loading ? self.view.addSubview(loadingView) : self.loadingView.removeFromSuperview()
    }
    
    // MARK: - Life cycle
    override func loadView() {
        let startView = UIView(frame: .zero)
        startView.backgroundColor = .white
        view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReachabilitySingleton.shared.checkInternetConnection()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    deinit {
         NotificationCenter.default.removeObserver(self)
    }
    
    @objc func rotated() {
        self.setNavigationBarConstraints()
    }
    
    // MARK: - Actions
    func didTapLeftButton() {}
    
    func didTapRightButton() {}
}
