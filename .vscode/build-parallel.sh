#!/usr/bin/env bash
set -e

echo -e "\033[35m=== Parallel LaTeX Build Script (Tectonic) ===\033[0m"

shopt -s nullglob
tex_files=(main/*.tex)

if [ ${#tex_files[@]} -eq 0 ]; then
    echo "No TeX files found in main/"
    exit 1
fi

echo -e "\033[36mFound ${#tex_files[@]} TeX files to compile in parallel...\033[0m"

pids=()
filenames=()

mkdir -p main/pdfs

for file in "${tex_files[@]}"; do
    fname=$(basename "$file")
    echo -e "\033[33mStarting compilation of ${fname}...\033[0m"
    tectonic -Z search-path=. -Z search-path=sty/moloch -Z continue-on-errors -o main/pdfs "$file" &
    pids+=($!)
    filenames+=("$fname")
done

echo -e "\033[36mWaiting for compilation to complete...\033[0m"

failed=0
for i in "${!pids[@]}"; do
    pid=${pids[$i]}
    fname=${filenames[$i]}
    if wait "$pid"; then
        echo -e "\033[32mSuccessfully compiled ${fname}\033[0m"
    else
        echo -e "\033[31mFailed compilation for ${fname}\033[0m"
        failed=$((failed + 1))
    fi
done

echo -e "\033[36mCleaning up temporary files...\033[0m"
find . -type f \( -name "*.aux" -o -name "*.log" -o -name "*.nav" -o -name "*.out" -o -name "*.snm" -o -name "*.toc" -o -name "*.atfi" -o -name "*.fls" -o -name "*.fdb_latexmk" -o -name "*.synctex.gz" -o -name "*.bbl" -o -name "*.blg" \) -delete

echo -e "\033[32mCleanup completed!\033[0m"
echo -e "\033[35m=== Build process finished (failures: ${failed}) ===\033[0m"

if [ $failed -ne 0 ]; then
    exit 1
fi
