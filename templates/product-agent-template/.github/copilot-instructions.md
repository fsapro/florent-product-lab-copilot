# GitHub Copilot — Instructions

Moteur d'execution de ce projet : **spec-kit**. Ce fichier fixe les regles permanentes
de gouvernance qui s'appliquent par-dessus la constitution spec-kit.

---

## Moteur d'execution

```
speckit-specify   -> PRD structure
speckit-clarify   -> resolution des ambiguites avant design
speckit-plan      -> Solution Design (research.md, data-model.md, contracts/)
speckit-analyze   -> Constitution Check avant validation PM
speckit-tasks     -> tasks.md avec criteres d'acceptation (Principe VI)
speckit-implement -> execution d'une tache
speckit-converge  -> reprise d'une tache bloquee ou a reconcilier
```

## Deux gates PM obligatoires

1. **Apres speckit-plan** : le PM valide le design (solution, risques, reversibilite)
   avant toute creation de tache.
2. **Apres speckit-analyze** : aucune tache ne demarre si le resultat contient un CRITICAL.

Aucun developpement fonctionnel sans les deux gates valides.

---

## Regle anti-implementation prematuree

Ne jamais creer de code ni modifier des fichiers fonctionnels sans :
un plan valide par le PM, un `speckit-analyze` sans CRITICAL, et une tache dans `tasks.md`.

---

## Gestion autonome de Git et des Pull Requests

Copilot gere seul branches, commits, push, Pull Requests, corrections, fusion.
Copilot fournit une synthese decisionnelle courte : statut, objectif, controles, risques.
Copilot sollicite le PM pour : changement de perimetre, risque significatif, service payant,
securite/confidentialite, migration destructive, decision difficile a inverser.

Avant tout commit : inspecter `git status` + `git diff --stat`, ne stager que les fichiers
lies a la tache. Ne jamais utiliser `git add -A` sans revue explicite.

---

## Verification independante

Un changement significatif est verifie par une session Copilot distincte de l'implementeur
avant validation PM. Voir `docs/independent-verification.md`.

Surfaces valides : VS Code Copilot Chat, Copilot CLI. Claude CLI, Claude Code et LLM
externes ne produisent pas de verdict opposable.

---

## Apprentissages

Par defaut, aucun apprentissage n'est cree. Decision en cloture de projet uniquement.
Voir `docs/learnings/README.md`.

---

## Sources de verite

- Produit : `docs/product/plan.md`
- Spec et plan : `.specify/` (gere par spec-kit)
- Decisions structurantes : `docs/decisions/`
- Apprentissages : `docs/learnings/learning-log.yaml`
- Travail : GitHub Issues et GitHub Project
- Implementation et preuves : pull requests et CI
