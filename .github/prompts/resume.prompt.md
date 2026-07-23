---
agent: agent
description: Reprendre un projet existant depuis l'état GitHub
---

# RESUME — Reprise de projet

Mode : RESUME
Projet : [nom du projet]

## Instructions pour Copilot

1. Lire `projects.yaml` pour localiser le repository du projet.
2. Charger `docs/product/plan.md` depuis le repository du projet.
3. Récupérer les issues ouvertes et le GitHub Project.
4. Identifier l'unique issue `In progress` ou la prochaine issue `Ready`.
5. Récupérer les pull requests ouvertes et leur état CI.
6. Restituer un résumé d'état complet au PM avant toute action.
7. Attendre validation du PM avant d'implémenter.

## Résumé d'état à fournir

- Milestone courante et progression.
- Issue en cours (si existante) : titre, critères, blocages.
- Prochaine issue prioritaire (si aucune en cours).
- PRs ouvertes et état CI.
- Écarts identifiés entre l'état actuel et le plan.

## Contraintes

- Ne jamais démarrer l'implémentation sans restituer l'état et attendre confirmation.
- L'état provient de GitHub, pas de la mémoire du chat.
