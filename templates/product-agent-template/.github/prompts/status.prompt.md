---
agent: agent
description: Restituer l'état du projet sans implémenter
---

# STATUS — État de projet

Mode : STATUS

## Instructions pour Copilot

1. Charger `docs/product/plan.md`.
2. Récupérer les issues du GitHub Project (ouvertes et fermées par milestone).
3. Récupérer les PRs ouvertes.
4. Restituer le tableau de bord complet.

## Output attendu

| Élément | Détail |
|---|---|
| Milestone courante | Nom, date cible, avancement (issues fermées / total) |
| Issues ouvertes | Titre, statut, assignée, blocages |
| Issues fermées | Nombre par milestone |
| PRs ouvertes | Titre, CI, révision |
| Alignement plan | Écarts identifiés entre l'état actuel et le plan approuvé |
| Risques actifs | Risques ouverts identifiés dans le plan |

## Contraintes

- Mode lecture seule. Aucune modification.
- Si un écart significatif est identifié, le signaler et proposer un mode REPLAN.
