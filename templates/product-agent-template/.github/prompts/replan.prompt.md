---
mode: agent
description: Proposer une évolution du plan après un changement de contexte
---

# REPLAN — Évolution du plan

Mode : REPLAN

## Instructions pour Copilot

1. Charger l'état actuel depuis GitHub (même procédure que RESUME).
2. Identifier l'écart entre l'état actuel et le plan approuvé (`docs/product/plan.md`).
3. Analyser la cause : hypothèse invalidée, nouveau besoin, contrainte émergente.
4. Proposer des ajustements au plan : périmètre, milestones, critères.
5. Présenter les options avec leurs compromis.
6. Attendre la validation explicite du PM avant toute modification.

## Contraintes

- Ne pas modifier le plan, les issues ou les milestones sans validation explicite.
- Tout ajout de périmètre doit être justifié et délimité.
- Tout retrait de périmètre doit être documenté comme décision dans `docs/decisions/`.

## Output attendu

Analyse de l'écart, options de replanification avec compromis, recommandation, prête pour arbitrage par le PM.
