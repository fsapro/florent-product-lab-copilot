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
3. Vérifier l'état du plan spec-kit (`.specify/`) s'il existe.
4. Récupérer les issues ouvertes et le GitHub Project.
5. Identifier l'unique issue `In progress` ou la prochaine issue `Ready`.
6. Récupérer les pull requests ouvertes et leur état CI.
7. Restituer un résumé d'état complet au PM avant toute action observable.
8. Si `speckit-analyze` retourne des CRITICAL non résolus, rester en préparation/design et ne pas implémenter.
9. Si le plan spec-kit est prêt, qu'aucune issue principale n'est déjà en cours, qu'une issue `Ready` a des critères clairs et qu'aucun arbitrage produit n'est ouvert, démarrer l'implémentation sans demander au PM de valider le passage à l'issue suivante.
10. Demander une décision PM uniquement si le périmètre, la priorité, les critères, le statut GitHub ou le risque ne permettent pas de choisir objectivement la prochaine action.
11. En cas d'hésitation opérationnelle sur `merge_pr`, `close_issue`, `start_next_issue`, `update_project` ou `cleanup_branch`, déléguer la décision à l'agent `.github/agents/orchestrator-automation.agent.md` et suivre son verdict (`proceed`, `proceed_with_log`, `ask_pm`, `blocked`).

## Résumé d'état à fournir

- Milestone courante et progression.
- Issue en cours (si existante) : titre, critères, blocages.
- Prochaine issue prioritaire (si aucune en cours).
- PRs ouvertes et état CI.
- Écarts identifiés entre l'état actuel et le plan.
- Statut du Solution Design, revue indépendante, validation PM et ADR nécessaires.

## Contraintes

- Ne jamais démarrer l'implémentation sans restituer l'état.
- Ne jamais démarrer l'implémentation sans Solution Design `Approved`.
- Ne pas demander au PM de valider une transition d'issue ou une reprise lorsque les critères d'auto-progression sont satisfaits.
- L'état provient de GitHub, pas de la mémoire du chat.
