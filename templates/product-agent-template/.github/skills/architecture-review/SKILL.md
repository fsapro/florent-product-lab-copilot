---
name: architecture-review
description: "Réalise une revue indépendante du Solution Design avant validation PM. Vérifie l'alignement PRD, les hypothèses, impacts métier/données/applications/technologie, risques, sur-ingénierie et rend un verdict Approved, Changes requested ou Blocked."
argument-hint: "<chemin du Solution Design optionnel>"
---

# Architecture Review

Cette skill vérifie le Solution Design depuis un contexte distinct de l'auteur.

## Entrées

- `docs/product/plan.md`
- `docs/solution-design/solution-design.md`
- `docs/decisions/`
- fichiers du repository strictement nécessaires à la vérification

## Revue

1. Vérifier l'alignement avec le PRD et le périmètre.
2. Challenger les hypothèses et inconnues.
3. Vérifier les impacts métier, données, applications, technologie et exploitation
   lorsque concernés.
4. Vérifier sécurité, authentification, exigences non fonctionnelles, migration,
   rollback et réversibilité lorsque concernés.
5. Identifier les risques non traités et la sur-ingénierie.
6. Vérifier que les dépendances, composants open source et design system sont justifiés.
7. Vérifier que les tests proposés sont proportionnés au risque.

## Verdict

Rendre un verdict unique :

- `Approved` : le design peut passer en validation PM.
- `Changes requested` : le design doit être ajusté.
- `Blocked` : une décision ou information manque.

Le rapport doit être court : décision, raisons, risques résiduels, corrections requises.
