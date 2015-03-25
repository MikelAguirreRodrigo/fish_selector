#! /bin/bash

## selecionar las reads pertenecientes a los taxones de los peces
egrep "HERRI|SPRAT|PILCH|ANCHO" ALL_filtered_seqs_otus.txt | perl -lape 's/\s+/\n/sg'| grep '[^P]$' > LISTA_reads_fin.txt
## coger unicamente las secuencias que pretencezcan a esos taxones
filter_fasta.py -f ../../SPLIT_out_FIN/ALL_filtered_seqs.fasta -o fish_select.fasta -s LISTA_reads_fin.txt
## correr el scrip que tiene en cuenta las posiciones de los SNPs
perl select_taxa.pl 
## Nº de seq asignadas a herrin con QIIME al 99% con SILVA 111
egrep "HERRI" ALL_filtered_seqs_otus.txt | perl -lape 's/\s+/\n/sg'| grep '[^P]$'| wc -l
## Nº de seq asignadas a pilchardus con QIIME al 99% con SILVA 111
egrep "PILCH" ALL_filtered_seqs_otus.txt | perl -lape 's/\s+/\n/sg'| grep '[^P]$'| wc -l
## Nº de seq asignadas a anchovy con QIIME al 99% con SILVA 111
egrep "ANCHO" ALL_filtered_seqs_otus.txt | perl -lape 's/\s+/\n/sg'| grep '[^P]$'| wc -l
## Nº de seq asignadas a spratus con QIIME al 99% con SILVA 111
egrep "SPRAT" ALL_filtered_seqs_otus.txt | perl -lape 's/\s+/\n/sg'| grep '[^P]$'| wc -l
