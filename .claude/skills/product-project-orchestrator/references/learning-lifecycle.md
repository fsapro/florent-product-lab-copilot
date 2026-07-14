# Cycle de vie d'un apprentissage local

Référence de la skill `product-project-orchestrator`.

Ce document couvre uniquement le registre local d'apprentissage d'un projet (Incrément 2). La mémoire globale, la promotion inter-projets, le scoring et la qualification assistée sont hors périmètre et traités par des incréments ultérieurs.

## Principe de création

Par défaut, aucun apprentissage n'est créé.

Un apprentissage local n'est créé que si le coût de la non-capitalisation (probabilité de répétition × impact) est supérieur au coût de maintenance de l'apprentissage (lecture, mise à jour, obsolescence). Cette évaluation reste qualitative et rapide ; aucun système de scoring n'est introduit.

Une observation isolée, mineure, déjà couverte par un contrôle existant, ou sans valeur de réutilisation crédible n'est pas enregistrée. En cas de doute, ne pas créer.

## Modèle minimal d'un apprentissage

```yaml
id: LRN-YYYY-NNN
status: observed
project: project-slug
category: verification_gap
observation: "Description factuelle de ce qui s'est produit"
impact: "Conséquence réelle ou potentielle"
root_cause:
  status: confirmed
  description: "Cause vérifiée"
detection_gap: "Pourquoi les contrôles existants n'ont pas détecté l'écart"
correction: "Correction réalisée"
prevention_candidate:
  type: test
  description: "Mécanisme proposé pour empêcher la répétition"
scope_candidate: project
confidence: high
tags:
  - api
evidence:
  issue: null
  pull_request: null
  test: null
  ci_run: null
created_at: "<ISO-8601>"
created_by: claude
qualified_at: null
approved_by: null
```

## Statuts

```yaml
learning_status:
  - observed
  - qualified
  - applied_locally
  - validated
  - promotion_candidate
  - promoted
  - rejected
  - superseded
```

À ce stade (Incrément 2), seuls `observed`, `qualified`, `applied_locally`, `rejected` et `superseded` sont utilisés en pratique. `promotion_candidate` et `promoted` supposent une mémoire globale et un mécanisme de promotion (Incrément 3, hors périmètre) — un candidat de promotion identifié en mode `CLOSE` reste noté (`scope_candidate` renseigné) sans être activé.

## Portée

```yaml
learning_scope:
  - task
  - project
  - stack
  - global
```

À ce stade, seule la portée `project` est active. `stack` et `global` sont des valeurs réservées pour des incréments ultérieurs — ne pas les utiliser avant que ces mécanismes existent.

## Catégories initiales

- `requirement_gap`
- `implementation_error`
- `verification_gap`
- `regression`
- `tooling_failure`
- `process_failure`
- `documentation_gap`
- `security_or_safety`

Aucune sous-catégorie ni taxonomie additionnelle n'est introduite à ce stade.

## Exigence de qualification

Un apprentissage passe de `observed` à `qualified` uniquement s'il possède :
- une preuve (`evidence`) lorsque celle-ci existe ;
- un `detection_gap` renseigné (pourquoi les contrôles existants n'ont pas détecté l'écart).

Une observation non qualifiée reste `observed` et ne devient jamais une règle appliquée.

## Décision de capitalisation en clôture de projet

Le mode `CLOSE` de l'orchestrateur impose une décision explicite, pour les écarts notables identifiés pendant la rétrospective, parmi trois options :
- aucun apprentissage ;
- apprentissage local créé (référence `LRN-YYYY-NNN`, ajoutée à `docs/learnings/learning-log.yaml`) ;
- candidat de promotion identifié (`scope_candidate` renseigné, noté mais non activé — la promotion elle-même est hors périmètre de cet incrément).

Cette décision est obligatoire. La création d'un apprentissage ne l'est pas : « aucun apprentissage » reste le choix par défaut et le plus fréquent attendu.
