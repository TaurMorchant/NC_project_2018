<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="journal">
        <xsl:apply-templates select="name"/>
        <xsl:apply-templates select="description"/>
    </xsl:template>

    <xsl:template match="name">
        <tr>
            <td>Name</td>
            <td>
                <input type="text" id="addname" class="form-control" name="Name">
                    <xsl:attribute name="value">
                        <xsl:value-of select="text()"/>
                    </xsl:attribute>
                </input>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="description">
        <tr>
            <td>Description</td>
            <td>
                <input type="text" class="form-control" name="Description">
                    <xsl:attribute name="value">
                        <xsl:value-of select="text()"/>
                    </xsl:attribute>
                </input>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>