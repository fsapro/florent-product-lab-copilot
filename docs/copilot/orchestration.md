# Orchestration — GitHub Copilot

Ce document décrit les modes disponibles dans ce repository méta et leur répartition.
Pour le workflow d'exécution d'un projet, voir [`docs/spec-kit-adoption.md`](../spec-kit-adoption.md).

## Répartition des responsabilités

| Objet | Responsabilité |
|---|---|
| `.github/copilot-instructions.md` | Règles permanentes chargées par Copilot : rôles, garde-fous, gestion Git/PR, protection du périmètre, fin de tâche. |
| `setup/user-skills/product-orchestrator/SKILL.md` | Détection du contexte, choix du mode, routage et garde-fous cross-repo. |
| `.github/agents/orchestrator-automation.agent.md` | Décisions GitHub routinières isolées : merge, fermeture d'issue, passage à l'issue suivante, Project/milestone, nettoyage de branche. |
| `.github/prompts/*.prompt.md` | Procédure opérationnelle détaillée de chaque mode. C'est la source d'autorité comportementale par mode. |
| `docs/copilot/tooling-policy.md` | Politique des surfaces et modèles autorisés (Copilot-only pour la gouvernance et la vérification indépendante). |
| `templates/product-agent-template/` | Version reproductible des instructions, prompts et skill pour les repositories projets. |
| `projects.yaml` | Registre multi-projets du repository central. |

## Modes disponibles

| Mode | Objectif | Procédure d'autorité |
|---|---|---|
| `DISCOVER` | Cadrer un nouveau projet sans créer de ressource GitHub. | `.github/prompts/discover.prompt.md` |
| `BOOTSTRAP` | Initialiser un projet GitHub après validation explicite du plan. | `.github/prompts/bootstrap.prompt.md` |
| `ADOPT` | Inscrire un projet brownfield dans le framework sans remettre en question l'existant. | `.github/prompts/adopt.prompt.md` |
| `RESUME` | Reprendre un projet existant depuis l'état GitHub réel. | `.github/prompts/resume.prompt.md` |
| `STATUS` | Restituer l'état d'un projet sans implémenter. | `.github/prompts/status.prompt.md` |
| `REPLAN` | Proposer une évolution du plan après écart ou changement de contexte. | `.github/prompts/replan.prompt.md` |
| `CLOSE` | Vérifier les critères, clôturer et capitaliser si nécessaire. | `.github/prompts/close.prompt.md` |

## Workflow de delivery d'un projet

Depuis BOOTSTRAP, le workflow cible est :

PRD → Solution Design → revue indépendante → validation PM → ADR nécessaires → plan
d'implémentation → issues → développement (piloté par spec-kit) → contrôle de
conformité → Pull Request → fusion → mise à jour documentaire.

L'exécution (spec, plan, tâches, implémentation) est prise en charge par spec-kit.
Ce que ce repository apporte en complément : voir [`docs/spec-kit-adoption.md`](../spec-kit-adoption.md).

## Autonomie opérationnelle

Copilot exécute les opérations Git et GitHub routinières sans validation PM lorsque les
critères approuvés sont couverts, les contrôles passent, la vérification indépendante
Copilot est enregistrée si requise et aucun arbitrage produit n'est ouvert.

Le PM reste sollicité pour les validations de plan, changements de périmètre, Solution
Design, risques significatifs, conflits de gouvernance, coûts/services, sécurité,
confidentialité, production, migrations destructives et décisions difficiles à inverser.

## Invocation

- **Copilot CLI** : utiliser la skill `product-orchestrator` installée via `setup/install.ps1`.
- **VS Code Copilot Chat** : les prompt files `.github/prompts/*.prompt.md` sont utilisés comme entrées natives.

## Garde-fous non dédupliqués

- aucune ressource GitHub avant validation explicite du plan ;
- aucune implémentation prématurée pour une demande de nouveau projet ;
- une seule issue principale en cours ;
- reprise depuis GitHub et `projects.yaml`, jamais depuis la mémoire du chat seule.
