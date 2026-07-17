# Product Lab — Copilot-first

Système d'exécution produit multi-projets, configuré pour GitHub Copilot.

---

## Installation

Ce repository fonctionne sans installation pour un usage local (DISCOVER, BOOTSTRAP,
RESUME, etc. depuis ce workspace). Pour rendre l'orchestrateur disponible **depuis
n'importe quel autre repository** (créé ou non depuis ce système), installer la skill
au niveau utilisateur :

```powershell
./setup/install.ps1
```

Ce script copie `setup/user-skills/product-orchestrator/` vers `~/.copilot/skills/`.
À relancer après tout `git pull` qui modifie `setup/user-skills/` (voir `setup/README.md`).

---

## Usage avec GitHub Copilot

Ce repository est conçu pour être utilisé avec GitHub Copilot en mode Agent dans VS Code.

### Démarrage

1. Ouvrir ce repository dans VS Code.
2. Lancer GitHub Copilot Chat en mode Agent.
3. Décrire le mode souhaité et le projet : `DISCOVER florent-product-lab` ou `RESUME mon-projet`.
4. Copilot charge le contexte depuis `.github/copilot-instructions.md` et les sources de vérité, puis orchestre le travail.

### Modes disponibles

| Mode | Usage |
|---|---|
| `DISCOVER` | Cadrer un nouveau projet sans créer de ressources |
| `BOOTSTRAP` | Initialiser un projet après validation du plan |
| `ADOPT` | Inscrire un projet existant (brownfield) dans le framework sans remettre en question le travail déjà fait |
| `RESUME` | Reprendre un projet existant depuis GitHub |
| `STATUS` | Restituer l'état d'un projet |
| `REPLAN` | Proposer une évolution du plan |
| `CLOSE` | Vérifier et clôturer un projet |

Les prompts réutilisables sont dans `.github/prompts/` (invocables via `/discover`, `/bootstrap`, `/adopt`, `/resume`, `/status`, `/replan`, `/close` dans Copilot Chat). La documentation détaillée des modes est dans `docs/copilot/orchestration.md`.

---

## Structure du repository

```
.github/
├── copilot-instructions.md   # Point d'entrée natif GitHub Copilot — contrat de gouvernance complet
└── prompts/                  # Prompts natifs invocables via /discover /bootstrap /adopt /resume /status /replan /close
    ├── README.md
    ├── discover.prompt.md
    ├── bootstrap.prompt.md
    ├── adopt.prompt.md
    ├── resume.prompt.md
    ├── status.prompt.md
    ├── replan.prompt.md
    └── close.prompt.md

docs/copilot/
├── orchestration.md          # Workflows DISCOVER/BOOTSTRAP/ADOPT/RESUME/STATUS/REPLAN/CLOSE
├── learning-lifecycle.md     # Cycle de vie des apprentissages locaux
├── independent-verification.md  # Niveaux de vérification indépendante
└── MIGRATION_FROM_CLAUDE.md  # Rapport de migration depuis la version Claude

memory/
├── global-learnings.yaml     # Règles globales actives (multi-projets)
└── README.md                 # Gouvernance de la mémoire globale

projects.yaml                 # Registre multi-projets

setup/
├── install.ps1                # Installe la skill product-orchestrator au niveau utilisateur
├── README.md                  # Documentation d'installation
└── user-skills/
    └── product-orchestrator/SKILL.md   # Source versionnée de la skill user-level

templates/
└── product-agent-template/   # Template pour créer un nouveau projet
    ├── .github/copilot-instructions.md   # Instructions Copilot du projet (contrat complet)
    ├── .github/prompts/       # Prompts resume/status/replan/close adaptés au repo enfant
    ├── docs/product/plan.md  # Plan produit canonique
    └── docs/learnings/       # Registre local d'apprentissages
```

---

## Conventions retenues

### Couche IA vs actifs produit

- **Couche IA** (orchestration, instructions, prompts) : modifiable selon l'outil IA utilisé.
- **Actifs produit** (templates, plan produit, learning-log, PULL_REQUEST_TEMPLATE) : indépendants de l'outil IA.

### Fichiers natifs GitHub Copilot

- `.github/copilot-instructions.md` : seule source de vérité chargée automatiquement par Copilot à chaque session — contient l'intégralité du contrat de gouvernance (rôles, règles fondamentales, protection du périmètre, fin de tâche). Aucun renvoi vers un autre fichier pour les règles non-négociables.
- `.github/prompts/*.prompt.md` : emplacement natif des prompts réutilisables, invocables via slash-command (`/discover`, `/bootstrap`, etc.) dans Copilot Chat.

### Mémoire et apprentissages

- Les règles globales (`memory/global-learnings.yaml`) sont promues manuellement, après validation explicite du PM.
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
