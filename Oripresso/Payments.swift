//
//  Payments.swift
//  Oripresso
//
//  Created by 이시안 on 4/1/24.
//

import Foundation
import UIKit

class Payments: ViewController {
    
    @IBOutlet weak var receipt: UIImageView!
    @IBOutlet weak var moveToMain: UIButton!
    @IBOutlet weak var underStatus: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateReceipt()
        animatebutton()
    }
    
    //중간쯤부터 보이기 시작하면서 내려오는 애니메이션 의도
    func animateReceipt() {
        // 초기 상태 설정: receipt 이미지뷰의 위치를 이동시킴. 원래 높이에서 1/10 만큼 위로 이동 , opacity는 0.
        receipt.transform = CGAffineTransform(translationX: 0, y: -self.receipt.frame.height/10)
        receipt.alpha = 0
        
        // 애니메이션 적용
        // 애니메이션 처리: receipt 이미지뷰를 원래 위치로 이동하면서 opacity를 1로 변경. 속도는 1.6, 딜레이 0.7, ease-out 애니메이션(점점 느려지기) 사용
        // 애니메이션 끝나면 이후 동작 없음
        UIView.animate(withDuration: 1.55, delay: 0.7, options: [.curveEaseOut], animations: {
            self.receipt.transform = .identity
            self.receipt.alpha = 1
        }, completion: nil)
    }
    
    //메인화면 이동 버튼도 동일하게 적용
    func animatebutton() {
        moveToMain.transform = CGAffineTransform(translationX: 0, y: -self.receipt.frame.height/10)
        moveToMain.alpha = 0
        
        UIView.animate(withDuration: 1.55, delay: 0.7, options: [.curveEaseOut], animations: {
            self.moveToMain.transform = .identity
            self.moveToMain.alpha = 1
        }, completion: nil)
    }
}
