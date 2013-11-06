<?xml version="1.0" encoding="ISO-8859-15"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/"
	exclude-result-prefixes="xsl dc">

	<xsl:import href="spCommon.xsl" />
	<xsl:import href="spTitre.xsl" />
	<xsl:import href="spFilDAriane.xsl" />
	<xsl:import href="spOuSAdresser.xsl" />

	<xsl:output method="xml" encoding="ISO-8859-15"
		cdata-section-elements="script" indent="yes" />

	<xsl:template match="/">
		<xsl:call-template name="getTitre" />
		<xsl:call-template name="affLetters" />
		<xsl:apply-templates select="Publication/DossierLetter" />
	</xsl:template>

	<xsl:template name="affLetters">
		<div class="spLetters">
			<xsl:variable name="nb">
				<xsl:value-of select="count(//Publication/DossierLetter)" />
			</xsl:variable>
			<xsl:for-each select="//Publication/DossierLetter">
				<div class="spLetter">
					<xsl:attribute name="style">
						<xsl:text>width:</xsl:text>
						<xsl:value-of select="100 div $nb" />
						<xsl:text>%</xsl:text>
					</xsl:attribute>
					<a>
						<xsl:attribute name="title">
							<xsl:text>Tous les dossiers commen�ant par la lettre </xsl:text>
							<xsl:value-of select="Titre" />
						</xsl:attribute>
						<xsl:attribute name="href">
						  <xsl:value-of select="$REFERER"></xsl:value-of><xsl:value-of
							select="/Publication/@ID"></xsl:value-of><xsl:text>#</xsl:text>
							<xsl:call-template name="createDossierAzId" />
						</xsl:attribute>
						<xsl:value-of select="Titre" />
					</a>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template match="DossierLetter">
		<div class="spDossierLetter">
			<xsl:attribute name="id">
				<xsl:call-template name="createDossierAzId" />
			</xsl:attribute>
			<h2>
				<xsl:value-of select="Titre" />
			</h2>
			<ul class="spDossierLetter">
				<xsl:for-each select="Dossier">
					<xsl:apply-templates select="." />
				</xsl:for-each>
			</ul>
		</div>
		<xsl:call-template name="ancreTop" />
	</xsl:template>

	<xsl:template match="Dossier">
		<li class="spDossierLetter">
			<h3>
				<xsl:call-template name="getPublicationLink">
					<xsl:with-param name="href">
						<xsl:text>LieuLocal-</xsl:text>
						<xsl:value-of select="PivotLocal" />
						<xsl:text>-LieuLocal-</xsl:text>
						<xsl:call-template name="textWithoutAccent">
							<xsl:with-param name="string" select="Titre" />
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="title">
						<xsl:text>Toutes les coordonn�es de : </xsl:text>
						<xsl:value-of select="Titre" />
					</xsl:with-param>
					<xsl:with-param name="text">
						<xsl:value-of select="Titre" />
					</xsl:with-param>
				</xsl:call-template>
			</h3>
		</li>
	</xsl:template>

</xsl:stylesheet>