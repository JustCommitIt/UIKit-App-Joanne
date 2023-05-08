//
//  ViewController.swift
//  TableView
//
//  Created by 김요한 on 2023/05/08.
//

import UIKit


// 테이블뷰를 사용할때는 꼭! UITableViewDataSource 프로토콜을 채택해야함
// UITableViewDataSource : 테이블뷰와 뷰컨트롤러 사이 의사소통하게 해주는. 어떤 정보를 표현할 것인지

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
//     무비를 담은 저장속성!
//    var moviesArray: [Movie] = []
    
    // MVC패턴을 위한 데이터 매니저 (배열 관리 - 데이터)
    var movieDataManager = DataManager()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupDatas()
        
        title = "영화목록"
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        // 무비 배열에 있는 데이터가 늘어나도록 아이템 추가
        movieDataManager.updateMovieData()
        
        // 아이템을 추가하고 반드시 reloadData() 꼭 호출해야함 ⭐️
        tableView.reloadData()
    }
    
    
    

    
    func setupTableView() {
        // 테이블뷰의 데이터소스 속성은 self야. 테이블뷰의 대리자는 데이터소스야! ⭐️테이블뷰 할떄 필수. 델리게이트 패턴의 대리자 설정
        tableView.dataSource = self // tableView.delegate = self와 동일한 역할. <.dataSource>로 해줘야함
        tableView.delegate = self
        
        tableView.rowHeight = 120 // 테이블뷰에서 쎌의 높이 <스토리보드에서 쎌의 높이를 지정해주어도 됨>
    }
    
    
    func setupDatas(){
        movieDataManager.makeMovieData() // 데이터매니져의 기본은 빈배열이고 후에 정보를 호출. 목데이터를 배열데이터에 넣는함수! 일반적으로 서버에 요청함.
//        moviesArray = movieDataManager.getMovieData() // 무비데이터메니져야..나 무비데이터내놔
    }
    
    
    
    
    
    
}








// 관습적으로 테이블뷰는 아래처럼 확장하여 사용을 함⭐️⭐️ 이 아래는 그냥 공식처럼 사용하면 됨 ⭐️
extension ViewController: UITableViewDataSource {
    
    // 📍1) 테이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return movieDataManager.getMovieData().count // 컨텐츠 무비배열 갯수만큼 표현할 꺼야! 일반적으로 이렇게 표현함!
    }
    
    
    // 📍2) 셀의 구성(셀에 표시하고자 하는 데이터 표시)을 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        // ⭐️ 셀을 꺼내서 쓸꺼야! 공식임.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell  // 무비쎌을 타입캐스팅하여 타입캐스팅된것을 할당해야함. 그래야 꺼내서 접근 가능함.
        
//        indexPath.section // 리스트내에서 그룹의 번호. 여기서는 섹션이 없음
//        indexPath.row // section내의 행 번호
        
        let movie = movieDataManager.getMovieData()[indexPath.row]
        // 영화정보 배열에 접근하여 서브스크립트 문법을 활용, 몇번째의 아이템을 꺼낼지!
        
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        cell.selectionStyle = .none
        
        return cell
    }
}


// 테이블뷰위에서 발생하는 사용할때 테이블뷰위에 터치/스크롤등이 발생하는것은 viewController에서 받고 일처리도 여기서함.
// UITableViewDelegate를 채택하면 애플이 미리 만들어둔 다양한 메서드를 활용하여 이벤트를 감지하여 전달 및 처리 가능함
extension ViewController: UITableViewDelegate {
    
    // 테이블뷰에서 가장 많이 사용할 메서드
    // 테이블뷰에서 터치 발생시 몇번째 쎌에서 터치가 발생되었는지 아래의 함수가 호출됨
    // 셀이 선택이 되었을때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 세그웨이를 통해 다음화면으로 이동하겠다!!
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    // prepare세그웨이(데이터 전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            let array = movieDataManager.getMovieData()
            let indexPath = sender as! IndexPath
            
            // 영화배열에서 몇번째인지 전달함
            detailVC.movieData = array[indexPath.row]
        }
    }
}
