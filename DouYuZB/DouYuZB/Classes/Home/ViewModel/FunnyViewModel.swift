//
//  FunnyViewModel.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/25.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {
    func loadFunnyData(finish: @escaping () -> ()) {
        loadGameData(isGroup: false, type: .GET, URLString: DYZBIP + DYHomeFunnyHttp, parameters: ["limit":"30","client_sys":"ios","offset":"0"], finish: finish)
    }
}
