# Subagent-templates

Újrafelhasználható Claude Code subagent sablonok, mindegyik `.claude/agents/` formátumban.

## Mit csinálnak az ügynökök

| Ügynök | Feladat | Eszközök |
|---|---|---|
| [`code-reviewer`](.claude/agents/code-reviewer.md) | Átnézi a kódot minőség, hibák és jó gyakorlatok szempontjából — csak olvas, nem módosít. | Read, Glob, Grep |
| [`debugger`](.claude/agents/debugger.md) | Ténylegesen lefuttatja és teszteli a kódot, hibákat keres futásidőben. | Read, Bash, Glob, Grep |
| [`doc-writer`](.claude/agents/doc-writer.md) | Dokumentációt és README-t ír a meglévő kód alapján. | Read, Write, Edit, Glob, Grep |
| [`test-writer`](.claude/agents/test-writer.md) | Unit teszteket ír a meglévő kódhoz, a projekt teszt-konvencióit követve. | Read, Write, Edit, Glob, Grep, Bash |
| [`security-auditor`](.claude/agents/security-auditor.md) | Biztonsági réseket, kitett titkokat és sérülékeny mintákat keres — csak olvas, nem módosít. | Read, Glob, Grep |
| [`commit-writer`](.claude/agents/commit-writer.md) | A staged változásokból tömör commit üzenetet ír, a projekt stílusát követve. | Read, Bash, Glob, Grep |
| [`dependency-checker`](.claude/agents/dependency-checker.md) | Elavult/sérülékeny függőségeket keres, és konkrét frissítést javasol. | Read, Bash, Glob, Grep |
| [`refactorer`](.claude/agents/refactorer.md) | Kód szerkezetét/olvashatóságát javítja viselkedés megváltoztatása nélkül. | Read, Edit, Glob, Grep |
| [`performance-optimizer`](.claude/agents/performance-optimizer.md) | Teljesítményproblémákat keres és javasol javítást. | Read, Bash, Glob, Grep |
| [`api-designer`](.claude/agents/api-designer.md) | API végpontokat tervez/néz át konzisztencia szempontjából. | Read, Write, Edit, Glob, Grep |
| [`db-migration-writer`](.claude/agents/db-migration-writer.md) | Adatbázis-migrációs szkripteket ír a projekt konvencióival. | Read, Write, Edit, Glob, Grep, Bash |
| [`changelog-writer`](.claude/agents/changelog-writer.md) | Commitokból CHANGELOG bejegyzést ír. | Read, Write, Edit, Bash, Glob, Grep |
| [`pr-description-writer`](.claude/agents/pr-description-writer.md) | A branch változásaiból PR leírást ír. | Read, Bash, Glob, Grep |
| [`code-explainer`](.claude/agents/code-explainer.md) | Érthetően elmagyaráz egy bonyolult kódrészletet. | Read, Glob, Grep |
| [`onboarding-guide-writer`](.claude/agents/onboarding-guide-writer.md) | Fejlesztői setup/onboarding útmutatót ír. | Read, Write, Edit, Glob, Grep |
| [`accessibility-auditor`](.claude/agents/accessibility-auditor.md) | UI kódot vizsgál akadálymentességi (WCAG) szempontból. | Read, Glob, Grep |
| [`ui-consistency-checker`](.claude/agents/ui-consistency-checker.md) | Ellenőrzi, hogy a UI követi-e a design rendszert/tokeneket. | Read, Glob, Grep |
| [`translator`](.claude/agents/translator.md) | UI szövegeket/dokumentációt fordít magyar-angol között. | Read, Write, Edit, Glob, Grep |
| [`error-log-analyzer`](.claude/agents/error-log-analyzer.md) | Hibaüzeneteket/stack trace-eket elemez, megkeresi az okot. | Read, Glob, Grep, Bash |
| [`build-troubleshooter`](.claude/agents/build-troubleshooter.md) | Sikertelen build-eket diagnosztizál. | Read, Bash, Glob, Grep |
| [`dockerfile-optimizer`](.claude/agents/dockerfile-optimizer.md) | Dockerfile-t/image-et optimalizál méret és cache szempontjából. | Read, Write, Edit, Glob, Grep, Bash |
| [`ci-cd-writer`](.claude/agents/ci-cd-writer.md) | CI/CD workflow-kat (pl. GitHub Actions) ír/néz át. | Read, Write, Edit, Glob, Grep |
| [`lint-config-advisor`](.claude/agents/lint-config-advisor.md) | Linter/formatter konfigurációt állít be és futtat. | Read, Write, Edit, Glob, Grep, Bash |
| [`release-notes-writer`](.claude/agents/release-notes-writer.md) | Egy verzió változásaiból release notes-t ír. | Read, Bash, Glob, Grep |
| [`game-balance-reviewer`](.claude/agents/game-balance-reviewer.md) | Játék-egyensúlyi értékeket (árak, XP, drop rate) néz át. | Read, Glob, Grep |
| [`discord-bot-reviewer`](.claude/agents/discord-bot-reviewer.md) | Discord bot parancsstruktúráját és jogosultságait nézi át. | Read, Glob, Grep |
| [`env-config-auditor`](.claude/agents/env-config-auditor.md) | Környezeti változók teljességét/konzisztenciáját ellenőrzi. | Read, Glob, Grep |

## Fontos: hogyan működnek a subagentek a különböző eszközökön

A Claude Code a subagenteket két helyen keresi:

- **Projekt-szinten**: `<projekt>/.claude/agents/` — git-tracked, tehát *utazik* a repóval minden klónnal.
- **Felhasználói szinten**: `~/.claude/agents/` — csak az adott gépen létezik, sehova nem szinkronizálódik.

Ez a különbség számít, ha telefonról, Remote Controllal és gépről is dolgozol:

- **Telefon, önálló Claude Code (cloud sandbox)** — *kizárólag* a megnyitott projekt saját `.claude/agents/` mappáját olvassa be. A `~/.claude/agents` nem érhető el, mert a cloud sandboxnak nincs állandó saját home mappája.
- **Telefon + Remote Control** — ez ugyanaz a desktop munkamenet, amit távolról vezérelsz, szóval minden, ami a gépeden elérhető (projekt- vagy user-szintű agent), automatikusan működik, extra lépés nélkül.
- **Gép (desktop/CLI)** — mindkét helyet látja.

**Következmény:** nincs beépített fiókszintű szinkron sem a user-level agentekhez, sem a pluginokhoz — azokat gépenként újra kellene telepíteni, és bizonytalan, hogy plugin-eredetű agentek egyáltalán működnek-e cloud sandboxban. Az egyetlen módszer, ami mindhárom módban (telefon, telefon+Remote Control, gép) automatikusan és egyformán működik: **ha az ügynök-fájlok be vannak commitolva magába a célprojekt repójába.**

## Telepítés egy projektbe

Másold be ennek a repónak a `.claude/agents/*.md` fájljait a célprojekted `.claude/agents/` mappájába, majd commitold ott. Ehhez van egy kis installer script:

```bash
./install.sh /path/to/target-project
```

```powershell
.\install.ps1 -Target "C:\path\to\target-project"
```

Alapértelmezetten a jelenlegi mappába telepít (`.`), ha nem adsz meg célt.

Telepítés után a célprojektben commitold és pushold az ügynököket:

```bash
git add .claude/agents
git commit -m "Add code-reviewer, debugger, doc-writer subagents"
git push
```

Ettől kezdve az ügynökök elérhetők lesznek abban a projektben — telefonról, Remote Controllal és gépről egyaránt.
