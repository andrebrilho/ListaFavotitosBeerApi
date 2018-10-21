//
//  BeerApi.swift
//  BeerApi
//
//  Created by André Brilho on 07/08/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import Foundation

class BeersApi {
    
    static func fetchBeers(refresh:Bool, sucess: @escaping ([Beer]) -> Void, failure: @escaping(Error) -> Void) {
        let url = URL(string: Constantes.URLBASE)
        if !refresh {
            let beersRealm = AppDelegate.realmBeerBD.objects(Beer.self).sorted(byKeyPath: "name")
            if !beersRealm.isEmpty {
                var beers = [Beer]()
                for beer in beersRealm {
                    beers.append(beer)
                }
                print("carregando beers do BD")
                sucess(beers)
                return
            }
        }
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    var beers = try JSONDecoder().decode([Beer].self, from: data).sorted(by: { (beer1, beer2) -> Bool in
                        return beer1.name < beer2.name
                    })
                    DispatchQueue.main.async {
                        do {
                            var beersToInsert = [Beer]()
                            var beersCount = beers.count
                            for i in 0..<beersCount {
                                print("Removendo item primaryKey")
                                let beer = beers[i]
                                if let beerRealm = AppDelegate.realmBeerBD.object(ofType: Beer.self, forPrimaryKey: beer.id){
                                    beers[i] = beerRealm
                                }else {
                                    print("persistindo Item no BD")
                                    beersToInsert.append(beer)
                                }
                            }
                            print("salvando dados no BD")
                            AppDelegate.realmBeerBD.beginWrite()
                            AppDelegate.realmBeerBD.add(beersToInsert)
                            try
                                AppDelegate.realmBeerBD.commitWrite()
                            sucess(beers)
                        }catch {
                            print("erro ao salvar BD")
                        }
                    }
                }catch{
                    print("erro decode json")
                    failure(error)
                }
            }else{
                print("erro ao acessar data")
            }
            }
            .resume()
    }
}
