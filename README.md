# live_rate_web

A Flutter Web demo that shows Euro exchange rates in a table.  
- Uses GetX for state management.
- Fetches data from a fake API (mocki.io).
- Auto-refreshes every 5 seconds.

## Run locally

1. Ensure Flutter (stable) is installed.
2. From project root:
```bash
flutter pub get
flutter run -d chrome
```

## Replace API
Edit `lib/controllers/rate_controller.dart` and change `apiUrl` to your own endpoint.

## Build for web
```bash
flutter build web
```

Then deploy the `build/web` folder to Firebase, Vercel, Netlify, or GitHub Pages.
