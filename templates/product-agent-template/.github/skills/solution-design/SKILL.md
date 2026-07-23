---
name: solution-design
description: "Produit un Solution Design proportionné avant développement. Lit le PRD, l'existant et les décisions, identifie les inconnues, choisit le niveau Léger/Standard/Renforcé, compare les options, prépare la synthèse PM et bloque le passage prématuré au code."
argument-hint: "<objectif ou issue optionnelle>"
---

# Solution Design

Cette skill intervient après le PRD validé et avant toute issue de développement.

## Garde-fou

Ne produire aucun code fonctionnel et ne marquer aucune issue de développement `Ready`
tant que `docs/solution-design/solution-design.md` n'est pas au statut `Approved`.

Avant approbation, seules sont autorisées : exploration, clarification, recherche
documentaire, comparaison d'options, prototype jetable explicitement autorisé et preuve
de faisabilité non fusionnée dans le produit.

## Procédure

1. Lire `docs/product/plan.md`, `docs/solution-design/solution-design.md` s'il existe,
   `docs/decisions/` et les issues/PRs ouvertes.
2. Inspecter uniquement les fichiers nécessaires pour comprendre l'existant.
3. Identifier les inconnues et questions PM.
4. Choisir le niveau de design : Léger, Standard ou Renforcé.
5. Comparer les options proportionnellement au risque.
6. Évaluer réutilisation native, dépendances existantes, open source, sécurité,
   authentification, UI/design system et exigences non fonctionnelles lorsque concernés.
7. Utiliser Context7 uniquement pour les décisions dépendant d'une technologie/version
   actuelle, selon `docs/context7.md`.
8. Renseigner `docs/solution-design/solution-design.md`.
9. Préparer une synthèse décisionnelle courte pour le PM : recommandation, options,
   compromis, risques, dépendances structurantes et réversibilité.

## Sortie attendue

- Solution Design complété au niveau proportionné.
- Décisions PM explicites listées.
- ADR nécessaires identifiés.
- Aucun développement lancé.
