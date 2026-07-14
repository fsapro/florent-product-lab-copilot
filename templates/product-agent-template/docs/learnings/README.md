# Apprentissages locaux

Registre local des erreurs et écarts observés sur ce projet.

## Principe par défaut

Par défaut, aucun apprentissage n'est créé.

Un apprentissage local n'est créé que lorsque le coût de ne pas le capitaliser est supérieur au coût de maintenir cet apprentissage dans le temps. Une erreur mineure, ponctuelle, déjà couverte par un contrôle existant, ou sans valeur de réutilisation crédible n'est pas enregistrée.

Ce registre doit rester petit et exploitable. Une mémoire bruitée par de nombreuses entrées mineures est pire qu'une mémoire incomplète.

## Cycle de vie

Voir `.claude/skills/product-project-orchestrator/references/learning-lifecycle.md` pour le modèle de données complet, les statuts, les portées et les catégories.

## Format

`learning-log.yaml` est une liste YAML d'enregistrements. Chaque entrée suit le modèle documenté dans `learning-lifecycle.md`. Le fichier reste vide (`[]`) tant qu'aucun apprentissage n'a été jugé nécessaire.

## Quand créer un apprentissage

La décision est prise en clôture de projet (mode `CLOSE` de l'orchestrateur), pas à chaque issue. Elle est obligatoire ; la création d'un apprentissage ne l'est pas.

Pour chaque écart notable identifié pendant la rétrospective de clôture :
1. Un écart a-t-il été observé ?
2. Si oui, le coût de ne pas le capitaliser dépasse-t-il le coût de maintenir l'apprentissage ?

Si la réponse à la seconde question est non ou incertaine, ne rien créer. Le doute profite à la légèreté du registre.
