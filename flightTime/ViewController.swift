//
//  ViewController.swift
//  flightTime
//
//  Created by Satendra Pal Singh on 05/02/1943 Saka.
//

import UIKit
class ViewController: UIViewController {

    private var data: [Data]?
    private var dataUpdate: UpdateData?
    
    @IBOutlet weak var tv_custom: UITableView!
        func simplaeques(){

        let queue = DispatchQueue(label: "queue", attributes: [.concurrent])

        queue.async {
            NetworkManager().airLineDataUpdate(data: self.data!) { [weak self] (dataUpdate) in
                  self?.dataUpdate = dataUpdate
                  DispatchQueue.main.async {
                    
                    for _ in self!.data!{
                        if let photoIndex = self?.data!.firstIndex(where: { $0.flight_number == dataUpdate.flight_number}) {
                            self?.data?[photoIndex].stops = dataUpdate.seats
                               }
                    }
                    self?.tv_custom.reloadData()
                  }
                }
        }

        }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tv_custom.dataSource = self
        tv_custom.delegate = self
        self.tv_custom.backgroundColor = UIColor.lightGray
        
        NetworkManager().airLineData { [weak self] (data) in
              self?.data = data
              DispatchQueue.main.async {
                self?.tv_custom.reloadData()
              }
            }
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            self.simplaeques()
        }
    }

   
}


extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celll =  tv_custom.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! CusTableViewCell
        
        let dataa = data?[indexPath.row]
        celll.flightNmae.text = dataa?.flight_number
        celll.stops.text = String(dataa?.stops ?? 0).appending(" Stops")
            
        return celll
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ViewController : UITableViewDelegate{}


