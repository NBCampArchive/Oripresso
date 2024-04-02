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
    
    func animateReceipt() {
        // 초기 상태 설정: receipt 이미지뷰를 아래로 숨김
        receipt.transform = CGAffineTransform(translationX: 0, y: -self.receipt.frame.height/10)
        receipt.alpha = 0 // 초기 opacity를 0으로 설정
        
        // 애니메이션 적용
        UIView.animate(withDuration: 1.6, delay: 0.0, options: [.curveEaseOut], animations: {
            // 애니메이션 처리: receipt 이미지뷰를 원래 위치로 이동하면서 opacity를 1로 변경
            self.receipt.transform = .identity
            self.receipt.alpha = 1 // 최종 opacity
        }, completion: nil)
    }
    
    func animatebutton() {
        // 초기 상태 설정: moveToMain 버튼을 아래로 숨김
        moveToMain.transform = CGAffineTransform(translationX: 0, y: -self.receipt.frame.height/10) // receipt 이미지뷰와 동일한 위치로 설정
        moveToMain.alpha = 0 // 초기 opacity를 0으로 설정
        
        // 애니메이션 적용
        UIView.animate(withDuration: 1.6, delay: 0.0, options: [.curveEaseOut], animations: {
            // 애니메이션 처리: moveToMain 버튼을 원래 위치로 이동하면서 opacity를 1로 변경
            self.moveToMain.transform = .identity
            self.moveToMain.alpha = 1 // 최종 opacity
        }, completion: nil)
    }
}
