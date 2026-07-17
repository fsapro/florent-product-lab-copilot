---
mode: agent
description: Inscrire un projet existant (brownfield) dans le framework sans remettre en question le travail déjà fait
---

# ADOPT — Onboarding d'un projet existant

Mode : ADOPT
Projet : [nom du projet]
Repository cible : [owner/repo existant, ou chemin local si pas encore poussé]

Prérequis : aucun plan à valider au sens DISCOVER — le travail déjà réalisé dans le repository cible est considéré comme une **baseline validée**. ADOPT ne rouvre jamais de débat sur ce qui existe déjà ; il inscrit l'existant dans le framework.

Principe directeur : le repository cible peut être dans **n'importe quel état** (aucune gouvernance, gouvernance Copilot custom, issues/PRs actives, historique long, ou quasi vide). ADOPT commence toujours par une découverte read-only complète avant le moindre geste d'écriture, et n'écrase jamais silencieusement un fichier existant.

## Instructions pour Copilot

1. **Découverte read-only (obligatoire avant tout geste).**
   - Lire le `README.md` et la structure du repository cible.
   - Lire l'historique récent (`git log --oneline -20`).
   - Vérifier la présence d'un `.github/copilot-instructions.md` existant (custom ou absent).
   - Lister les `docs/` déjà présents (plan produit, ADR, roadmap, etc.).
   - Lister les issues et PRs ouvertes (`gh issue list`, `gh pr list`) et les milestones existants.
   - Vérifier la protection de branche par défaut (`gh api repos/<repo>/branches/<default>/protection` — tolérer une erreur 403/404, cela signifie simplement que l'information n'est pas accessible ou qu'il n'y a pas de protection).
   - Vérifier la présence de CI existante (`.github/workflows/`).
   - Déterminer si le repository existe déjà sur GitHub ou seulement en local (code non encore poussé) — voir sous-cas ci-dessous.
