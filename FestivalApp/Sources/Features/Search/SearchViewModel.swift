//
//  SearchViewModel.swift
//  FestivalApp
//
//  Created by playhong on 2024/02/09.
//

import Foundation

final class SearchViewModel {
    private var api: FestivalAPI = FestivalAPI()
    private var nextPageNumber: Int = 1
    private(set) var isPaging: Bool = true
    private(set) var festivals: [Festival] = []
    
    func fetchDatasFromAPI(success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        api.execute { [weak self] result in
            switch result {
            case .success(let responseData):
                let festivals  = responseData.response.body.items.festivals
                self?.nextPageNumber += 1
                self?.festivals.append(contentsOf: festivals)
                success()
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func paging(success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        if isPaging {
            isPaging = false
            api.updatePage(nextPageNumber)
            fetchDatasFromAPI { [weak self] in
                self?.isPaging = true
                success()
            } failure: { error in
                failure(error)
            }
        }
    }
}
