# Migration depuis la version Claude

Ce document trace la migration du repository `florent-product-lab` depuis une orchestration Claude Code vers une orchestration GitHub Copilot-first.

- **Date de migration :** 2026-07-15
- **Branche cible :** `copilot-main`
- **Décision de suppression :** les fichiers Claude actifs ont été supprimés ; l'historique Git conserve la traçabilité complète.

> **Addendum (2026-07-15, même jour) :** `COPILOT.md` (racine et template), créé lors de cette
> migration, a ensuite été fusionné dans `.github/copilot-instructions.md` puis supprimé.
> Cause : `COPILOT.md` n'est pas un fichier nativement chargé par GitHub Copilot — seul
> `.github/copilot-instructions.md` l'est. L'indirection ("lire COPILOT.md avant toute
> action") s'est révélée non fiable et a contribué à un drift de gouvernance observé sur un
> projet enfant. Voir `/memories/session/plan-remediation-gouvernance.md` pour le détail.
> Toutes les mentions de `COPILOT.md` ci-dessous reflètent l'état à la date de la migration
> Claude→Copilot, avant cette correction ultérieure.

---

## Ce qui a été conservé

Ces éléments sont indépendants de l'outil IA et ont été préservés sans modification fonctionnelle.

| Élément | Chemin | Raison |
|---|---|---|
| Registre multi-projets | `projects.yaml` | Catalogue produit, outil-agnostique |
| Règles globales actives | `memory/global-learnings.yaml` | Mémoire globale inter-projets |
| Gouvernance mémoire | `memory/README.md` | Principe de promotion globale, outil-agnostique (référence `.claude/...` mise à jour) |
| Plan produit canonique | `templates/product-agent-template/docs/product/plan.md` | Format produit indépendant |
| PR template | `templates/product-agent-template/.github/PULL_REQUEST_TEMPLATE.md` | Checklist de vérification indépendante |
| Registre d'apprentissages template | `templates/product-agent-template/docs/learnings/learning-log.yaml` | Modèle de données (commentaire de référence mis à jour) |

---

## Ce qui a été modifié

Ces éléments ont été adaptés pour pointer vers la nouvelle architecture Copilot.

| Fichier modifié | Modification |
|---|---|
| `README.md` | Réécrit entièrement (était vide) ; décrit l'usage Copilot-first, la structure, les conventions et les sources de vérité |
| `.gitignore` | Exclusion `.claude/settings.local.json` remplacée par un commentaire Copilot |
| `memory/README.md` | Référence `.claude/skills/product-project-orchestrator/references/learning-lifecycle.md` remplacée par `docs/copilot/learning-lifecycle.md` |
| `templates/product-agent-template/README.md` | "contexte Claude Code" remplacé par "contexte GitHub Copilot configuré" |
| `templates/product-agent-template/.gitignore` | Exclusion `.claude/settings.local.json` remplacée par un commentaire Copilot |
| `templates/product-agent-template/docs/learnings/README.md` | Chemin `.claude/skills/...` remplacé par `docs/copilot/learning-lifecycle.md` |
| `templates/product-agent-template/docs/learnings/learning-log.yaml` | Commentaire de référence mis à jour vers `docs/copilot/learning-lifecycle.md` |

---

## Ce qui a été supprimé

| Fichier supprimé | Raison |
|---|---|
| `CLAUDE.md` | Remplacé par `COPILOT.md` (contenu traduit, gouvernance préservée) |
| `.claude/skills/product-project-orchestrator/SKILL.md` | Orchestration Claude Code ; remplacée par `docs/copilot/orchestration.md` + `prompts/copilot/` |
| `.claude/skills/product-project-orchestrator/references/learning-lifecycle.md` | Migré vers `docs/copilot/learning-lifecycle.md` |
| `.claude/skills/product-project-orchestrator/references/independent-verification.md` | Migré vers `docs/copilot/independent-verification.md` |
| `templates/product-agent-template/CLAUDE.md` | Remplacé par `templates/product-agent-template/COPILOT.md` (contenu identique) |

---

## Ce qui a été créé

| Fichier créé | Rôle |
|---|---|
| `.github/copilot-instructions.md` | Point d'entrée natif GitHub Copilot — instructions automatiquement lues à chaque session |
| `COPILOT.md` | Contrat de gouvernance actif — rôles, règles, sources de vérité, protection du périmètre, fin de tâche |
| `docs/copilot/orchestration.md` | Documentation des modes DISCOVER/BOOTSTRAP/RESUME/STATUS/REPLAN/CLOSE en tant que workflows Copilot |
| `docs/copilot/learning-lifecycle.md` | Cycle de vie des apprentissages locaux (traduit depuis `.claude/...`) |
| `docs/copilot/independent-verification.md` | Niveaux de vérification indépendante (traduit depuis `.claude/...`) |
| `docs/copilot/MIGRATION_FROM_CLAUDE.md` | Ce fichier |
| `prompts/copilot/README.md` | Index des prompts Copilot |
| `prompts/copilot/discover.prompt.md` | Prompt mode DISCOVER |
| `prompts/copilot/bootstrap.prompt.md` | Prompt mode BOOTSTRAP |
| `prompts/copilot/resume.prompt.md` | Prompt mode RESUME |
| `prompts/copilot/status.prompt.md` | Prompt mode STATUS |
| `prompts/copilot/replan.prompt.md` | Prompt mode REPLAN |
| `prompts/copilot/close.prompt.md` | Prompt mode CLOSE |
| `templates/product-agent-template/COPILOT.md` | Instructions Copilot du template projet (contenu identique à l'ancien CLAUDE.md) |

---

## Raisons des changements

**Suppression plutôt qu'archivage des fichiers Claude actifs** : l'historique Git conserve la traçabilité complète. Un archivage dans le repo cible aurait introduit des références Claude actives dans un repo Copilot-first, créant une ambiguïté sur quel système est l'autorité.

**Pas de dossier `.copilot/skills/`** : GitHub Copilot ne dispose pas (à la date de cette migration) d'un mécanisme d'autodiscovery de skills équivalent à Claude Code. La logique d'orchestration est portée par `.github/copilot-instructions.md` (instructions natives), `COPILOT.md` (gouvernance lisible), `docs/copilot/` (documentation longue) et `prompts/copilot/` (prompts actionnables).

**Conservation de la substance de gouvernance** : les 11 règles fondamentales, les sources de vérité, la protection du périmètre, les critères de fin de tâche et les niveaux de vérification indépendante sont des règles produit outil-agnostiques. Elles ont été intégralement traduites dans la nouvelle architecture.

---

## Références Claude résiduelles

**Aucune référence Claude active ne subsiste dans le repository.**

Les seules occurrences du mot "Claude" se trouvent dans ce fichier de migration, en tant que contexte historique.

Vérification :
```bash
rg -n "Claude|CLAUDE|claude|Claude Code|\.claude" --glob '!docs/copilot/MIGRATION_FROM_CLAUDE.md'
```
Résultat attendu : aucune occurrence.
