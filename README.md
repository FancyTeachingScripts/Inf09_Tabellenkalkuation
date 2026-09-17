# Für Consumer 
Infos und Dokumentation der Skripte und Veröffentlichung der fertigen PDFs in allen Versionen unter: https://valentin-herrmann.com/fts/


# Für Creator

## Einrichtung (VS Code)

1. Repo klonen, in VS Code öffnen.
2. Terminal (`` Strg+` ``): `./init.sh` (einmalig).
3. **Run and Debug** (F5) 
   - **MAIN** baut `main.tex` (→ `build/`)
   - **PREVIEW** baut die PR-Vorschau-Auswahl, also leeres Skript, Musterlöung, Präsentation hell und dunkel (→ `build/`), 
   - **ALL** baut alle Varianten (→ `pdfs/`; dauert lange: ca. 60 PDFs).

## Wo kommt was hin?

- `_Skripte/` – Unterrichtsskripte, ein `.tex` pro (Teil)Skript/Kurs/Schuljahr/....
- `_Aufgaben/` – Arbeitsblätter/Aufgaben.
- `_Hefteintraege/` – Hefteinträge.
- Bilder/Anhänge jeweils im `img/`-Unterordner der zugehörigen Datei.
- `selected.tex` – legt fest, was `main.tex` tatsächlich baut (i.d.R. ein `\input{_Skripte/...}`).

## Veröffentlichung (GitHub)

`.github/workflows/Release.yml` ruft den gemeinsamen Release-Workflow aus
FancyScript auf und liest den Zielpfad auf valentin-herrmann.com aus der
Repository-Variable `WEBSITE_PATH`.

Einmalig pro Repo setzen — *Settings → Secrets and variables → Actions →
Variables → New repository variable*:

| Name | Wert (Beispiel) |
|---|---|
| `WEBSITE_PATH` | `inf10_datenbanken` |

Ohne diese Variable landet der Release im leeren Pfad. Per CLI:
`gh variable set WEBSITE_PATH --body inf09_oop --repo FancyTeachingScripts/Inf09_OOP`

## Terminal (ohne VS Code)

```bash
# einmalig repo und submodule initialisieren
./init.sh   

# baut main.tex als PDF und speichert es in ./build/
tectonic \
-Z search-path=. \
-Z search-path=template \
-Z search-path=template/sty/moloch \
-Z continue-on-errors \
-o build main.tex 
```
