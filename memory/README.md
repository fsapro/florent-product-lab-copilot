# Mémoire globale

Registre des règles actives partagées entre tous les projets du système d'exécution produit de Florent.

## Principe

Par défaut, aucune règle globale n'existe.

Une règle globale est très rare : elle ne couvre qu'un apprentissage réellement réutilisable au-delà d'un seul projet, jamais une préférence ou une observation locale. Hiérarchie attendue :

- par défaut : aucun apprentissage (voir `docs/learnings/README.md` de chaque projet) ;
- apprentissage local : rare ;
- règle globale : très rare.

Ce registre doit rester minuscule. Une mémoire globale volumineuse est un échec de ce principe, pas un signe de maturité.

## D'où vient un candidat

Un candidat de promotion globale n'est jamais collecté automatiquement. Il naît d'un apprentissage local déjà qualifié (`status: promotion_candidate`, `scope_candidate: global` dans le `docs/learnings/learning-log.yaml` d'un projet — voir `.claude/skills/product-project-orchestrator/references/learning-lifecycle.md`).

Aucun fichier de candidats séparé n'existe : la revue se fait par lecture directe du ou des `learning-log.yaml` concernés, à la demande explicite de Florent.

## Gate de promotion

Une règle ne devient active dans `global-learnings.yaml` que si toutes les conditions suivantes sont réunies :

- une preuve est liée (issue, PR, test ou observation) ;
- la cause racine est comprise ;
- l'apprentissage est réellement réutilisable au-delà d'un seul projet ;
- la règle est actionnable, formulée sans ambiguïté ;
- la règle est testable ou vérifiable ;
- la portée n'est pas spécifique à un projet ;
- aucune règle existante ne couvre déjà ce cas (vérification manuelle simple : relire `global-learnings.yaml`, qui reste volontairement petit) ;
- aucune règle active ne la contredit ;
- l'approbation explicite de Florent est enregistrée (`approved_by`, `approved_at`).

## Seuil de promotion

- Occurrence unique suffisante : risque de sécurité, risque de confidentialité, opération destructive, impact sévère et irréversible.
- Récurrence ou confirmation préférable : friction de workflow, pattern d'implémentation, convention de qualité, pratique documentaire.

## Modèle d'une règle globale

```yaml
id: GLB-VER-NNN
title: "Titre court"
status: active
category: verification
rule: "Règle actionnable et non ambiguë"
trigger:
  - user_visible_behavior
action:
  - run_independent_verification
exceptions:
  - documentation_only
evidence:
  - project: project-slug
    issue: "<issue-reference>"
approved_by: Florent
approved_at: "<ISO-8601>"
review_when:
  - conflicting_evidence
  - repeated_false_positive
```

`status` vaut `active` ou `superseded`. Une règle obsolète reste dans ce même fichier avec `status: superseded` — aucun fichier séparé n'est créé pour l'historique tant que le volume ne le justifie pas.

## Ce que ce fichier n'est pas

- Pas de collecte automatisée de candidats.
- Pas de fichier séparé pour les candidats ou pour les règles obsolètes.
- Pas de revue périodique ou déclenchée par seuil.
- Pas de déduplication ou de résolution de conflit automatisée — une vérification manuelle suffit tant que le fichier reste petit.
- Pas de chargement sélectif avancé — le fichier est lu intégralement lorsque nécessaire, tant que sa taille le permet.

Ces mécanismes, s'ils deviennent nécessaires un jour, sont hors périmètre de cet incrément et attendent un besoin observé.
