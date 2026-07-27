---
agent: agent
description: Reprendre l'état du projet depuis GitHub (issues, Project, PRs)
---

# RESUME — Reprise de projet

Mode : RESUME

## Instructions pour Copilot

1. Lire `docs/product/plan.md` de ce repository.
2. Vérifier le statut de `docs/solution-design/solution-design.md`.
3. Récupérer les issues ouvertes et le GitHub Project associé.
4. Identifier l'unique issue `In progress` ou la prochaine issue `Ready`.
5. Récupérer les pull requests ouvertes et leur état CI.
6. Restituer un résumé d'état complet au PM avant toute action observable.
7. Si le Solution Design n'est pas `Approved`, rester en préparation/design et ne pas implémenter.
8. Si le Solution Design est `Approved`, qu'aucune issue principale n'est déjà en cours, qu'une issue `Ready` a des critères clairs et qu'aucun arbitrage produit n'est ouvert, démarrer l'implémentation sans demander au PM de valider le passage à l'issue suivante.
9. Demander une décision PM uniquement si le périmètre, la priorité, les critères, le statut GitHub ou le risque ne permettent pas de choisir objectivement la prochaine action.
10. En cas d'hésitation opérationnelle sur `merge_pr`, `close_issue`, `start_next_issue`, `update_project` ou `cleanup_branch`, déléguer la décision à l'agent `.github/agents/orchestrator-automation.agent.md` et suivre son verdict (`proceed`, `proceed_with_log`, `ask_pm`, `blocked`).

## Résumé d'état à fournir

- Milestone courante et progression.
- Issue en cours (si existante) : titre, critères, blocages.
- Prochaine issue prioritaire (si aucune en cours).
- PRs ouvertes et état CI.
- Écarts identifiés entre l'état actuel et le plan.
- Statut du Solution Design, revue indépendante, validation PM et ADR nécessaires.

## Contraintes

- Reprendre l'état depuis GitHub, jamais depuis la mémoire du chat seule.
- Ne jamais démarrer l'implémentation sans Solution Design `Approved`.
- Ne pas demander au PM de valider une transition d'issue ou une reprise lorsque les critères d'auto-progression sont satisfaits.
- Ne pas assumer qu'un travail est terminé sans PR liée et vérification indépendante enregistrée.
- Si une seule issue "In progress" ne peut pas être confirmée sans ambiguïté, le signaler avant de continuer.
