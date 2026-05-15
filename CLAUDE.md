# DRANX — Agent Handoff & Development Guide

## What This App Is

DRANX is an iOS cocktail discovery app with two distinct personas:

**Drinks tab (explorer/social)** — A "drink passport." Scan bar bottles or import a venue menu to get DrinkCards: passport-style profiles of spirits, wines, and bar menu items with origin maps, tasting notes, and check-in tracking. Designed for discovery, sharing, and eventual gamification (badges, streaks, passport stamps).

**Recipes tab (craft/maker)** — A mixologist toolkit. Full cocktail recipes with precise measurements, units, substitutions, and step-by-step instructions. For the at-home bartender learning to replicate and create.

The core differentiator: a camera that identifies bottles and surfaces what you can make — plus the ability to scan a bar menu, extract the drink list, and reconstruct recipes using an LLM.

The models are designed agnostically — Recipe and Ingredient work for food dishes too (Appetizer, Main Course, Dessert categories already exist).

---

## Project Setup

- **Language:** Swift, SwiftUI, iOS 16+ minimum
- **Project generation:** `xcodegen` (Homebrew) — `project.yml` is the source of truth; `.xcodeproj` is git-ignored
- **GitHub:** https://github.com/hecde/DRANX (`main` branch)
- **gh CLI** authenticated as `hecde` — run `gh auth setup-git` if push fails

```bash
# After adding or moving any files:
xcodegen generate

# Open project:
open "DRANX.xcodeproj"

# Push:
git add . && git commit -m "..." && git push
```

---

## Architecture

**Critical rule:** `NavigationStack` lives in `ContentView` only. Feature views must NOT have their own `NavigationStack` — nested stacks cause a black screen on launch.

**Tab switching from HomeView:** `HomeView` accepts `@Binding var selectedTab: Int` passed from `ContentView`. The Drinks and Recipes feature cards call `selectedTab = 1` / `selectedTab = 2` to switch tabs rather than pushing via `NavigationLink`.

```
DRANX/
├── App/
│   ├── DRANXApp.swift              ← UIKit appearance (tab bar, nav bar colors)
│   └── ContentView.swift           ← TabView + NavigationStack per tab + selectedTab state
├── DesignSystem/
│   ├── Colors.swift                ← Color.Speakeasy.* + hex init
│   └── Typography.swift            ← Font extensions
├── Models/
│   ├── Ingredient.swift            ← MeasurementUnit enum + Ingredient struct
│   ├── Recipe.swift                ← RecipeCategory enum + Recipe struct
│   ├── SampleData.swift            ← 5 sample cocktail recipes
│   ├── DrinkCard.swift             ← DrinkCardCategory enum + DrinkCard struct
│   ├── DrinkSampleData.swift       ← 5 sample drink cards
│   ├── Origin.swift                ← Origin struct with lat/lon → CLLocationCoordinate2D
│   └── Venue.swift                 ← Venue struct (stubbed, not yet used in UI)
├── Features/
│   ├── Home/
│   │   └── HomeView.swift          ← Landing page; feature cards + recently added strip
│   ├── Scanner/
│   │   └── ScannerView.swift       ← PLACEHOLDER ONLY — camera not implemented
│   ├── Drinks/
│   │   ├── DrinksView.swift        ← List + category filter chips (FilterChip component)
│   │   ├── DrinkCardView.swift     ← List card + DrinkCategoryBadge component
│   │   ├── DrinkCardDetailView.swift ← MapKit pin, tasting notes, Build Recipe button, check-in
│   │   └── OriginMapView.swift     ← MapKit map with gold pin + frosted label overlay
│   └── Recipes/
│       ├── RecipesView.swift
│       ├── RecipeCardView.swift    ← RecipeCard + CategoryBadge component
│       ├── RecipeDetailView.swift  ← Full detail + inline edit mode (Save/Cancel toolbar)
│       └── IngredientRowView.swift ← Display + edit mode; unit picker menu; SubstitutionChip
└── Supporting/
    └── Info.plist
```

---

## Design System

```swift
// Colors — Color.Speakeasy.*
.background    // #0E0B08  near-black warm
.surface       // #1C1712
.surfaceRaised // #2C2419  card background
.border        // #3A3025
.gold          // #C8A96E  primary accent
.goldMuted     // #7A5C1E
.cream         // #F2E8D5  primary text
.parchment     // #9E8E72  secondary text
.ash           // #5A5040  muted/tertiary

// Fonts
Font.heroTitle      // largeTitle, serif, semibold
Font.recipeTitle    // title2, serif, semibold
Font.measurement    // callout, monospaced, semibold  ← amounts
Font.unitLabel      // caption, monospaced            ← units
Font.sectionLabel   // caption, semibold, kerned      ← SECTION HEADERS
Font.badgeText      // caption2, semibold             ← pills and chips

// Per-category accent hex (DrinkCardCategory.accentHex)
Spirit:   "C8A96E"  gold
Wine:     "9B3A5A"  burgundy
Beer:     "C87941"  amber
Bar Find: "4A7C8B"  teal
```

