import XCTest
@testable import PokeModels

final class PokeModelsTests: XCTestCase {
    func testPokemon() throws {
        guard let path = Bundle.module.url(forResource: "bulbasaur", withExtension: "json") else {
            XCTFail()
            return
        }
        let data = try Data(contentsOf: path)
        let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
        XCTAssertEqual(pokemon, bulbasaur)
    }
}

private extension PokeModelsTests {
    var bulbasaur: Pokemon {
        return Pokemon(id: 1,
                       name: "bulbasaur",
                       height: 7,
                       weight: 69,
                       abilities: [Ability(name: "overgrow"), Ability(name: "chlorophyll")],
                       sprites: Sprite(front: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
                       types: [PokeType(name: "grass"), PokeType(name: "poison")],
                       stats: [Stat(base: 45, name: "hp"),
                               Stat(base: 49, name: "attack"),
                               Stat(base: 49, name: "defense"),
                               Stat(base: 65, name: "special-attack"),
                               Stat(base: 65, name: "special-defense"),
                               Stat(base: 45, name: "speed")])
    }
}
