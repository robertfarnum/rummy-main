## Context

The Gin Rummy Scorekeeper app currently has a minimal info button in the home screen AppBar that shows an AlertDialog with brief scoring type descriptions (Knock and Gin). Users who don't know how to play Gin Rummy have no way to learn the rules from within the app. The app already has a screen-based navigation pattern (home, game, history, player management, score entry, game over).

## Goals / Non-Goals

**Goals:**
- Provide a dedicated rules screen with comprehensive Gin Rummy rules
- Make rules accessible from the existing info button on the home screen
- Use a scrollable, well-organized layout with clear sections for each aspect of the game
- Preserve the existing scoring type information within the new rules screen

**Non-Goals:**
- Interactive tutorials or animated rule demonstrations
- Variant rules (Oklahoma Gin, Hollywood Gin, etc.)
- Localization/translation of rules
- Adding rules links from other screens

## Decisions

**1. Dedicated StatelessWidget screen vs. expanding the existing dialog**
- Use a new `RulesScreen` as a full-page `StatelessWidget` with `SingleChildScrollView`
- Rationale: A dialog is too constrained for comprehensive rules content. A full screen allows proper scrolling, section headers, and a consistent navigation experience matching the app's existing screen pattern.
- Alternative considered: Tabbed dialog or bottom sheet — rejected because rules content is long-form and benefits from full-screen space.

**2. Static content, no data dependencies**
- All rules text is hardcoded in the widget — no model, no storage, no API
- Rationale: Game rules are static reference content. No reason to add complexity with data loading.

**3. Replace `_showScoringInfo` dialog with `Navigator.push` to RulesScreen**
- The info button in `home_screen.dart` will navigate to the new screen instead of showing a dialog
- Rationale: Direct replacement keeps the same entry point; users get more content without UI confusion.

**4. Content organization using ExpansionTile sections**
- Use `ExpansionTile` widgets for each rules section (Objective, Setup, Gameplay, Melds, Knocking & Gin, Scoring)
- Rationale: Keeps the screen scannable without overwhelming the user. Users can expand only the sections they need. This is a standard Flutter Material pattern requiring no extra dependencies.

## Risks / Trade-offs

- [Long content scroll] → Mitigated by using collapsible `ExpansionTile` sections so users can focus on specific topics
- [Removing quick scoring dialog] → The scoring info is preserved as a section within the rules screen, so no information is lost
