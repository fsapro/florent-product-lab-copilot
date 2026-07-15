# Instructions du projet

## Démarrage de session

Avant toute implémentation :

1. Lire `docs/product/plan.md`.
2. Lire les issues GitHub et le GitHub Project.
3. Inspecter les pull requests ouvertes et leurs checks.
4. Identifier l'unique travail `In progress`.
5. Terminer ce travail avant de commencer une nouvelle issue.
6. Si aucun travail n'est actif, sélectionner l'issue `Ready` prioritaire.

## Exécution

Pour chaque issue :

1. Vérifier son rattachement au plan approuvé.
2. Lire ses critères d'acceptation.
3. Inspecter le code et les patterns existants.
4. Chercher le plus petit changement cohérent.
5. Ne pas ajouter de dépendance sans besoin démontré.
6. Implémenter uniquement le périmètre de l'issue.
7. Exécuter les contrôles applicables.
8. Relire le diff.
9. Mettre à jour l'issue, la pull request et le Project.

## Apprentissages

Par défaut, aucun apprentissage n'est créé.

Un apprentissage local (`docs/learnings/learning-log.yaml`) n'est ajouté que si le coût de ne pas capitaliser une erreur ou un écart dépasse le coût de maintenir cet apprentissage. Voir `docs/learnings/README.md` pour le modèle et le cycle de vie.

La décision explicite (aucun apprentissage / apprentissage local créé / candidat de promotion identifié) est requise en clôture de projet (mode `CLOSE`), pas à chaque issue.

## Budget de complexité par défaut

- Nouvelle dépendance : interdite par défaut.
- Nouveau service : interdit par défaut.
- Nouvelle couche d'abstraction : interdite par défaut.
- Refactoring hors périmètre : interdit.
- Besoins futurs spéculatifs : exclus.

Toute exception doit expliquer :
- le besoin démontré ;
- les alternatives considérées ;
- le compromis retenu ;
- la réversibilité.

## Validation PM

Pour un incrément observable, fournir :

- ce qui change ;
- les critères couverts ;
- les étapes de validation ;
- le résultat attendu ;
- les contrôles exécutés ;
- les limites et risques ;
- les liens vers l'issue, la PR et le plan.

Florent valide le comportement produit, pas le code.
