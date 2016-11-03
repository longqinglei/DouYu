//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/24.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{

}

extension AmuseViewModel {
    func loadAmuseData(finish : @escaping () -> ()) {
        loadGameData(isGroup: true, type: .GET, URLString: DYZBIP + DYHomeAmuseGameHttp, parameters: nil, finish: finish)
    }
}

