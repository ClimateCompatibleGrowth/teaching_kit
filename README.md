# Teaching Kit

Convert Word templates to HTML via markdown, extracting media, cleaning bib files

Main script is `scripts/convert.sh`.

## Installation

The scripts require pandoc which runs to create Markdown and HTML files.
The command line tool `sed` is used to substitute patterns left over from the translation to Markdown from docx.

    pandoc --extract-media=. -f docx -t markdown -o lecture_6.md Lecture_6.1.docx

At present, square brackets and \@ around citations have backslaces pre-pended which need to be removed.

Then, images need to be linked using, for example

```markdown
![A caption](../Assets/Figure_6.1.3.pdf){ width=100% height=100% }
```

Finally pandoc is used to render the citations and generate a formatted and styled HTML file ready for online publication.

    pandoc --citeproc lecture_6.md --bibliography Lecture_6.1.bib -o lecture_6.html

## SCORM Packaging

For publication to OpenLearnCreate, the most convenient route seems to be to create a SCORM package for each lecture block.

There are a few hacky approaches to creating the SCORM package, and most involve manually inserting files.

Then, using [markdown2scorm](https://github.com/naturalis/markdown2scorm) package the html with all assets into a SCORM archive
using libscorm and then upload the archive.

Alternatively, [SCORM package](https://github.com/tommyhutcheson/scorm_package) could provide a hacky way to get the content onto Moodle easily

The most promising route appears to be to do this manually building on the template SCORM Package provided by [SCORM package](https://github.com/tommyhutcheson/scorm_package).
Extending the Jinja2 templating provided to allow multiple files to be inserted in the structure needed seems most promising.

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest identifier="test_package" xmlns="http://www.imsproject.org/xsd/imscp_rootv1p1p2" xmlns:adlcp="http://www.adlnet.org/xsd/adlcp_rootv1p2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:lom="http://www.imsglobal.org/xsd/imsmd_rootv1p2p1" xsi:schemaLocation="http://www.imsproject.org/xsd/imscp_rootv1p1p2 imscp_rootv1p1p2.xsd http://www.imsglobal.org/xsd/imsmd_rootv1p2p1 imsmd_rootv1p2p1.xsd http://www.adlnet.org/xsd/adlcp_rootv1p2 adlcp_rootv1p2.xsd">
<metadata>
<schema>ADL SCORM</schema>
<schemaversion>1.2</schemaversion>
<lom:lom>
<lom:general>
<lom:title>
<lom:langstring>Lecture Block 1</lom:langstring>
</lom:title>
</lom:general>
<lom:educational>
<lom:typicallearningtime>
<lom:datetime>00:00:00</lom:datetime>
</lom:typicallearningtime>
</lom:educational>
</lom:lom>
</metadata>
<organizations default="lecture_block_1_organization">
    <organization identifier="lecture_block_1_organization">
    <title>Lecture Block 1</title>
        <item identifier="item1" identifierref="lecture_1_1" isvisible="true">
            <title>Mini Lecture 1.1</title>
        </item>
        <item identifier="item2" identifierref="lecture_1_2" isvisible="true">
            <title>Mini Lecture 1.2</title>
        </item>
        <item identifier="item3" identifierref="lecture_1_3" isvisible="true">
            <title>Mini Lecture 1.3</title>
        </item>
        <item identifier="item4" identifierref="lecture_1_4" isvisible="true">
            <title>Mini Lecture 1.4</title>
        </item>
    </organization>
</organizations>
<resources>
    <resource identifier="lecture_1_1" type="webcontent" adlcp:scormtype="sco" href="res/Lecture_1.1.html">
        <file href="res/Lecture_1.1.html"/>
    </resource>
    <resource identifier="lecture_1_2" type="webcontent" adlcp:scormtype="sco" href="res/Lecture_1.2.html">
        <file href="res/Lecture_1.2.html"/>
    </resource>
    <resource identifier="lecture_1_3" type="webcontent" adlcp:scormtype="sco" href="res/Lecture_1.3.html">
        <file href="res/Lecture_1.3.html"/>
    </resource>
    <resource identifier="lecture_1_4" type="webcontent" adlcp:scormtype="sco" href="res/Lecture_1.4.html">
        <file href="res/Lecture_1.4.html"/>
    </resource>
</resources>
</manifest>
```
