# Stratégie de tests proportionnée

Objectif : couvrir les risques réels sans relire ni retester tout le repository à
chaque changement.

## Principe d'itération

À chaque itération, choisir le plus petit ensemble de contrôles déterministes qui couvre
le changement réel. Ne pas relancer une suite plus large par habitude.

Un contrôle déjà passé dans la même branche n'a pas à être répété tant que les éléments
qu'il couvre n'ont pas changé : code concerné, configuration, dépendances, schémas,
données de test, fixtures, snapshots, version de base ou environnement d'exécution.

Après un échec, relancer d'abord le contrôle échoué et les contrôles directement liés à
la correction. Élargir seulement si l'échec révèle un risque de régression plus large.

## Niveau 1 — À chaque changement

Contrôles rapides et déterministes sur le périmètre modifié :

- formatage ;
- lint ;
- types ;
- tests unitaires concernés ;
- détection de secrets ;
- validation des fichiers modifiés.

Utiliser le Niveau 1 comme boucle courte de développement. Si une commande globale est
le seul moyen disponible pour couvrir le changement, l'exécuter ; sinon privilégier les
sélecteurs ciblés du runner existant.

## Niveau 2 — Selon risque ou périmètre

- tests d'intégration concernés ;
- tests de contrat ;
- tests d'accessibilité ;
- sécurité ciblée ;
- migration ;
- non-régression des flux impactés.

Déclencher le Niveau 2 lorsqu'un changement traverse une frontière : API, contrat,
persistance, permissions, UI critique, intégration externe, workflow métier ou
configuration d'exécution.

## Niveau 3 — Avant release ou changement structurant

- suite complète ;
- tests end-to-end ;
- audit sécurité élargi ;
- performance ;
- résilience ;
- revue d'architecture et conformité globale.

Déclencher une salve de Niveau 3 uniquement aux moments critiques :

- préparation de release ;
- clôture de milestone ou de projet ;
- changement d'architecture ;
- authentification, autorisation, secrets ou données sensibles ;
- migration de données ;
- nouvelle dépendance structurante ;
- refonte multi-composants ;
- propagation multi-repository.

La salve de non-régression doit rester proportionnée : couvrir les flux exposés au
risque, pas refaire une analyse complète du repository si le risque est localisé.

## Mémoire de validation

Dans la PR, documenter le niveau retenu, les contrôles exécutés et les contrôles non
relancés parce que leur périmètre n'a pas changé. La preuve attendue est une synthèse
courte, pas les logs complets des commandes réussies.

## Usage des LLM

Utiliser une analyse LLM uniquement lorsqu'elle apporte un raisonnement non couvert par
un test, linter, type checker, scanner, règle statique, comparaison de schéma ou workflow
GitHub Actions.

Ne pas simuler de mesure de tokens sans données. Documenter plutôt les sources probables
de consommation, redondances, optimisations et mesures à ajouter.
