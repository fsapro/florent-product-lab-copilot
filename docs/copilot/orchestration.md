# Orchestration — GitHub Copilot

Ce document explique synthétiquement l'orchestration produit du repository. Il n'est
pas une procédure exécutable.

## Répartition des responsabilités

| Objet | Responsabilité |
|---|---|
| `.github/copilot-instructions.md` | Règles permanentes chargées par Copilot : rôles, garde-fous, gestion Git/PR, protection du périmètre, fin de tâche. |
| `setup/user-skills/product-orchestrator/SKILL.md` | Détection du contexte, choix du mode, routage et garde-fous cross-repo. |
| `.github/prompts/*.prompt.md` | Procédure opérationnelle détaillée de chaque mode. C'est la source d'autorité comportementale par mode. |
| `templates/product-agent-template/` | Version reproductible des instructions, prompts et skill pour les repositories projets. |
| `projects.yaml` | Registre multi-projets du repository central. |

## Modes disponibles

| Mode | Objectif | Procédure d'autorité |
|---|---|---|
| `DISCOVER` | Cadrer un nouveau projet sans créer de ressource GitHub. | `.github/prompts/discover.prompt.md` |
| `BOOTSTRAP` | Initialiser un projet GitHub après validation explicite du plan, en conservant l'ordre validé : scaffold poussé et vérifié avant milestones, issues et Project. | `.github/prompts/bootstrap.prompt.md` |
| `ADOPT` | Inscrire un projet brownfield dans le framework sans remettre en question l'existant. | `.github/prompts/adopt.prompt.md` |
| `RESUME` | Reprendre un projet existant depuis l'état GitHub réel. | `.github/prompts/resume.prompt.md` |
| `STATUS` | Restituer l'état d'un projet sans implémenter. | `.github/prompts/status.prompt.md` |
| `REPLAN` | Proposer une évolution du plan après écart ou changement de contexte. | `.github/prompts/replan.prompt.md` |
| `CLOSE` | Vérifier les critères, clôturer et capitaliser si nécessaire. | `.github/prompts/close.prompt.md` |

## Workflow de delivery

Le workflow cible est :

PRD → Solution Design → revue indépendante → validation PM → ADR nécessaires → plan
d'implémentation → issues → développement → tests proportionnés → contrôle de
conformité au design → Pull Request → fusion → mise à jour documentaire.

`BOOTSTRAP` conserve l'ordre validé : le scaffold est poussé et vérifié avant les
milestones, issues et Project. Les issues créées au bootstrap restent limitées à
Solution Design / préparation ; aucune issue de développement ne devient `Ready` avant
`Solution Design: Approved`.

Les tests suivent une logique proportionnée : boucle courte ciblée pendant les
itérations, puis salve de non-régression aux gates de risque (release, milestone,
changement structurant, sécurité, migration, dépendance majeure ou propagation
multi-repository).

## Politique de publication

Par défaut, une demande modifie uniquement le repository source d'autorité concerné.
La propagation vers d'autres repositories n'est pas implicite : elle doit être demandée
explicitement.

Si une propagation est demandée, Copilot traite chaque repository modifié sur sa propre
branche et sa propre Pull Request.

## Invocation

- **Copilot CLI** : utiliser la skill `product-orchestrator` si elle est installée
  via `setup/install.ps1`. La skill route vers le bon mode et consulte les prompts
  comme ressources textuelles accessibles.
- **VS Code Copilot Chat** : les prompt files `.github/prompts/*.prompt.md` peuvent
  être utilisés comme entrées natives lorsque la surface les prend en charge.

Si le mode est ambigu, l'orchestrateur détecte l'état réel, propose le mode probable
et attend confirmation avant toute action.

## Garde-fous non dédupliqués

Les garde-fous restent dans les instructions et/ou skills lorsqu'ils doivent être
actifs avant même la lecture d'un prompt :

- aucune ressource GitHub avant validation explicite du plan ;
- aucune implémentation prématurée pour une demande de nouveau projet ;
- une seule issue principale en cours ;
- reprise depuis GitHub et `projects.yaml`, jamais depuis la mémoire du chat seule ;
- gestion autonome de Git et des Pull Requests selon `.github/copilot-instructions.md`.

Le détail opérationnel, notamment le comportement validé de `BOOTSTRAP`, ne doit pas
être recopié ici : il vit dans le prompt du mode concerné.
