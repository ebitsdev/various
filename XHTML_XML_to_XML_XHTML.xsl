<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" indent="yes" name="html" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/*">
        <xsl:for-each-group select="*" group-starting-with="h1">
            <!-- Here we use h1 elements to group and grab the content to generate the html files -->

            <xsl:result-document href="../CEPUB/Chapter{position()}.html">
                <!-- The position or The text node of h1 is used as the name of the generated html file -->

                <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html></xsl:text>
                <html>
                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                        <title>
                            <xsl:value-of select="text()"/>
                        </title>
                        <!-- This allows to grab text content of h1 elements as use it as the title of the 
                            generated html file -->
                    </head>
                    <body>
                        <xsl:copy-of select="current-group()"/>
                        <!-- This helps to copy the element as is from the source to the destination file -->
                    </body>
                </html>
            </xsl:result-document>

        </xsl:for-each-group>

        <!-- Creating the index -->
        <xsl:result-document href="../CEPUB/toc.html" format="html">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>Table of content</title>
                </head>
                <body>
                    <ul>
                        <xsl:for-each-group select="*" group-by="@id">
                            <!-- This allows to group the list items under the same ul or ol -->

                            <li>
                                <a href="Chapter{position()}.html">
                                    <xsl:value-of select="text()"/>
                                    <!-- We can use use the text node of h1 or generate  a name without space character 
                                        in it as the title of the index elements inside the generated index.html -->
                                </a>
                            </li>

                        </xsl:for-each-group>
                    </ul>
                </body>
            </html>
        </xsl:result-document>

    </xsl:template>

</xsl:stylesheet>