2. **Ne jamais remettre en question l'existant.** Le travail déjà fait est traité comme une baseline validée. Ne pas proposer de refonte, ne pas challenger les choix passés — seulement identifier ce qui manque pour l'inscrire dans le framework.
3. **Détection de conflit de gouvernance.** Si `.github/copilot-instructions.md` existe déjà et diverge du template (`templates/product-agent-template/.github/copilot-instructions.md`), présenter le diff au PM et demander une décision explicite : garder l'existant / remplacer par le template / fusionner. Ne jamais écraser silencieusement.
4. **Scaffold idempotent.** Copier uniquement les fichiers du template absents du repository cible (`README.md`, `.github/copilot-instructions.md` si absent, `.github/PULL_REQUEST_TEMPLATE.md`, `.github/prompts/` locaux, `.github/skills/project-orchestrator/SKILL.md`, `docs/decisions/`, `docs/learnings/`, `docs/independent-verification.md`, `docs/learning-lifecycle.md`). Ne jamais écraser un fichier déjà présent (code, README métier, docs existants) sans confirmation explicite du PM.
5. **Reconstitution minimale du plan produit.** Générer `docs/product/plan.md` à partir de l'existant (README, issues fermées/ouvertes, milestones, docs déjà présents). Marquer explicitement chaque section reconstituée (`Reconstitué depuis l'existant — à confirmer`) par opposition aux sections confirmées par le PM. Ne demander au PM que de combler les trous, jamais de revalider l'ensemble.
6. **Registre `projects.yaml`.** Ajouter ou compléter l'entrée du projet :
   - `status: active`
   - `origin: adopted`
   - `adopted_at: <date du jour>`
   - `phases:` inférées des milestones/issues déjà existants si présents, sinon une phase unique `phase-0` nommée "Adoption" — à faire évoluer via `REPLAN` dès que le PM précise la suite.
   - Avant d'écrire, vérifier qu'une entrée avec `origin: adopted` n'existe pas déjà pour ce projet (garde-fou anti double-exécution) : si c'est le cas, avertir le PM plutôt que de relancer la séquence.
7. **Aucune création d'issue rétroactive.** Ne pas créer d'issues pour du travail déjà fait. N'en créer que pour la suite du travail, et seulement si le PM le demande explicitement (hors périmètre d'ADOPT lui-même — relève de `REPLAN`/`RESUME`).
8. **Aucune opération git destructive.** Jamais de `push --force`, jamais de réécriture d'historique (`rebase -i` sur des commits déjà partagés), jamais de suppression de branche existante.
9. **Livraison via PR par défaut.** Pousser la gouvernance ajoutée sur une branche dédiée (ex. `chore/adopt-framework-governance`) et ouvrir une PR avec `.github/PULL_REQUEST_TEMPLATE.md` du scaffold — sauf si le PM confirme explicitement que le repository est mono-contributeur sans protection de branche, auquel cas un commit direct sur la branche par défaut est acceptable. Ne jamais assumer cette confirmation : la poser comme question si l'information n'est pas déterminable via `gh api`.
10. **Vérification finale.** Appliquer les mêmes garde-fous que BOOTSTRAP :
    - le contenu ajouté est réellement présent dans le repository (lecture API, pas seulement supposé poussé) ;
    - le scaffold est complet (comparer la liste des fichiers ajoutés à la liste attendue) ;
    - `.github/copilot-instructions.md` contient les règles non-négociables **inline**, jamais un renvoi indirect.
11. **Confirmation au PM.** Restituer : lien du repository, liste des fichiers ajoutés, entrée `projects.yaml` créée/complétée, lien de la PR (ou du commit si push direct confirmé), état reconstitué du plan produit à valider section par section.

### Sous-cas — repository local non encore créé sur GitHub

Si le code existe déjà en local mais qu'aucun repository GitHub cible n'existe :
1. Confirmer avec le PM le nom et la visibilité du futur repository avant `gh repo create`.
2. Créer le repository GitHub à partir du contenu local existant (pousser l'historique local tel quel, ne jamais réinitialiser l'historique).
3. Poursuivre ensuite la séquence ADOPT normalement (étapes 3 à 11) une fois le repository distant en place.

## Contraintes

- Ne jamais exécuter ADOPT sans avoir d'abord réalisé la découverte read-only complète (étape 1).
- Ne jamais écraser un fichier existant sans confirmation explicite du PM.
- Ne jamais créer d'issue pour du travail déjà réalisé.
- Ne jamais effectuer d'opération git destructive (force-push, réécriture d'historique, suppression de branche).
- Ne jamais pousser directement sur la branche par défaut d'un repository ayant des collaborateurs ou une protection de branche sans confirmation explicite du PM.
- Ne jamais relancer ADOPT sur un projet déjà marqué `origin: adopted` sans avertir le PM.

## Pièges connus

- Un `.github/copilot-instructions.md` existant mais incomplet peut sembler « déjà présent » alors qu'il ne contient pas les règles inline requises — toujours comparer son contenu à celui du template, pas seulement sa présence.
- Un repository avec des issues actives peut donner l'impression qu'il faut les réorganiser pour coller au template `phases`/`milestones` — ADOPT ne fait que les recenser, jamais les restructurer sans décision explicite du PM (relève de `REPLAN`).
- Une branche par défaut protégée empêche un push direct : découvrir cette contrainte en amont (étape 1) évite un échec en fin de séquence après reconstitution du plan.
- Reconstituer un plan produit trop détaillé à partir de peu d'éléments peut créer une fausse impression de validation — toujours marquer explicitement les sections reconstituées comme « à confirmer ».

## Output attendu

Registre `projects.yaml` mis à jour (`origin: adopted`), gouvernance minimale présente dans le repository cible (complétée, jamais écrasée), plan produit reconstitué a minima et soumis à confirmation du PM, PR ouverte (ou commit direct si confirmé) contenant les ajouts, état restitué au PM avec liens directs.
