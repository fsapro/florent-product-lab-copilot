---
mode: agent
description: Vérifier et clôturer un projet
---

# CLOSE — Clôture de projet

Mode : CLOSE
Projet : [nom du projet]

## Instructions pour Copilot

1. Charger l'état complet depuis GitHub.
2. Vérifier chaque critère d'acceptation du plan approuvé.
3. Confirmer que toutes les issues de la milestone finale sont fermées.
4. Confirmer que les contrôles CI passent.
5. Vérifier que le verdict de vérification indépendante est enregistré pour les changements significatifs (voir `docs/copilot/independent-verification.md`).
6. Évaluer la capitalisation : un apprentissage local mérite-t-il d'être créé ? (voir `docs/copilot/learning-lifecycle.md`)
7. Mettre à jour `projects.yaml` avec le statut `closed`.
8. Fournir les instructions de validation produit finales à Florent.

## Checklist de clôture

- [ ] Tous les critères d'acceptation couverts
- [ ] Toutes les issues de la milestone finale fermées
- [ ] Contrôles CI passants
- [ ] Vérification indépendante enregistrée (si changement significatif)
- [ ] Documentation à jour
- [ ] Issues et PRs reliées et fermées
- [ ] Décision de capitalisation prise (apprentissage local créé ou non)
- [ ] `projects.yaml` mis à jour

## Contraintes

- Ne pas déclarer le projet clos sans que tous les critères soient couverts.
- La création d'un apprentissage n'est pas obligatoire ; la décision l'est.
