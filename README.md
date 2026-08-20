# Product Lab — Copilot-first

Repository central pour cadrer, initialiser, reprendre et clôturer des projets produit
avec GitHub Copilot.

Il sert à la fois de laboratoire, de source versionnée des règles d'orchestration et de
template reproductible pour les futurs repositories projets.

## À quoi sert ce repository

Ce système accompagne un Product Manager hands-on depuis un PRD ou une idée produit
jusqu'à un projet prêt pour le développement :

1. cadrer le besoin sans créer prématurément de ressources GitHub ;
2. initialiser un repository projet avec sa gouvernance Copilot ;
3. créer les premiers milestones, issues de Solution Design/préparation et Project GitHub ;
4. produire et faire valider un Solution Design proportionné avant toute issue de développement ;
5. reprendre l'état réel depuis GitHub ;
6. faire évoluer le plan si le contexte change ;
7. vérifier et clôturer un projet.

L'exécution (PRD, plan, tâches, implémentation) est pilotée par **spec-kit** depuis
BOOTSTRAP. Ce repository fournit le portefeuille multi-projets, la vérification
indépendante, les apprentissages cross-projets et l'installation des skills.
Voir [`docs/spec-kit-adoption.md`](docs/spec-kit-adoption.md).

## Surfaces Copilot supportées

La gouvernance reste dans l'écosystème GitHub Copilot. Le choix d'un modèle Anthropic
est acceptable lorsqu'il est fait dans Copilot ; Claude CLI, Claude Code ou tout autre
assistant LLM externe ne peut pas produire une vérification indépendante ou une décision
de merge opposable. Voir [`docs/copilot/tooling-policy.md`](docs/copilot/tooling-policy.md).

| Surface | Usage attendu |
|---|---|
| Copilot CLI | Surface principale : utiliser la skill `product-orchestrator` installée au niveau utilisateur. La skill route et lit les prompts comme ressources textuelles. |
| VS Code Copilot Chat | Surface secondaire : utiliser les prompt files `.github/prompts/*.prompt.md` comme entrées natives lorsque VS Code les prend en charge. |
| GitHub.com | Utilisé pour les repositories, issues, Projects, pull requests et CI ; les prompt files ne sont pas la surface principale d'exécution. |

## Autonomie opérationnelle

Le PM délègue à Copilot les événements Git et GitHub routiniers : créer ou fermer une
issue déterministe, passer à l'issue `Ready` suivante, ouvrir une PR, fusionner une PR
éligible, nettoyer une branche, mettre à jour un Project ou un milestone.

Copilot sollicite le PM uniquement pour les décisions produit : validation de plan,
changement de périmètre, Solution Design, risque significatif, coût/service payant,
sécurité/confidentialité, migration destructive ou décision difficile à inverser.

Les critères détaillés vivent dans [`.github/copilot-instructions.md`](.github/copilot-instructions.md)
et dans les prompts de mode.

## Installation de la skill utilisateur

Depuis VS Code, le repository peut être utilisé directement avec les prompt files de ce
workspace. Depuis Copilot CLI, l'orchestration repose sur la skill utilisateur : il faut
donc l'installer avant d'utiliser les modes depuis le CLI.

Pour rendre l'orchestrateur disponible depuis Copilot CLI et depuis n'importe quel
repository local, installer la skill utilisateur :

```powershell
./setup/install.ps1
```

Le script copie `setup/user-skills/product-orchestrator/` vers
`~/.copilot/skills/product-orchestrator/`.

À relancer après tout `git pull` qui modifie `setup/user-skills/`, sinon la copie
installée peut diverger de la source versionnée. Voir [`setup/README.md`](setup/README.md).

## Utilisation rapide

Dans Copilot CLI avec la skill installée, ou dans VS Code Copilot Chat avec les prompt
files du workspace, décrire le mode et le projet :

```text
DISCOVER mon-projet
BOOTSTRAP mon-projet
RESUME mon-projet
STATUS mon-projet
REPLAN mon-projet
CLOSE mon-projet
```

Si le mode ou le projet est ambigu, l'orchestrateur détecte l'état réel et demande
confirmation avant d'agir. Pour une demande de nouveau projet, `DISCOVER` vient toujours
avant toute création de fichier, repository, issue ou Project.

## Modes disponibles

| Mode | Rôle | Procédure d'autorité |
|---|---|---|
| `DISCOVER` | Cadrer un nouveau projet sans créer de ressource GitHub. | `.github/prompts/discover.prompt.md` |
| `BOOTSTRAP` | Initialiser un projet GitHub après validation explicite du plan. | `.github/prompts/bootstrap.prompt.md` |
| `ADOPT` | Inscrire un projet existant dans le framework sans remettre en question l'existant. | `.github/prompts/adopt.prompt.md` |
| `RESUME` | Reprendre un projet depuis l'état GitHub réel. | `.github/prompts/resume.prompt.md` |
| `STATUS` | Restituer l'état sans implémenter. | `.github/prompts/status.prompt.md` |
| `REPLAN` | Proposer une évolution du plan après écart ou changement de contexte. | `.github/prompts/replan.prompt.md` |
| `CLOSE` | Vérifier, clôturer et capitaliser si nécessaire. | `.github/prompts/close.prompt.md` |

