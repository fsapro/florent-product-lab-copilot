---
mode: agent
description: Initialiser un projet sur GitHub après validation explicite du plan
---

# BOOTSTRAP — Initialisation de projet

Mode : BOOTSTRAP
Projet : [nom du projet]

Prérequis : plan produit validé explicitement par Florent.

## Instructions pour Copilot

1. Vérifier que le plan est approuvé explicitement (ne pas assumer).
2. Lire `projects.yaml` pour vérifier si le projet existe déjà.
3. Si le projet est nouveau, l'ajouter à `projects.yaml`.
4. Créer le repository GitHub si nécessaire (demander confirmation avant).
5. Créer le GitHub Project.
6. Créer les milestones depuis le plan approuvé.
7. Créer les issues structurantes pour la première milestone.
8. Pousser le plan initial dans `docs/product/plan.md`.
9. Confirmer l'état initial à Florent.

## Contraintes

- Ne pas bootstrapper sans validation explicite du plan.
- Confirmer chaque ressource GitHub majeure avant création.
- Ne créer que les issues de la première milestone, pas toutes.

## Output attendu

Repository initialisé, GitHub Project créé, milestones et issues de démarrage créées, plan poussé, état confirmé à Florent.
