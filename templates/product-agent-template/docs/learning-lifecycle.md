# Cycle de vie d'un apprentissage local

Référence locale à ce projet (copie adaptée de `docs/copilot/learning-lifecycle.md` du
repository méta `florent-product-lab-copilot`). Ce document couvre le registre local
d'apprentissage de ce projet. La mémoire globale et la promotion inter-projets sont hors
périmètre à ce stade.

---

## Principe de création

Par défaut, aucun apprentissage n'est créé.

Un apprentissage local n'est créé que si le coût de la non-capitalisation (probabilité de
répétition × impact) est supérieur au coût de maintenance de l'apprentissage (lecture, mise
à jour, obsolescence). Cette évaluation reste qualitative et rapide.

Une observation isolée, mineure, déjà couverte par un contrôle existant, ou sans valeur de
réutilisation crédible n'est pas enregistrée. En cas de doute, ne pas créer.

---

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
created_by: copilot
qualified_at: null
approved_by: null
```

---

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

Seuls `observed`, `qualified`, `applied_locally`, `rejected` et `superseded` sont utilisés en
pratique à ce stade. `promotion_candidate` et `promoted` supposent un mécanisme de promotion
globale porté par le repository méta, non déclenché depuis ce projet.

---

## Portée

```yaml
learning_scope:
  - task
  - project
  - stack
  - global
```

Seule la portée `project` est active depuis ce repository. Une promotion `global` se décide
et se documente dans le repository méta `florent-product-lab-copilot`.

---

## Catégories

- `requirement_gap`
- `implementation_error`
- `verification_gap`
- `regression`
