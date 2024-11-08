import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CustomTabBar로 탭바 교체
        let customTabBar = CustomTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
        
        self.setViewControllers(configureTabBars(), animated: true)
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private class CustomTabBar: UITabBar {
        var customHeight: CGFloat = 96
        
        override var intrinsicContentSize: CGSize {
            var size = super.intrinsicContentSize
            size.height = customHeight
            return size
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // 탭바의 frame을 직접 설정
            var newFrame = self.frame
            newFrame.size.height = customHeight
            newFrame.origin.y = self.superview!.frame.height - customHeight
            self.frame = newFrame
        }
    }
    
    private func configureTabBars() -> [UIViewController] {
        let matchingVC = MatchingViewController()
        matchingVC.view.backgroundColor = .white
        matchingVC.tabBarItem = UITabBarItem(title: "산책 구하기", image: UIImage(named: "MatchingApplyProcedureIcon"), tag: 0)
        
        let matchingStateVC = UIViewController()
        matchingStateVC.view.backgroundColor = .white
        matchingStateVC.tabBarItem = UITabBarItem(title: "매칭 현황", image: UIImage(named: "MatchingStateIcon"), tag: 1)
        
        let talkVC = UIViewController()
        talkVC.view.backgroundColor = .white
        talkVC.tabBarItem = UITabBarItem(title: "워크톡", image: UIImage(named: "WalkMongTalkIcon"), tag: 2)
        
        let mypageVC = UIViewController()
        mypageVC.view.backgroundColor = .white
        mypageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "MypageIcon"), tag: 3)
        
        return [matchingVC, matchingStateVC, talkVC, mypageVC]
    }
    
    private func setUI() {
        // 배경 색상 설정
        tabBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        tabBar.tintColor = UIColor(red: 0.081, green: 0.081, blue: 0.076, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.719, green: 0.737, blue: 0.761, alpha: 1)
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        // 블러 효과 추가
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.9 // 블러 효과 강도 조절 (피그마에서 50%로 설정)
        blurEffectView.frame = tabBar.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 블러 뷰를 탭바에 추가
        tabBar.insertSubview(blurEffectView, at: 0)

        // 상단에 경계선 추가
        let border = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1))
        border.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
        tabBar.addSubview(border)
    }
}
