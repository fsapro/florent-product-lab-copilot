# Context7

Context7 peut fournir une documentation technique actuelle via MCP.

## Activation Copilot CLI

Configuration utilisateur recommandée par GitHub Copilot CLI :

```powershell
copilot mcp add context7 -- npx -y @upstash/context7-mcp
```

Alternative HTTP :

```powershell
copilot mcp add --transport http context7 https://mcp.context7.com/mcp
```

Si une clé Context7 est utilisée pour des limites plus élevées, elle doit rester dans
la configuration utilisateur ou les variables d'environnement. Ne jamais la committer.

Un exemple sans secret est disponible dans `.github/mcp.context7.example.json`.

## Vérification

```powershell
copilot mcp list
copilot mcp get context7
```

## Règle d'utilisation

Utiliser Context7 uniquement lorsqu'une décision ou une implémentation dépend :

- d'une bibliothèque ;
- d'un framework ;
- d'une API ;
- d'une version ;
- d'une capacité technique actuelle.

Avant toute consultation :

1. identifier la technologie et sa version réelle ;
2. vérifier l'existant du repository ;
3. poser une question documentaire précise ;
4. privilégier les sources officielles ou fortement reconnues ;
5. distinguer les faits documentés des recommandations.

Context7 ne décide pas du périmètre produit, de l'architecture, de l'ajout d'une
dépendance ni d'un compromis métier.

## Repli

Si Context7 est indisponible, utiliser les sources officielles, la documentation du
repository ou une source fortement reconnue, puis signaler clairement la limite de
vérification.
