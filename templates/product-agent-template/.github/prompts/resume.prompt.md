---
mode: agent
description: Reprendre l'état du projet depuis GitHub (issues, Project, PRs)
---

# RESUME — Reprise de projet

Mode : RESUME

## Instructions pour Copilot

1. Lire `docs/product/plan.md` de ce repository.
2. Récupérer les issues ouvertes et le GitHub Project associé.
3. Identifier l'unique issue `In progress` ou la prochaine issue `Ready`.
4. Récupérer les pull requests ouvertes et leur état CI.
5. Restituer un résumé d'état complet au PM avant toute action.
6. Attendre validation du PM avant d'implémenter.

## Résumé d'état à fournir

- Milestone courante et progression.
- Issue en cours (si existante) : titre, critères, blocages.
- Prochaine issue prioritaire (si aucune en cours).
- PRs ouvertes et état CI.
- Écarts identifiés entre l'état actuel et le plan.

## Contraintes

- Reprendre l'état depuis GitHub, jamais depuis la mémoire du chat seule.
- Ne pas assumer qu'un travail est terminé sans PR liée et vérification indépendante enregistrée.
- Si une seule issue "In progress" ne peut pas être confirmée sans ambiguïté, le signaler avant de continuer.
