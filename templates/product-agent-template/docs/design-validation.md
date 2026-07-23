# Critères de validation du design

Un Solution Design est validable seulement si :

- le problème, le périmètre et le résultat attendu sont explicites ;
- le niveau de design est justifié ;
- les options pertinentes ont été comparées proportionnellement au risque ;
- la solution recommandée répond au PRD ;
- les impacts métier, données, applications, technologie et exploitation sont traités lorsque concernés ;
- les exigences mesurables sont séparées de la description qualitative ;
- les risques, migrations et retours arrière sont documentés lorsque pertinents ;
- les dépendances et composants open source significatifs sont justifiés ;
- l'authentification ou autre sujet sensible évite le custom si une solution standard adaptée existe ;
- le design system UI est évalué uniquement si l'UI est concernée ;
- les ADR nécessaires sont identifiés ;
- la revue indépendante rend un verdict `Approved` ;
- le PM valide les compromis produit et la réversibilité.

Verdicts possibles de revue :

- `Approved` : le design peut passer en validation PM.
- `Changes requested` : le design doit être ajusté avant validation PM.
- `Blocked` : une décision ou information manque pour continuer.
