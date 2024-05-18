//
//  UserModifyViewController.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/17/24.
//

import UIKit
import SwiftUI

class UserModifyViewController: UIViewController {

    let userModifyView = UserModifyView()
    private let titleLabel = UILabel().then {
        $0.text = "프로필 수정"
        $0.font = UIFont.pretendard(size: 17, weight: .bold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = self.userModifyView
        self.navigationItem.titleView = titleLabel
    }
    


}

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let vc: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return vc
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(vc: self)
    }
}

#if DEBUG
struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UserModifyViewController()
            .toPreview()
    }
}
#endif

