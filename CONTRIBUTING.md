# Contributing to Wastec Bank App

Thanks for contributing! This document covers the contribution workflow, coding standards, and release guidance.

How to contribute

1. Fork the repository (or clone if you have push access).
2. Create a branch for your work:

```powershell
git checkout -b feat/short-description
```

3. Make small, focused commits with clear messages. Use conventional commit prefixes (optional): `feat:`, `fix:`, `chore:`, `docs:`.

4. Run formatting and analysis locally before opening a PR:

```powershell
dart format .
flutter analyze
flutter test
```

5. Push your branch and open a Pull Request on GitHub.

Pull request checklist

- [ ] Branch created from `main`
- [ ] Tests added and passing (where relevant)
- [ ] Linting and static analysis passes
- [ ] Screenshots for UI changes
- [ ] Description of what changed and why

Release process (APK)

- Build the release APK locally:
```powershell
flutter build apk --release
```
- Verify the app in a release environment (install on a device):
```powershell
flutter install --release
```
- Create a GitHub release and upload the APK as an asset (or use CI to build releases automatically).

Security and secrets

- Do not commit signing keys, keystore passwords, or any secrets into this repository.
- Use environment variables and secrets in CI (e.g., GitHub Actions secrets) to sign and upload artifacts.

Code of conduct

Be respectful and constructive. Follow common open-source contribution etiquette and respond promptly to review comments.
