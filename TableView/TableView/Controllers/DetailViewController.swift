//
//  DetailViewController.swift
//  TableView
//
//  Created by 김요한 on 2023/05/08.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // 전화면에서 Movie 데이터를 전달받기 위한 변수
    var movieData: Movie?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    

    func setupUI() {
        mainImageView.image = movieData?.movieImage
        movieNameLabel.text = movieData?.movieName
        descriptionLabel.text = movieData?.movieDescription
    }

}
