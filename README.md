# Teaching Kit

Convert Word templates to HTML via markdown, extracting media, cleaning bib files

Main script is `scripts/convert.sh`.

    pandoc --extract-media=. -f docx -t markdown -o lecture_6.md Lecture_6.1.docx

At present, square brackets and \@ around citations have backslaces pre-pended which need to be removed.
Then, images need to be linked using, for example

```markdown
![A caption](../Assets/Figure_6.1.3.pdf){ width=100% height=100% }
```

    pandoc --citeproc lecture_6.md --bibliography Lecture_6.1.bib -o lecture_6.html


Then, using [markdown2scorm](https://github.com/naturalis/markdown2scorm) package the html with all assets into a SCORM arcive
using libscorm and then upload the archive.

Alternatively, [SCORM package](https://github.com/tommyhutcheson/scorm_package) could provide a hacky way to get the content onto Moodle easily