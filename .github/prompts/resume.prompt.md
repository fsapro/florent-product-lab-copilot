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
3. Vérifier le statut du Solution Design (`docs/solution-design/solution-design.md`) s'il existe.
4. Récupérer les issues ouvertes et le GitHub Project.
5. Identifier l'unique issue `In progress` ou la prochaine issue `Ready`.
6. Récupérer les pull requests ouvertes et leur état CI.
7. Restituer un résumé d'état complet au PM avant toute action.
8. Si le Solution Design n'est pas `Approved`, rester en préparation/design et ne pas implémenter.
9. Attendre validation du PM avant d'implémenter.

## Résumé d'état à fournir

- Milestone courante et progression.
- Issue en cours (si existante) : titre, critères, blocages.
- Prochaine issue prioritaire (si aucune en cours).
- PRs ouvertes et état CI.
- Écarts identifiés entre l'état actuel et le plan.
- Statut du Solution Design, revue indépendante, validation PM et ADR nécessaires.

## Contraintes

- Ne jamais démarrer l'implémentation sans restituer l'état et attendre confirmation.
- Ne jamais démarrer l'implémentation sans Solution Design `Approved`.
- L'état provient de GitHub, pas de la mémoire du chat.
