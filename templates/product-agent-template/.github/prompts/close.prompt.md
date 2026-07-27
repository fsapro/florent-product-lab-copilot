---
agent: agent
description: Vérifier et clôturer le projet
---

# CLOSE — Clôture de projet

Mode : CLOSE

## Instructions pour Copilot

1. Charger l'état complet depuis GitHub.
2. Vérifier chaque critère d'acceptation du plan approuvé (`docs/product/plan.md`).
3. Confirmer que toutes les issues de la milestone finale sont fermées.
4. Vérifier la conformité au Solution Design approuvé et aux ADR applicables.
5. Confirmer que les contrôles CI passent.
6. Vérifier que le verdict de vérification indépendante est enregistré pour les changements significatifs et qu'il provient d'une surface GitHub Copilot approuvée (voir `.github/copilot-instructions.md`, `docs/independent-verification.md` et `docs/tooling-policy.md`).
7. Si tous les critères sont couverts, que les contrôles passent, que la vérification indépendante Copilot est valide si requise et qu'aucun arbitrage produit n'est ouvert, fusionner/fermer les PRs et issues restantes sans demander de validation PM supplémentaire.
8. En cas d'hésitation opérationnelle sur `merge_pr`, `close_issue`, `update_project` ou `cleanup_branch`, déléguer la décision à l'agent `.github/agents/orchestrator-automation.agent.md` et suivre son verdict (`proceed`, `proceed_with_log`, `ask_pm`, `blocked`).
9. Évaluer la capitalisation : un apprentissage local mérite-t-il d'être créé ? (voir `docs/learnings/README.md`)
10. Fournir la synthèse décisionnelle finale au PM.

## Checklist de clôture

- [ ] Tous les critères d'acceptation couverts
- [ ] Toutes les issues de la milestone finale fermées
- [ ] Contrôles CI passants
- [ ] Conformité au Solution Design approuvé et aux ADR applicables
- [ ] Vérification indépendante Copilot enregistrée (si changement significatif)
- [ ] Aucune réserve produit ou décision PM ouverte
- [ ] Documentation à jour
- [ ] Issues et PRs reliées et fermées
- [ ] Décision de capitalisation prise (apprentissage local créé ou non)

## Contraintes

- Ne pas déclarer le projet clos sans que tous les critères soient couverts.
- Ne pas demander au PM de valider une fusion, une fermeture d'issue ou un passage de statut si les critères de clôture sont objectivement satisfaits.
- La création d'un apprentissage n'est pas obligatoire ; la décision l'est.
