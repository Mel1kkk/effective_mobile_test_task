# Test Task for Junior Flutter Developer Position at Effective Mobile

This Flutter app shows a list of characters from the animated series **Rick and Morty**, using the public [Rick and Morty API].  
The app lets users view character info, add favorites and use it offline after data is loaded.

---

## 📱 Features

### 🧍 Main Screen (Character List)
- Displays characters in card format with:
  - Image with shimmer loading effect
  - Name, status and species type
  - Star icon to mark as favorite (filled if already in favorites)
- When you tap a card, it shows more info with a **fade animation**. Tapping again returns to the front view.
- Infinite scroll (pagination): More characters load when scrolling to the bottom
- Cached data is saved locally (SQLite), so the app works offline after the first load

### ⭐ Favorites Screen
- Shows only favorite characters
- Allows sorting (A→Z / Z→A)
- You can remove characters from favorites
- Favorites are saved using **SharedPreferences**
- Max 8 favorites allowed. If you try to add more, a warning will appear

### 🧭 Navigation
- Simple BottomNavigationBar to switch between:
  - Main character list
  - Favorites

### 🎨 Extras
- Splash screen with **Rick animation (Lottie)**
- Offline support using cached characters
- Clean architecture using **MVVM pattern** and **Provider** for state management
- Smooth experience with animated loading states and UI feedback

---

## 📬 Contact

You can reach me on Telegram: [@mel1kkk]

---
