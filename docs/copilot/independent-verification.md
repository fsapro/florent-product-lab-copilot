# Vérification indépendante

Référence de l'orchestration Copilot.

---

## Principe

L'agent qui implémente ne peut pas être l'unique autorité attestant que son travail satisfait le goal et les critères d'acceptation. Un changement significatif est confronté au goal et aux critères par un contexte distinct avant validation PM.

---

## Niveaux de vérification

### Niveau 0 — Contrôles déterministes uniquement

Autorisé pour :
- formatage ;
- correction typographique ;
- modification documentaire sans effet sur une instruction active ;
- changement entièrement couvert par une acceptation automatisée fiable.

Conditions (toutes requises) :
- aucun comportement utilisateur modifié ;
- aucune règle métier modifiée ;
- aucun impact de sécurité, confidentialité, permission ou production ;
- preuve automatisée disponible.

Aucun vérificateur indépendant n'est requis.

---

### Niveau 1 — Agent vérificateur indépendant

Requis pour :
- comportement visible par l'utilisateur ;
- règle métier ;
- API ou intégration externe ;
- refactoring non trivial ;
- critères d'acceptation ambigus ou partiellement observables ;
- changement des règles d'orchestration ou de mémoire.

Le vérificateur part d'un contexte propre. Il reçoit uniquement : le goal approuvé, le périmètre de l'issue, les critères d'acceptation, le diff ou résultat livré, les fichiers concernés, les contrôles et leur résultat, les preuves brutes. Il ne reçoit pas le raisonnement interne de l'implémenteur ni son verdict proposé.

---

### Niveau 2 — Session indépendante reconstruite depuis GitHub

Requis pour :
- sécurité, permissions ou confidentialité ;
- migration destructive ;
- production ;
- décision difficile à inverser ;
- gate de milestone ou de release ;
- modification du mécanisme de promotion globale.

Mêmes sources que le Niveau 1, avec en plus reconstruction de l'état depuis les sources de vérité du projet (plan approuvé, issues, GitHub Project, PRs, CI) sans dépendre de l'historique du chat d'implémentation.

---

## Sélection du niveau

1. Le changement satisfait-il toutes les conditions du Niveau 0 ? → Niveau 0.
2. Sinon, relève-t-il du Niveau 2 (sécurité, permissions, confidentialité, migration destructive, production, décision difficile à inverser, gate de milestone/release, mécanisme de promotion globale) ? → Niveau 2.
3. Sinon → Niveau 1.

En cas de doute entre deux niveaux, retenir le niveau le plus élevé.
