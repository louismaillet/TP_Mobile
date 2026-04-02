# Setup - TP Mobile

## Lancer l'Application

```bash
flutter clean
flutter pub get
flutter run -d chrome --web-port 5000
```

---

## SQL à lancer dans Supabase

### Copier-coller dans l'éditeur SQL de Supabase

```sql
CREATE TABLE tasks (
  id INT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  nbhours INTEGER DEFAULT 0,
  difficulty INTEGER DEFAULT 1,
  tags TEXT,
  connecterSupabase INTEGER DEFAULT 0
);
```

---

## Configuration

Modifier `lib/main.dart` avec vos clés Supabase :

```dart
await Supabase.initialize(
  url: "VOTRE_URL",
  anonKey: "VOTRE_CLE",
);
```

# Ce que j'ai fait : 

- Création d'une table `tasks` dans Supabase avec les champs nécessaires.
- Mise en place de l'initialisation de Supabase dans le code Flutter.
- Création d'une task avec le choix de l'ajouter a supabase ou non.
- sauvergarde de la task dans une liste localement.





