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
6. Vérifier que le verdict de vérification indépendante est enregistré pour les changements significatifs (voir la section correspondante de `.github/copilot-instructions.md`).
7. Évaluer la capitalisation : un apprentissage local mérite-t-il d'être créé ? (voir `docs/learnings/README.md`)
8. Fournir la synthèse décisionnelle finale au PM.

## Checklist de clôture

- [ ] Tous les critères d'acceptation couverts
- [ ] Toutes les issues de la milestone finale fermées
- [ ] Contrôles CI passants
- [ ] Conformité au Solution Design approuvé et aux ADR applicables
- [ ] Vérification indépendante enregistrée (si changement significatif)
- [ ] Documentation à jour
- [ ] Issues et PRs reliées et fermées
- [ ] Décision de capitalisation prise (apprentissage local créé ou non)

## Contraintes

- Ne pas déclarer le projet clos sans que tous les critères soient couverts.
- La création d'un apprentissage n'est pas obligatoire ; la décision l'est.
