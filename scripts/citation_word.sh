#!/bin/bash
for filename in material/nismod/Lectures/*/Mini-lecture*/Lecture_[0-9]*.docx; do
    echo Converting "$filename"

    BNAME=$(basename "$filename" .docx)
    MD_NAME=output/$BNAME.md
    BIBFILE="$(dirname "$filename")/$BNAME.bib"

    CSL=https://climatecompatiblegrowth.github.io/style/csl-style.css
    PAN=https://climatecompatiblegrowth.github.io/style/pandoc.css

    pandoc --extract-media=output/$BNAME -f docx -t markdown "$filename" | sed -E -f scripts/sub.sed > $MD_NAME

    # Remove header
    HEADER=$(grep $MD_NAME -e 'Lecture content' -n | cut -f1 -d:)
    LENGTH=$(wc -l < $MD_NAME | bc)
    let "TRIM=$LENGTH-$HEADER"
    echo $HEADER $LENGTH $TRIM
    cat $MD_NAME | tail -n "$TRIM" > $MD_NAME.tmp
    mv $MD_NAME.tmp $MD_NAME

    # Render citations and write bibliography to HTML
    echo "" >> $MD_NAME
    echo "## Bibliography" >> $MD_NAME
    if test -f "$BIBFILE"; then
        sed -E -f scripts/bib.sed "$(dirname "$filename")/$BNAME.bib" > tmp.bib
        pandoc --standalone --css $PAN --css $CSL --citeproc $MD_NAME --bibliography tmp.bib -o output/$BNAME.docx
    else
        pandoc --standalone --css $PAN --css $CSL $MD_NAME -o output/$BNAME.docx
    fi
done;
# Clean up
rm tmp.bib
