Backend & Java Setup
=====================

Configure Backend URL
---------------------

If you have a backend API, provide its base URL to the auth service when the provider is created in `lib/main.dart`:

```dart
ChangeNotifierProvider<AuthServiceImpl>(
  create: (_) => AuthServiceImpl(backendBaseUrl: 'https://api.example.com'),
),
```

Leave the string empty for the local SharedPreferences fallback used during development.

Java / Android JDK (Windows)
---------------------------

1. Install a supported JDK (e.g., AdoptOpenJDK / Temurin or Oracle JDK 17).
2. Set `JAVA_HOME` and update `PATH` (PowerShell):

```powershell
setx JAVA_HOME "C:\Program Files\Java\jdk-17"
setx PATH "%PATH%;%JAVA_HOME%\\bin"
```

3. Restart your terminal or IDE.

Validate with:

```powershell
java -version
echo $env:JAVA_HOME
```

Git: Commit staged changes
--------------------------

If you already staged files, run:

```bash
git commit -m "Add onboarding screens, language selection updates, auth service configurable backend"
git push
```

If nothing is staged and you want to add all changes:

```bash
git add .
git commit -m "Add onboarding screens and auth improvements"
git push
```

If you prefer a GUI, use VS Code Source Control to review staged files and commit.
