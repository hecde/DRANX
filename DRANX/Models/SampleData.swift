import Foundation

enum SampleData {
    static let recipes: [Recipe] = [
        oldFashioned, negroni, margarita, aperolSpritz, darkAndStormy
    ]

    static let oldFashioned = Recipe(
        name: "Old Fashioned",
        category: .cocktail,
        description: "The original cocktail. Whiskey, bitters, and a touch of sweet.",
        ingredients: [
            Ingredient(name: "Bourbon Whiskey",    quantity: 2,    unit: .ounce,
                       substitutions: ["Rye Whiskey", "Tennessee Whiskey"]),
            Ingredient(name: "Simple Syrup",       quantity: 0.25, unit: .ounce,
                       substitutions: ["Demerara Syrup", "Sugar Cube + Splash Water"]),
            Ingredient(name: "Angostura Bitters",  quantity: 2,    unit: .dash,
                       substitutions: ["Peychaud's Bitters"]),
            Ingredient(name: "Orange Peel",        quantity: 1,    unit: .twist),
            Ingredient(name: "Luxardo Cherry",     quantity: 1,    unit: .piece, isOptional: true),
        ],
        steps: [
            "Add simple syrup and bitters to a mixing glass.",
            "Add bourbon and fill with large ice cubes.",
            "Stir for 20–25 rotations until well chilled.",
            "Strain into a rocks glass over a large ice cube.",
            "Express orange peel over the glass, rim the edge, and drop in.",
            "Garnish with a cherry if desired.",
        ],
        glassware: "Rocks Glass",
        prepTimeMinutes: 5
    )

    static let negroni = Recipe(
        name: "Negroni",
        category: .cocktail,
        description: "Equal parts. Bitter, sweet, strong.",
        ingredients: [
            Ingredient(name: "Gin",            quantity: 1, unit: .ounce,
                       substitutions: ["Mezcal", "Bourbon"]),
            Ingredient(name: "Campari",        quantity: 1, unit: .ounce,
                       substitutions: ["Aperol", "Select Aperitivo"]),
            Ingredient(name: "Sweet Vermouth", quantity: 1, unit: .ounce,
                       substitutions: ["Dry Vermouth"]),
            Ingredient(name: "Orange Peel",    quantity: 1, unit: .twist),
        ],
        steps: [
            "Combine all spirits in a mixing glass with ice.",
            "Stir for 25 rotations until well chilled.",
            "Strain into a rocks glass over a large ice cube.",
            "Garnish with an expressed orange twist.",
        ],
        glassware: "Rocks Glass",
        prepTimeMinutes: 5
    )

    static let margarita = Recipe(
        name: "Margarita",
        category: .cocktail,
        description: "Bright, tart, and balanced. The gold standard of citrus cocktails.",
        ingredients: [
            Ingredient(name: "Tequila Blanco",   quantity: 2,    unit: .ounce,
                       substitutions: ["Tequila Reposado", "Mezcal"]),
            Ingredient(name: "Fresh Lime Juice", quantity: 0.75, unit: .ounce),
            Ingredient(name: "Triple Sec",       quantity: 0.75, unit: .ounce,
                       substitutions: ["Cointreau", "Grand Marnier"]),
            Ingredient(name: "Salt",             unit: .toTaste),
            Ingredient(name: "Lime Wheel",       quantity: 1,    unit: .slice, isOptional: true),
        ],
        steps: [
            "Salt the rim of a coupe or rocks glass.",
            "Combine tequila, lime juice, and triple sec in a shaker with ice.",
            "Shake vigorously for 15 seconds.",
            "Strain into the prepared glass.",
            "Garnish with a lime wheel.",
        ],
        glassware: "Coupe or Rocks Glass",
        prepTimeMinutes: 5
    )

    static let aperolSpritz = Recipe(
        name: "Aperol Spritz",
        category: .cocktail,
        description: "Light, refreshing, and deeply Italian.",
        ingredients: [
            Ingredient(name: "Aperol",      quantity: 3, unit: .ounce,
                       substitutions: ["Campari (stronger, more bitter)"]),
            Ingredient(name: "Prosecco",    quantity: 2, unit: .ounce,
                       substitutions: ["Champagne", "Cava"]),
            Ingredient(name: "Club Soda",   quantity: 1, unit: .splash),
            Ingredient(name: "Orange Slice", quantity: 1, unit: .slice),
        ],
        steps: [
            "Fill a large wine glass with ice.",
            "Pour Prosecco first, then Aperol.",
            "Top with a splash of club soda.",
            "Garnish with an orange slice.",
        ],
        glassware: "Large Wine Glass",
        prepTimeMinutes: 3
    )

    static let darkAndStormy = Recipe(
        name: "Dark 'n' Stormy",
        category: .cocktail,
        description: "Spicy ginger, rich rum. Built in the glass.",
        ingredients: [
            Ingredient(name: "Dark Rum",         quantity: 2, unit: .ounce,
                       substitutions: ["Black Strap Rum"]),
            Ingredient(name: "Ginger Beer",      quantity: 4, unit: .ounce,
                       substitutions: ["Ginger Ale (less spicy)"]),
            Ingredient(name: "Fresh Lime Juice", quantity: 0.5, unit: .ounce),
            Ingredient(name: "Lime Wedge",       quantity: 1,   unit: .wedge, isOptional: true),
        ],
        steps: [
            "Fill a highball glass with ice.",
            "Pour ginger beer over ice.",
            "Float dark rum by pouring over the back of a spoon.",
            "Squeeze lime wedge over the top and drop in.",
        ],
        glassware: "Highball Glass",
        prepTimeMinutes: 3
    )
}
