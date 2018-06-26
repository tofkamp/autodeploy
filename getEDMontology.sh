
# download ontology's for EDM
FILEGRAPHPATH=/usr/local/vitrolib/home/rdf/tbox/filegraph
#FILEGRAPHPATH=/usr/local/vivo/home/rdf/tbox/filegraph
#dc:	http://purl.org/dc/elements/1.1/
wget --header "Accept: application/rdf+xml" http://purl.org/dc/elements/1.1/ -O $FILEGRAPHPATH/dc.rdf
#dcterms:http://purl.org/dc/terms/
wget --header "Accept: application/rdf+xml" http://purl.org/dc/terms/ -O $FILEGRAPHPATH/dcterms.rdf
#edm:	http://www.europeana.eu/schemas/edm/
wget --header "Accept: application/rdf+xml" "http://www.europeana.eu/schemas/edm/" -O $FILEGRAPHPATH/edm.rdf
#ore:	http://www.openarchives.org/ore/terms/	
wget --header "Accept: application/rdf+xml" "http://www.openarchives.org/ore/terms/" -O $FILEGRAPHPATH/ore.rdf
#owl:	http://www.w3.org/2002/07/owl#
wget --header "Accept: application/rdf+xml" "http://www.w3.org/2002/07/owl#" -O $FILEGRAPHPATH/owl.rdf
#rdf:	http://www.w3.org/1999/02/22-rdf-syntax-ns#
wget --header "Accept: application/rdf+xml" "http://www.w3.org/1999/02/22-rdf-syntax-ns#" -O $FILEGRAPHPATH/rdf.rdf
#foaf:	http://xmlns.com/foaf/0.1/
wget --header "Accept: application/rdf+xml" "http://xmlns.com/foaf/0.1/" -O $FILEGRAPHPATH/foaf.rdf
#skos:	http://www.w3.org/2004/02/skos/core#
wget --header "Accept: application/rdf+xml" "http://www.w3.org/2004/02/skos/core#" -O $FILEGRAPHPATH/skos.rdf
#rdau:	http://www.rdaregistry.info/Elements/u/
wget --header "Accept: application/rdf+xml" http://rdaregistry.info/Elements/u.xml -O $FILEGRAPHPATH/rdau.rdf
#wgs84_pos:http://www.w3.org/2003/01/geo/wgs84_pos#	
wget --header "Accept: application/rdf+xml" "http://www.w3.org/2003/01/geo/wgs84_pos#" -O $FILEGRAPHPATH/wgs84_pos.rdf
#crm:	http://www.cidoc-crm.org/cidoc-crm/
wget --header "Accept: application/rdf+xml" http://www.cidoc-crm.org/sites/default/files/cidoc_crm_v5.0.4_official_release.rdfs -O $FILEGRAPHPATH/cidoc-crm.rdf
#cc:	http://creativecommons.org/ns#
wget --header "Accept: application/rdf+xml" https://creativecommons.org/schema.rdf -O $FILEGRAPHPATH/cc.rdf

#    <owl:Ontology rdf:about="http://www.europeana.eu/schemas/edm/">
#        <rdfs:label xml:lang="en-US">Europeana</rdfs:label>
#        <vitro:ontologyPrefixAnnot xml:lang="en-US">edm</vitro:ontologyPrefixAnnot>
#    </owl:Ontology>

awk -F\; 'BEGIN {
print "<?xml version=\"1.0\"?>"
print "<rdf:RDF xmlns=\"http://purl.obolibrary.org/obo/arg/role.owl#\""
print "     xml:base=\"http://purl.obolibrary.org/obo/arg/role.owl\""
print "     xmlns:obo=\"http://purl.obolibrary.org/obo/\""
print "     xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\""
print "     xmlns:owl=\"http://www.w3.org/2002/07/owl#\""
print "     xmlns:xsd=\"http://www.w3.org/2001/XMLSchema#\""
print "     xmlns:vitro=\"http://vitro.mannlib.cornell.edu/ns/vitro/0.7#\""
print "     xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">"
}
{print "<owl:Ontology rdf:about=\"" $2 "\">"
        print "    <rdfs:label xml:lang=\"en-US\">" $3 "</rdfs:label>"
        print "    <vitro:ontologyPrefixAnnot xml:lang=\"en-US\">" $1 "</vitro:ontologyPrefixAnnot>"
        print "</owl:Ontology>" }
END { print "</rdf:RDF>" } ' >$FILEGRAPHPATH/EDMontologies.owl << EOF
edm;http://www.europeana.eu/schemas/edm/;EDM (Europeana Data Model);
dc;http://purl.org/dc/elements/1.1/;DC (Dublin Core Metadata Initiative);
dcterms;http://purl.org/dc/terms/;DC (DCMI Metadata Terms);
ore;http://www.openarchives.org/ore/terms/;ORE (The OAI ORE terms vocabulary);
owl;http://www.w3.org/2002/07/owl#;OWL (The OWL 2 Schema vocabulary);
rdf;http://www.w3.org/1999/02/22-rdf-syntax-ns#;RDF (The RDF Concepts Vocabulary);
foaf;http://xmlns.com/foaf/0.1/;FOAF (Friend of a Friend);
skos;http://www.w3.org/2004/02/skos/core#;SKOS (Simple Knowledge Organization System);
rdau;http://www.rdaregistry.info/Elements/u/;RDAU (RDA Unconstrained properties);
wgs84_pos;http://www.w3.org/2003/01/geo/wgs84_pos#;WGS84 (Geo Positioning);
crm;http://www.cidoc-crm.org/cidoc-crm/;CRM (CIDOC Conceptual Reference Model);
cc;http://creativecommons.org/ns#;CC (Creative Commons Rights Expression Language);
EOF
