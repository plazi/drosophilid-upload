<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="UTF-8" indent="yes"/>
    <!-- Whenever you match any node or any attribute -->
    <xsl:template match="node()|@*">

        <!-- Copy the current node -->
        <xsl:copy>

            <!-- Including any attributes it has and any child nodes -->
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="journalOrPublisher">
        <journalOrPublisher>
            <xsl:apply-templates/>
        </journalOrPublisher>
        <full_name>
            <xsl:for-each select="document('journal_map.xml')//abbr[text() = current()/text()]">
                <xsl:value-of select="normalize-space(following-sibling::full_name/text())"/>
            </xsl:for-each>
        </full_name>
    </xsl:template>
</xsl:transform>
