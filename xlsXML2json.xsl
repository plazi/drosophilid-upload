<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Feb 11, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> Terry</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <xsl:param name="double-quote">
        <xsl:text>"</xsl:text>
    </xsl:param>
    <xsl:param name="single-quote">
        <xsl:text>'</xsl:text>
    </xsl:param>
    <xsl:output indent="yes" encoding="UTF-8" method="text"/>
    <xsl:template match="/">
        <xsl:text>{
  "rows" : [</xsl:text>
        <xsl:apply-templates select="root"/>
        <xsl:text>]}</xsl:text>
    </xsl:template>
    <xsl:template match="root">
        <xsl:apply-templates select="row[child::publication_type/text() = 'Book']" mode="book"/>
        <xsl:apply-templates select="row[child::publication_type/text() = 'Journal Article']"
            mode="journal"/>

    </xsl:template>
    <xsl:template match="row" mode="journal">
        <xsl:variable name="description">
            <xsl:text>uploaded by Plazi from Taxodros</xsl:text>
        </xsl:variable>
        <xsl:text>{"metadata": {</xsl:text>
        <xsl:text>"title" : "</xsl:text>
        <xsl:value-of select="replace(title, $double-quote, $single-quote)"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"upload_type" : "</xsl:text>
        <xsl:value-of select="'publication'"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"description" : "</xsl:text>
        <xsl:value-of select="$description"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"file": "</xsl:text>
        <xsl:value-of select="basename"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"access_right" : "</xsl:text>
        <xsl:value-of select="'open'"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"journal_pages" : "</xsl:text>
        <xsl:value-of select="pagination"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"journal_title" : "</xsl:text>
        <xsl:value-of select="journalOrPublisher"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"journal_volume" : "</xsl:text>
        <xsl:value-of select="volume"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"publication_type" : "</xsl:text>
        <xsl:value-of select="'article'"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"publication_date" : "</xsl:text>
        <xsl:choose>
            <xsl:when test="normalize-space(pubDate/text())">
                <xsl:value-of select="pubDate"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="year"/>
                <xsl:text>-12-31</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>",</xsl:text>
        <xsl:text>"keywords": ["Biodiversity","Taxonomy","Animalia","Arthropoda","Insecta","Diptera","Drosophilidae", "flies", "fruit flies", "terrestrial"],</xsl:text>
        <xsl:text>"license" : "</xsl:text>
        <xsl:value-of select="'cc-by'"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"creators" : [</xsl:text>
        <xsl:apply-templates
            select="*[starts-with(local-name(), 'author_')][normalize-space(./text())]"/>
        <xsl:text>],</xsl:text>
        <xsl:text>"communities" : [{"identifier":"biosyslit"}]</xsl:text>
        <xsl:text>}}</xsl:text>
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
        <!--            
      "title" : "Fourmis de Tunisie et de l'Algérie orientale.",
      "upload_type" : "publication",
      "description" : "Uploaded by Plazi from Antbase. HNS:3926",
      "HNS_NUM" : 3926,
      "access_right" : "open",
      "journal_pages" : "lxi-lxxvi",
      "journal_title" : "Annales de la Société Entomologique de Belgique, Comptes-rendus des Seances",
      "journal_volume" : "34",
      "publication_type" : "article",
      "publication_date" : "1890-12-31",
      "license" : "cc-by",
      "creators":[{"name" : "Forel, A.", "affiliation" : null}],
      "communities":[{"identifier":"biosyslit"}]
    }},-->
    </xsl:template>

    <xsl:template match="row" mode="book">
        <xsl:variable name="description">
            <xsl:value-of select="Reference"/>
        </xsl:variable>
        <xsl:text>{"metadata": {</xsl:text>
        <xsl:text>"title" : "</xsl:text>
        <xsl:value-of select="taxon_name"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"upload_type" : "</xsl:text>
        <xsl:value-of select="'publication'"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"description" : "</xsl:text>
        <xsl:value-of select="$description"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"file": "</xsl:text>
        <xsl:value-of select="substring-before(file_name, '.')"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"access_right" : "</xsl:text>
        <xsl:value-of select="'open'"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"partof_pages" : "</xsl:text>
        <xsl:value-of select="journal_pages"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"partof_title" : "</xsl:text>
        <xsl:value-of select="journal_title"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"publication_type" : "</xsl:text>
        <xsl:value-of select="'other'"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"publication_date" : "</xsl:text>
        <xsl:value-of select="replace(publication_date, '\]', '')"/>
        <xsl:text>-12-31</xsl:text>
        <xsl:text>",</xsl:text>
        <xsl:text>"license" : "</xsl:text>
        <xsl:value-of select="'cc-by'"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"creators" : [</xsl:text>
        <xsl:apply-templates select="creator1_name[text()] | creator2_name[text()]"/>
        <xsl:text>],</xsl:text>
        <xsl:text>"communities" : [{"identifier":"biosyslit"}]</xsl:text>
        <xsl:text>}}</xsl:text>
        <xsl:text>,</xsl:text>
        <!--            
      "title" : "Fourmis de Tunisie et de l'Algérie orientale.",
      "upload_type" : "publication",
      "description" : "Uploaded by Plazi from Antbase. HNS:3926",
      "HNS_NUM" : 3926,
      "access_right" : "open",
      "journal_pages" : "lxi-lxxvi",
      "journal_title" : "Annales de la Société Entomologique de Belgique, Comptes-rendus des Seances",
      "journal_volume" : "34",
      "publication_type" : "article",
      "publication_date" : "1890-12-31",
      "license" : "cc-by",
      "creators":[{"name" : "Forel, A.", "affiliation" : null}],
      "communities":[{"identifier":"biosyslit"}]
    }},-->
    </xsl:template>

    <xsl:template match="*[starts-with(local-name(), 'author_')]">
        <xsl:text>{"name" :"</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>", "affiliation" : null}</xsl:text>
        <xsl:if test="following-sibling::*[starts-with(local-name(), 'author_')][text()]">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