---

## What Is Built

| Feature | Status |
|---|---|
| Speakeasy design system (colors, typography) | Done |
| Recipe model + ingredient system with units + substitutions | Done |
| DrinkCard model with Origin + MapKit pin | Done |
| HomeView landing with atmospheric feature cards | Done |
| Drinks tab with category filter | Done |
| DrinkCard detail with map, tasting notes, check-in toggle | Done |
| "Build Recipe" button on bar-find DrinkCards | UI only — API not wired |
| Recipes tab with full card list | Done |
| Recipe detail with full inline edit mode | Done |
| ScannerView | Placeholder text only |
| Data persistence | None — all in-memory sample data |
| Menu import flow | Designed, not built |
| Venue model | Stubbed, not used in UI |

---

## MVP Gaps — What Is Needed to Ship

### 1. Data Persistence
Everything resets on relaunch. Recommended path:
- **SwiftData** (iOS 17+) for local persistence first — simple, Apple-native
- Add **Firebase Firestore** when social/sharing features begin

### 2. Bottle Scanner
`ScannerView` is a placeholder. Full pipeline:
1. `AVFoundation` live camera feed
2. **OpenAI Vision API** — send a frame, ask "what bottles do you see?" → returns names
3. Match names to DrinkCards or create new ones
4. Surface matching recipes from TheCocktailDB

### 3. "Build Recipe" LLM Call
Button exists in `DrinkCardDetailView`. Wire it up:
- Send `card.knownIngredients` to Claude API
- Parse response into a `Recipe`, mark as estimated
- Present in `RecipeDetailView` edit mode so user can adjust before saving

### 4. Menu Import Flow
The "+" in DrinksView should open a sheet with:
- Paste a URL → fetch HTML → LLM extraction
- Import a PDF → PDFKit text → LLM extraction
- Camera scan → VisionKit `DataScannerViewController` OCR → LLM extraction
- All three paths return `[DrinkCard]` → user reviews → saved

### 5. App Signing
Xcode → DRANX target → Signing & Capabilities → set Team. Required for device or TestFlight.

---

## API Keys Needed

Create `DRANX/Supporting/Secrets.swift` — already in `.gitignore`:

```swift
enum Secrets {
    static let openAIKey     = "sk-..."       // bottle detection
    static let anthropicKey  = "sk-ant-..."   // recipe reconstruction
}
```

**TheCocktailDB** is free, no key required for public tier.
URL format: `https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Bourbon`

---

## iOS Best Practices Still To Add

| Area | Detail |
|---|---|
| Accessibility | `.accessibilityLabel()` on icon-only buttons; VoiceOver hints on interactive cards |
| Dynamic Type | Some fixed font sizes need `relativeTo:` scaling |
| Error states | No error views — network failures silently do nothing |
| Loading states | No `ProgressView` or skeleton screens for async calls |
| Empty states | No empty state views when lists are empty |
| Haptics | `UIImpactFeedbackGenerator` on check-in toggle, save actions |
| Localization | All strings hardcoded English |
| Privacy manifest | Required for App Store — camera and photo library usage declared in Info.plist already; formal manifest still needed |
| App icon | No icon set — needed before TestFlight |
| iPad layout | No column/adaptive layouts |
| Onboarding | No first-launch explanation of features |

---

## Product Vision Notes

- **Drinks tab** is social/discovery — long-term: drink passport with stamps, check-in feed, friends, venue map, trending drinks. Think Untappd but for all spirits and cocktails.
- **Recipes tab** is personal/craft — skill progression, flavor education, personal notes on attempts. Quieter, more focused.
- **Pairings** (food + drink) belong on DrinkCard naturally — out of scope for MVP but the field can be added without breaking anything.
- **Wine DrinkCards** have origin map + vintage + grape variety. The MapKit pin showing Napa Valley or Barolo is a key design detail.
- **Bar Find DrinkCards** (from scanned menus) have known ingredients but no proportions — "Build Recipe" bridges them to the Recipe model via LLM.
- The name DRANX = drinks + portability/discovery concept.
