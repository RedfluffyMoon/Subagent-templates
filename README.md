# Subagent-templates

Újrafelhasználható Claude Code subagent sablonok: egy `code-reviewer`, egy `debugger` és egy `doc-writer` ügynök, mindhárom `.claude/agents/` formátumban.

## Mit csinál a 3 ügynök

| Ügynök | Feladat | Eszközök |
|---|---|---|
| [`code-reviewer`](.claude/agents/code-reviewer.md) | Átnézi a kódot minőség, hibák és jó gyakorlatok szempontjából — csak olvas, nem módosít. | Read, Glob, Grep |
| [`debugger`](.claude/agents/debugger.md) | Ténylegesen lefuttatja és teszteli a kódot, hibákat keres futásidőben. | Read, Bash, Glob, Grep |
| [`doc-writer`](.claude/agents/doc-writer.md) | Dokumentációt és README-t ír a meglévő kód alapján. | Read, Write, Edit, Glob, Grep |

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