Index des prompts : [`.github/prompts/README.md`](.github/prompts/README.md).
Vue synthétique de l'orchestration : [`docs/copilot/orchestration.md`](docs/copilot/orchestration.md).

## Répartition des responsabilités

| Objet | Responsabilité |
|---|---|
| `.github/copilot-instructions.md` | Règles permanentes chargées par Copilot : rôles, garde-fous, gestion Git/PR, protection du périmètre, fin de tâche. |
| `setup/user-skills/product-orchestrator/SKILL.md` | Skill utilisateur cross-repo : détection du contexte, routage entre modes et garde-fous. |
| `.github/agents/orchestrator-automation.agent.md` | Agent dédié aux décisions GitHub routinières : merge, fermeture d'issue, passage à l'issue suivante, Project/milestone, nettoyage de branche. |
| `.github/prompts/*.prompt.md` | Détail opérationnel des procédures du repository central. |
| `docs/spec-kit-adoption.md` | Workflow spec-kit, complément de constitution (Principe VI) et apport propre de ce repository. |
| `docs/copilot/tooling-policy.md` | Politique des surfaces et modèles autorisés pour la gouvernance Copilot. |
| `templates/product-agent-template/` | Template complet injecté dans les nouveaux repositories projets. |
| `templates/product-agent-template/.github/skills/project-orchestrator/SKILL.md` | Skill locale des projets enfants : reprise, statut, replanification et clôture. |
| `templates/product-agent-template/.github/skills/architecture-review/SKILL.md` | Skill locale de revue indépendante du Solution Design. |
| `projects.yaml` | Registre des projets suivis. |
| `memory/global-learnings.yaml` | Règles globales promues manuellement après validation. |

## Structure principale

```text
.github/
├── copilot-instructions.md
├── agents/
└── prompts/
    ├── discover.prompt.md
    ├── bootstrap.prompt.md
    ├── adopt.prompt.md
    ├── resume.prompt.md
    ├── status.prompt.md
    ├── replan.prompt.md
    └── close.prompt.md

docs/
├── spec-kit-adoption.md
└── copilot/
    ├── orchestration.md
    ├── independent-verification.md
    ├── learning-lifecycle.md
    └── tooling-policy.md

memory/
└── global-learnings.yaml

projects.yaml

setup/
├── install.ps1
├── README.md
└── user-skills/product-orchestrator/SKILL.md

templates/
└── product-agent-template/
    ├── .github/copilot-instructions.md
    ├── .github/agents/
    ├── .github/prompts/
    ├── .github/skills/project-orchestrator/SKILL.md
    ├── .github/skills/architecture-review/SKILL.md
    ├── docs/product/plan.md
    ├── docs/solution-design/solution-design.md
    ├── docs/architecture/
    ├── docs/implementation-plan.md
    ├── docs/decisions/
    ├── docs/learnings/
    └── docs/independent-verification.md
```

## Sources de vérité

| Source | Localisation |
|---|---|
| Plan produit d'un projet | `docs/product/plan.md` dans le repository projet |
| Solution Design approuvé | `docs/solution-design/solution-design.md` dans le repository projet |
| Travail et avancement | GitHub Issues et GitHub Project |
| Implémentation et preuves | Pull requests et CI |
| Décisions | `docs/decisions/` du repository projet |
| Apprentissages locaux | `docs/learnings/learning-log.yaml` du repository projet |
| Registre multi-projets | `projects.yaml` |
| Règles globales | `memory/global-learnings.yaml` |
| Politique de modèles et outils | `docs/copilot/tooling-policy.md` |

## Garde-fous essentiels

- Aucune ressource GitHub n'est créée avant validation explicite du plan.
- Une demande de nouveau projet passe par `DISCOVER` avant toute implémentation.
- Le mode `BOOTSTRAP` pousse et vérifie le scaffold avant de créer milestones, issues et Project.
- Aucun développement fonctionnel ne démarre avant `Solution Design: Approved`.
- Une seule issue principale peut être en cours d'implémentation.
- L'état est repris depuis GitHub et `projects.yaml`, jamais depuis la mémoire du chat seule.
- Une évolution du framework modifie par défaut uniquement le repository source d'autorité ; la propagation vers d'autres repositories doit être demandée explicitement.
- Copilot gère Git et les Pull Requests de manière autonome ; le PM valide le produit, pas le code ni les diffs.

## Créer ou reprendre un projet

- Nouveau projet : lancer `DISCOVER <nom>`, faire valider le plan, puis `BOOTSTRAP <nom>`.
  Le développement commence seulement après Solution Design, revue indépendante et validation PM.
- Projet existant hors framework : lancer `ADOPT <nom>`.
- Projet déjà enregistré : lancer `RESUME <nom>` ou `STATUS <nom>`.

Les repositories projets créés depuis le template contiennent leurs propres instructions,
prompts et skill locale. Ils n'ont pas besoin de ce repository ouvert pour les modes
`RESUME`, `STATUS`, `REPLAN` et `CLOSE`.
