<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/">
    
    <!-- This adds DOCTYPE declaration -->
    <!--Another comment to test git .... -->
    <!-- Git finally worked by removing the existing RSA key folder and regenerating from the command line 
    I followed the instructions on github: https://help.github.com/articles/generating-ssh-keys
    -->
    <xsl:output method="xml" doctype-public="-//OASIS//DTD DITA Glossary//EN"
        doctype-system="glossary.dtd" omit-xml-declaration="yes" indent="yes"/>
    
    <!-- The below line ensures  that all empty space and carriage returns are removed from the title element producing proper file names 
    -->
    <xsl:strip-space elements="title"/>
    
    <!-- Using percent-encoding helped to translate the 
        following URI :select=[A-Z]{2,}.dita to select=%5BA-Z%5D%7B2,%7D.dita
        for Saxon to recognize the 
        characters in the URI. And also transform only files with names longer than 2 characters-->
    
    
    <!--select=[A-Z (),']{2,}.dita with percent encoding to detect all the file names longer than two characters-->
    
    
    <xsl:param name="files"
        select="collection('../../../DITA/R/?select=%5BA-Z%2D%27%20%28%29%2C%5D%7B2,%7D.dita;recurse=yes')"/>
    
    <!-- Identity transform to match all nodes excluding attributes -->
    
    <xsl:template match="node()">
        
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
        
    </xsl:template>
    
    <!-- Template to match the whole document -->
    
    <xsl:template match="/">
        
        
        <!-- Check for each topic found in the source files and construct new glossentry element -->
        
        
        <xsl:for-each select="$files//topic">
            
            <!--  <xsl:value-of select="text()" disable-output-escaping="yes"/> -->
            
            <!-- The below code create new glossary entries and saved them by   -->
            <xsl:result-document href="DITA/glossentries_all_L/{substring(title,1,1)}/{title}.dita">
                <!-- 
                    Create new glossentry elements based on each topic found in the source file -->
                <glossentry id="{concat('test', generate-id())}">
                    
                    <!-- Create new glossterm 
                        elements inside glossentry based on each topic::title found in the source file -->
                    
                    <glossterm id="{concat('test_title', generate-id())}">
                        <xsl:value-of select="title"/>
                    </glossterm>
                    <!-- Create new glossdef elements based on each body::descendant(p, ol, ul...) found in the source file -->
                    <glossdef>
                        <xsl:for-each select="body">
                            <xsl:apply-templates/>
                            
                        </xsl:for-each>
                        <shortdesc/>
                    </glossdef>
                </glossentry>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
