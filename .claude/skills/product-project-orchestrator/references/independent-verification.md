# Vérification indépendante

Référence de la skill `product-project-orchestrator`.

Statut : approuvé par Florent le 2026-07-14 — Incrément 1 : formalisation de la vérification indépendante.

## Principe

L'agent qui implémente ne peut pas être l'unique autorité attestant que son travail satisfait le goal et les critères d'acceptation. Un changement significatif est confronté au goal et aux critères par un contexte distinct avant `PM validation`.

Ce document ne couvre que la vérification indépendante. La mémoire d'apprentissage, la promotion globale, le routage des modèles et l'observabilité sont hors périmètre et traités par des incréments ultérieurs.

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

Aucun agent ou session distincte n'est requis. Les contrôles déterministes (formatage, lint, tests, build) suffisent.

### Niveau 1 — Agent vérificateur indépendant

Requis pour :
- comportement visible par l'utilisateur ;
- règle métier ;
- API ou intégration externe ;
- refactoring non trivial ;
- critères d'acceptation ambigus ou partiellement observables ;
- changement des règles d'orchestration ou de mémoire.

Le vérificateur part d'un contexte propre. Sources autorisées et exclues : voir [Sources autorisées du vérificateur](#sources-autorisées-du-vérificateur).

### Niveau 2 — Session indépendante reconstruite depuis GitHub

Requis pour :
- sécurité ;
- permissions ou confidentialité ;
- migration destructive ;
- production ;
- décision difficile à inverser ;
- gate de milestone ou de release ;
- modification du mécanisme de promotion globale lui-même.

Mêmes sources autorisées et exclues que le Niveau 1 (voir [Sources autorisées du vérificateur](#sources-autorisées-du-vérificateur)), avec en plus la reconstruction de l'état depuis les sources de vérité du projet (plan approuvé, issues, GitHub Project, pull requests, CI), sans dépendre de l'historique du chat d'implémentation. Le mode `RESUME` de l'orchestrateur fournit la procédure de reconstruction d'état à réutiliser pour ouvrir cette session.

## Sources autorisées du vérificateur

Pour toute vérification de Niveau 1 ou 2, le vérificateur reçoit uniquement :
- le goal approuvé ;
- le périmètre de l'issue ;
- les critères d'acceptation ;
- le diff ou le résultat livré ;
- les fichiers concernés ;
- les contrôles disponibles et leur résultat ;
- les preuves brutes.

Il ne reçoit pas :
- le raisonnement interne de l'implémenteur ;
- le verdict proposé par l'implémenteur ;
- l'historique complet de la session d'implémentation.

Cette exclusion évite que le vérificateur adopte par ancrage la conclusion de l'implémenteur.

## Sélection du niveau

L'orchestrateur propose le niveau et le rend visible dans l'issue ou la PR. En cas de doute entre deux niveaux, retenir le niveau le plus élevé.

1. Le changement satisfait-il toutes les conditions du Niveau 0 ? → Niveau 0.
2. Sinon, le changement relève-t-il d'une des catégories du Niveau 2 (sécurité, permissions, confidentialité, migration destructive, production, décision difficile à inverser, gate de milestone/release, mécanisme de promotion globale) ? → Niveau 2.
3. Sinon → Niveau 1.

## Format du verdict

```yaml
verification_id: VER-YYYY-NNN
issue: "<issue-reference>"
pull_request: "<pr-reference>"
verifier_context: independent_agent
verdict: pass
criteria:
  - criterion: "Critère vérifié"
    status: passed
    evidence: "Commande, test, capture ou observation"
checks_executed:
  - name: test
    result: passed
regressions:
  detected: false
  details: []
risks: []
reservations: []
required_corrections: []
not_verified: []
created_at: "<ISO-8601>"
```

Valeurs de verdict :

- `pass` — tous les critères d'acceptation sont satisfaits, aucune réserve.
- `pass_with_reservations` — le changement est acceptable ; aucune correction n'est bloquante ; des réserves doivent néanmoins rester visibles au PM ; la décision finale (accepter tel quel, demander une correction non bloquante, ou refuser) reste au PM.
- `fail` — au moins un critère d'acceptation approuvé n'est pas satisfait.
- `not_verifiable` — le vérificateur ne peut pas se prononcer avec les preuves disponibles.

## Transitions

| Verdict | Transition |
|---|---|
| `pass` | → `PM validation` |
| `pass_with_reservations` | → `PM validation`, réserves listées et visibles au PM |
| `fail` | → retour `In progress`, critère(s) non satisfait(s) et preuve consignés |
| `not_verifiable` | → `Decision required` |

## Gate avant PM validation

Un changement ne passe au statut `PM validation` que si :
- il satisfait les conditions du Niveau 0, ou
- il a reçu un verdict `pass` ou `pass_with_reservations` d'une vérification Niveau 1 ou Niveau 2.

Un changement avec verdict `fail` ou `not_verifiable` ne passe jamais à `PM validation`.

Cette gate s'applique en complément, et non en remplacement, des contrôles déterministes (formatage, lint, tests, build) déjà exigés avant de déclarer un travail terminé.

## Conservation du rapport de vérification

Le verdict complet du vérificateur (format ci-dessus) est conservé verbatim et rendu consultable indépendamment de la restitution finale de l'implémenteur :
- collé tel quel dans le bloc « Vérification indépendante » de la pull request, ou
- publié en commentaire de l'issue liée, lorsqu'aucune PR n'existe encore.

L'implémenteur ne reformule, ne résume ni n'interprète le verdict avant de le rendre visible au PM. Un audit ultérieur doit pouvoir retrouver le rapport original sans dépendre de l'interprétation de l'implémenteur.
