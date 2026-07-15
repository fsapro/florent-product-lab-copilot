# Florent Product Lab — Copilot-first

Système personnel d'exécution produit de Florent, configuré pour GitHub Copilot.

---

## Usage avec GitHub Copilot

Ce repository est conçu pour être utilisé avec GitHub Copilot en mode Agent dans VS Code.

### Démarrage

1. Ouvrir ce repository dans VS Code.
2. Lancer GitHub Copilot Chat en mode Agent.
3. Décrire le mode souhaité et le projet : `DISCOVER florent-product-lab` ou `RESUME mon-projet`.
4. Copilot charge le contexte depuis `COPILOT.md` et les sources de vérité, puis orchestre le travail.

### Modes disponibles

| Mode | Usage |
|---|---|
| `DISCOVER` | Cadrer un nouveau projet sans créer de ressources |
| `BOOTSTRAP` | Initialiser un projet après validation du plan |
| `RESUME` | Reprendre un projet existant depuis GitHub |
| `STATUS` | Restituer l'état d'un projet |
| `REPLAN` | Proposer une évolution du plan |
| `CLOSE` | Vérifier et clôturer un projet |

Les prompts réutilisables sont dans `prompts/copilot/`. La documentation détaillée des modes est dans `docs/copilot/orchestration.md`.

---

## Structure du repository

```
.github/
└── copilot-instructions.md   # Point d'entrée natif GitHub Copilot

COPILOT.md                    # Contrat de gouvernance actif

docs/copilot/
├── orchestration.md          # Workflows DISCOVER/BOOTSTRAP/RESUME/STATUS/REPLAN/CLOSE
├── learning-lifecycle.md     # Cycle de vie des apprentissages locaux
├── independent-verification.md  # Niveaux de vérification indépendante
└── MIGRATION_FROM_CLAUDE.md  # Rapport de migration depuis la version Claude

memory/
├── global-learnings.yaml     # Règles globales actives (multi-projets)
└── README.md                 # Gouvernance de la mémoire globale

prompts/copilot/
├── README.md                 # Index des prompts
├── discover.prompt.md        # Prompt mode DISCOVER
├── bootstrap.prompt.md       # Prompt mode BOOTSTRAP
├── resume.prompt.md          # Prompt mode RESUME
├── status.prompt.md          # Prompt mode STATUS
├── replan.prompt.md          # Prompt mode REPLAN
└── close.prompt.md           # Prompt mode CLOSE

projects.yaml                 # Registre multi-projets

templates/
└── product-agent-template/   # Template pour créer un nouveau projet
    ├── COPILOT.md            # Instructions Copilot du projet
    ├── docs/product/plan.md  # Plan produit canonique
    └── docs/learnings/       # Registre local d'apprentissages
```

---

## Conventions retenues

### Couche IA vs actifs produit

- **Couche IA** (orchestration, instructions, prompts) : modifiable selon l'outil IA utilisé.
- **Actifs produit** (templates, plan produit, learning-log, PULL_REQUEST_TEMPLATE) : indépendants de l'outil IA.

### Fichiers natifs GitHub Copilot

- `.github/copilot-instructions.md` : instructions automatiquement lues par Copilot à chaque session dans ce repository.
- `COPILOT.md` : contrat de gouvernance lisible par les humains et référencé par Copilot.

### Mémoire et apprentissages

- Les règles globales (`memory/global-learnings.yaml`) sont promues manuellement, après validation explicite de Florent.
- Les apprentissages locaux sont dans `docs/learnings/learning-log.yaml` de chaque projet.
- Par défaut, aucun apprentissage n'est créé.

---

## Créer un nouveau projet depuis le template

1. Copier `templates/product-agent-template/` dans un nouveau dossier ou repository.
2. Renseigner `projects.yaml` avec le nouveau projet.
3. Lancer Copilot en mode `BOOTSTRAP <nom-du-projet>`.

---

## Sources de vérité

| Source | Localisation |
|---|---|
| Plan produit | `docs/product/plan.md` du repository projet |
| Travail | GitHub Issues et GitHub Project |
| Implémentation | Pull requests et CI |
| Décisions | ADR et PDR du projet |
| Registre multi-projets | `projects.yaml` |
| Règles globales | `memory/global-learnings.yaml` |
