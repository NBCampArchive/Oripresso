//
//  OnboardViewController.swift
//  Oripresso
//
//  Created by 박현렬 on 4/8/24.
//

import UIKit
import SnapKit
import Then

class OnboardViewController: UIViewController{
    let crewMembers = [
        CrewMember(image: "seunghyeon", name: "신승현"),
        CrewMember(image: "yurim", name: "김유림"),
        CrewMember(image: "sian", name: "이시안"),
        CrewMember(image: "slowgeon", name: "박충건"),
        CrewMember(image: "ryeol", name: "박현렬")
    ]
    let posts = [
        UIImage(named: "post2"),
        UIImage(named: "post3"),
        UIImage(named: "post4"),
        UIImage(named: "post1")
    ]
    
    @IBOutlet weak var crewCollectionView: UICollectionView!
    @IBOutlet weak var postCollectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    @IBAction func startButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MainView", bundle: nil)
        
        if let pushVC = storyboard.instantiateViewController(withIdentifier: "MainView") as? MainViewController {
            pushVC.navigationItem.title = ""
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleImage = UIImage(named: "title")
        self.navigationItem.titleView = UIImageView(image: titleImage)
        // 컬렉션 뷰의 델리게이트와 데이터 소스 설정
        crewCollectionView.delegate = self
        crewCollectionView.dataSource = self
        
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        
        setupCrewCollectionView()
        setupPostCollectionView()
    }
    func setupCrewCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 110, height: 110)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        crewCollectionView.collectionViewLayout = layout
        crewCollectionView.showsHorizontalScrollIndicator = false
    }
    func setupPostCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: postCollectionView.bounds.width, height: postCollectionView.bounds.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        postCollectionView.collectionViewLayout = layout
        postCollectionView.isPagingEnabled = true
        postCollectionView.showsHorizontalScrollIndicator = false
    }
}
extension OnboardViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 컬렉션 뷰에 따라 데이터 소스의 개수 반환
        if collectionView == crewCollectionView {
            return crewMembers.count
        } else {
            return posts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 컬렉션 뷰에 따라 셀 구성
        if collectionView == crewCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CrewCollectionCell", for: indexPath) as! CrewCollectionCell
            let member = crewMembers[indexPath.row]
            cell.setCell(image: member.image, name: member.name)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionCell", for: indexPath) as! PostCollectionCell
            cell.configure(with: posts[indexPath.row])
            return cell
        }
    }
}
