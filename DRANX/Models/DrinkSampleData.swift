import Foundation

enum DrinkSampleData {
    static let cards: [DrinkCard] = [
        makersMark, hendricks, caymusCab, barolo, rusteakMule
    ]

    // MARK: Spirits

    static let makersMark = DrinkCard(
        name: "Maker's Mark Bourbon",
        category: .spirit,
        producer: "Maker's Mark Distillery",
        description: "A wheat-forward Kentucky straight bourbon. Soft, approachable, and unmistakably dipped in red wax. The wheat replaces rye in the mash bill, giving it a sweeter, rounder character.",
        origin: Origin(
            country: "USA",
            region: "Kentucky",
            locality: "Loretto",
            latitude: 37.6368,
            longitude: -85.4030
        ),
        abv: 45.0,
        tastingNotes: ["caramel", "vanilla", "wheat", "dried fruit", "oak"],
        tags: ["bourbon", "american whiskey", "kentucky"]
    )

    static let hendricks = DrinkCard(
        name: "Hendrick's Gin",
        category: .spirit,
        producer: "William Grant & Sons",
        description: "Distilled in small batches in Girvan, Scotland. Cucumber and rose petal are infused after distillation — a deliberately unusual gin that sparked a movement.",
        origin: Origin(
            country: "Scotland",
            region: "South Ayrshire",
            locality: "Girvan",
            latitude: 55.2352,
            longitude: -4.8560
        ),
        abv: 44.0,
        tastingNotes: ["cucumber", "rose", "juniper", "citrus peel", "elderflower"],
        tags: ["gin", "scottish", "floral"]
    )

    // MARK: Wine

    static let caymusCab = DrinkCard(
        name: "Caymus Napa Valley Cabernet",
        category: .wine,
        producer: "Caymus Vineyards",
        description: "A benchmark California Cabernet. Rich, plush, and fruit-forward with a famously accessible style. The Wagner family has been crafting it in Rutherford since 1972.",
        origin: Origin(
            country: "USA",
            region: "Napa Valley",
            locality: "Rutherford",
            latitude: 38.4574,
            longitude: -122.4102
        ),
        vintage: 2021,
        abv: 14.6,
        tastingNotes: ["blackberry", "cassis", "chocolate", "vanilla", "cedar"],
        tags: ["cabernet sauvignon", "napa valley", "california", "red wine"]
    )

    static let barolo = DrinkCard(
        name: "Barolo DOCG",
        category: .wine,
        producer: "Marchesi di Barolo",
        description: "The King of Italian wines. Made entirely from Nebbiolo in the Langhe hills of Piedmont. Austere in youth, it unfolds over decades into something profound — tar, roses, and faded grandeur.",
        origin: Origin(
            country: "Italy",
            region: "Piedmont",
            locality: "Barolo",
            latitude: 44.6117,
            longitude: 7.9456
        ),
        vintage: 2018,
        abv: 14.0,
        tastingNotes: ["cherry", "tar", "roses", "leather", "tobacco", "anise"],
        tags: ["nebbiolo", "barolo", "piedmont", "italy", "red wine", "docg"]
    )

    // MARK: Bar Finds

    static let rusteakMule = DrinkCard(
        name: "Rusteak Mule",
        category: .barDrink,
        description: "A house take on the Moscow Mule from Rusteak's cocktail menu. Ginger-forward with a citrus backbone. Proportions not listed — build your own recipe.",
        origin: Origin(
            country: "USA",
            region: "Florida",
            locality: "Ocoee",
            latitude: 28.5694,
            longitude: -81.5437
        ),
        knownIngredients: ["vodka", "ginger beer", "fresh lime juice", "mint"],
        tags: ["mule", "vodka", "ginger", "citrus"],
        venueName: "Rusteak"
    )
}
