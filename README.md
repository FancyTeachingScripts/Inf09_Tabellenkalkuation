Mehr Infos unter https://valentin-herrmann.com/inf09_tabkalk/

## Architektur auf einen Blick (für Menschen & LLMs)

Die gemeinsame Vorlage (`sty/`, Build-Tools, CI-Workflows) liegt **nicht** in
diesem Repo, sondern als Git-**Submodul** unter `template/`, gepinnt auf
[`FancyTeachingScripts/FancyScript`](https://github.com/FancyTeachingScripts/FancyScript).
Dieses Repo enthält nur die eigenen Inhalte: `main.tex`, `selected.tex`,
`_Aufgaben/`, `_Hefteintraege/`, `_Skripte/`.

- **Bauen:** `tectonic -Z search-path=. -Z search-path=template -Z search-path=template/sty/moloch -Z continue-on-errors -o build main.tex`
  (oder die VS-Code-Tasks in `.vscode/tasks.json`). Reihenfolge des
  Suchpfads ist wichtig – `.` **muss vor** `template` stehen, siehe
  [FancyScript-README](https://github.com/FancyTeachingScripts/FancyScript#kompilieren).
- **Alle Varianten bauen:** VS-Code-Task `build-all-main-tex`
  (→ `template/tools/build-parallel.sh`), sehr leistungsintensiv.
- **Vorlage aktualisieren:** aus dem Submodul heraus entwickeln
  (`$EDITOR template/sty/...`, `template/tools/build.sh main.tex` zum
  Testen), dann `cd template && git commit && git push`, danach in diesem
  Repo `git add template && git commit` um den neuen Stand zu pinnen. Details
  und der volle Ablauf stehen im [FancyScript-README](https://github.com/FancyTeachingScripts/FancyScript).
- **CI:** `.github/workflows/Release.yml` / `PR-Preview.yml` sind
  ~10-zeilige Aufrufe der wiederverwendbaren Workflows in FancyScript
  (`website_path: inf09_tabkalk`). PR-Previews landen als Kommentar mit
  Links auf die kompilierten PDFs.

Nie wird die Vorlage gemergt, nur der Commit-Zeiger bewegt – alte Skripte
bleiben stabil, auch wenn sich die Vorlage weiterentwickelt.

## Sonstiges

Im Repo befindet sich ein VS-Code Skript zum Kompilieren der main.tex und eines zum Kompilieren aller Dateien in ./main/  (Achtung, sehr leistungsintensiv). Letztere werden auf Github auch automatisch gebaut, sobald ein Release erstellt wird.

Wer auch seine Skripte [hier](https://github.com/FancyTeachingScripts) gesammelt zur Verfügung stellen möchte, kann mich jederzeit für entsprechende Berechtigungen kontaktieren.
