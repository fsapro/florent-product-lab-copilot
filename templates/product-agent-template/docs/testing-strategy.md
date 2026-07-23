# Stratégie de tests proportionnée

Objectif : couvrir les risques réels sans relire ni retester tout le repository à
chaque changement.

## Niveau 1 — À chaque changement

Contrôles rapides et déterministes sur le périmètre modifié :

- formatage ;
- lint ;
- types ;
- tests unitaires concernés ;
- détection de secrets ;
- validation des fichiers modifiés.

## Niveau 2 — Selon risque ou périmètre

- tests d'intégration concernés ;
- tests de contrat ;
- tests d'accessibilité ;
- sécurité ciblée ;
- migration ;
- non-régression des flux impactés.

## Niveau 3 — Avant release ou changement structurant

- suite complète ;
- tests end-to-end ;
- audit sécurité élargi ;
- performance ;
- résilience ;
- revue d'architecture et conformité globale.

## Usage des LLM

Utiliser une analyse LLM uniquement lorsqu'elle apporte un raisonnement non couvert par
un test, linter, type checker, scanner, règle statique, comparaison de schéma ou workflow
GitHub Actions.

Ne pas simuler de mesure de tokens sans données. Documenter plutôt les sources probables
de consommation, redondances, optimisations et mesures à ajouter.
