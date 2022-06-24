<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt"
	xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2"
	xmlns:mc="multicorpora:xliffeditor2:xliff-extension"
	exclude-result-prefixes="xalan">

	<xsl:output
		method="xml"
		indent="yes"
		omit-xml-declaration="no"
		standalone="yes"
		xalan:indent-amount="4"/>

	<xsl:strip-space elements="*"/>

	<xsl:param name="otherFilePath"/>

	<xsl:variable name="other" select="document($otherFilePath)" />

	<xsl:template match="/*">
		<xsl:copy>
			<xsl:copy-of select="document('')/*/namespace::mc"/>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="node()">
		<xsl:copy>
			<xsl:apply-templates select="@*">
				<xsl:sort select="local-name()"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="node()">
				<xsl:sort select="local-name()"/>
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@*">
		<xsl:copy>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xliff:body">
		<xsl:copy>
			<xsl:apply-templates select="node()">
				<xsl:sort select="@id"/>
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xliff:trans-unit">
		<xsl:copy>
			<xsl:apply-templates select="@*">
				<xsl:sort select="local-name()"/>
			</xsl:apply-templates>
			<!-- <xsl:apply-templates select="xliff:context-group[@*]"/> -->
			<xsl:variable name="id" select="@id" />
			<xsl:copy-of select="$other//xliff:trans-unit[@id=$id]/xliff:note"/>
			<xsl:apply-templates select="xliff:source"/>
			<xsl:apply-templates select="$other//xliff:trans-unit[@id=$id]/xliff:target"/>
			<!-- <xsl:apply-templates select="$other//xliff:trans-unit[@id=$id]/mc:props"/> -->
			<!-- <xsl:apply-templates select="$other//xliff:trans-unit[@id=$id]/mc:terms"/> -->
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xliff:context-group">
		<xsl:copy>
			<xsl:apply-templates select="@*">
			   <xsl:sort select="local-name()"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="node()">
				<xsl:sort select="@context-type"/>
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="mc:props | mc:terms">
		<xsl:copy>
			<xsl:apply-templates select="@*">
				<xsl:sort select="local-name()"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="mc:prop | xliff:target | xliff:source | mc:term">
		<xsl:copy>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
