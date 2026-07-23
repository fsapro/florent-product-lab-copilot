# Solution Design

Statut : Draft
Niveau : Léger | Standard | Renforcé
Dernière mise à jour : YYYY-MM-DD

## 1. Problème et objectif

- Problème à résoudre :
- Résultat attendu :
- Périmètre inclus :
- Périmètre exclu :

## 2. Niveau de design

| Niveau | À utiliser si... | Sections minimales |
|---|---|---|
| Léger | Changement local, réversible, sans impact architectural significatif. | Problème, solution, périmètre, composants concernés, risques, critères de validation. |
| Standard | Nouvelle fonctionnalité, intégration, modification de données ou nouvelle dépendance. | Niveau léger + options, vues d'architecture concernées, exigences non fonctionnelles, trajectoire d'implémentation. |
| Renforcé | Décision structurante, migration, données sensibles, authentification, impact multi-composants ou forte irréversibilité. | Niveau standard + architecture actuelle/cible, écarts, sécurité, migration, rollback, coûts/exploitation, ADR, conformité renforcée. |

Niveau retenu :

Justification :

## 3. Situation existante

- Repository et composants concernés :
- Données concernées :
- Dépendances ou services existants :
- Contraintes connues :

## 4. Options étudiées

| Option | Description | Avantages | Limites | Réversibilité |
|---|---|---|---|---|
| Option A | | | | |
| Option B | | | | |

## 5. Solution recommandée

Description qualitative de la solution :

Composants concernés :

## 6. Vues d'architecture concernées

### Vue métier

Parcours, règles métier et impacts utilisateur.

### Vue données

Données créées, lues, modifiées, supprimées, contraintes et rétention.

### Vue applications et composants

Composants, responsabilités, interfaces et intégrations.

### Vue technologie et exploitation

Stack, versions, déploiement, observabilité et exploitation.

### Sécurité et authentification

Besoins réels, standards applicables, capacités natives, solutions reconnues évaluées,
secrets, permissions et risques.

## 7. Exigences mesurables

| Exigence | Mesure ou critère | Niveau de preuve attendu |
|---|---|---|
| Fonctionnelle | | |
| Sécurité | | |
| Accessibilité | | |
| Performance | | |
| Fiabilité | | |
| Observabilité | | |

## 8. Réutilisation, dépendances et open source

- Capacité déjà présente recherchée :
- Bibliothèque standard ou capacité native :
- Dépendance existante réutilisable :
- Composants open source évalués :
- Option retenue :
- Alternatives crédibles :
- Licence, maintenance, sécurité et coût d'intégration :

## 9. UI et design system

À remplir uniquement si une interface utilisateur est concernée.

- Parcours et interactions :
- Système de composants existant :
- Design system open source compatible :
- Accessibilité :
- Fréquence de réutilisation :
- Coût de maintenance :
- Décision : réutiliser | étendre | ne pas créer de design system

## 10. Impacts, risques et rollback

| Risque | Impact | Mitigation | Rollback |
|---|---|---|---|
| | | | |

## 11. Trajectoire d'implémentation

1. 
2. 
3. 

Voir aussi `docs/implementation-plan.md`.

## 12. ADR nécessaires

| Décision | ADR requis | Statut |
|---|---|---|
| | oui/non | |

## 13. Décisions attendues du PM

| Décision | Options | Recommandation | Statut |
|---|---|---|---|
| | | | Pending |

## 14. Revue indépendante

- Vérificateur :
- Verdict : Pending | Approved | Changes requested | Blocked
- Réserves :
- Date :

## 15. Validation PM

- Statut : Pending | Approved
- Date :
- Commentaire :

Le développement fonctionnel ne peut démarrer que lorsque le verdict de revue est
`Approved` et que la validation PM est `Approved`.
