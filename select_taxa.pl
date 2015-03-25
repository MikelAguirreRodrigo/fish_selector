#!/usr/bin/perl 
use strict;
$|=1;
open (FASTA, 'fish_select.fasta');	# HERRI_FIN.fa	# ANCHO_FIN.fa		# PILCH_FIN.fa		SPRAT_FIN.fa
open (SEQS, '+>results_FINAL_total.txt');
#open (CLUPE, '+>results_clupea.fa');

my %species = ('CGC'=>'Clupea_harengus','CAT'=>'Sprattus_sprattus','TGC'=>'Sardina_pilchardus','CGT'=>'Engraulis_encrasicolus');
my $taxa='';
my $a='';
my $lines='';
my $uno='';
my $dos='';
my $tre='';
my @seq=();
my $res1='';
my @clupea=();
my @spratus=();
my @sardina=();
my @engraulis=();
my @other=();
my $trip='';
my $clupea='';
my $spratus='';
my $sardina='';
my $engraulis='';
my $other='';
my $o='';
my $i=0;
my $j = '';
my $len = '';
my $raro = 0;
foreach (<FASTA>){
	my $line = $_;
	chomp($line);
	#print "$line\n";
	if ($line =~ /^>(.+)\_\d+\sM02149.+/){
		$a=1;
		$taxa=$1;
	}
	if ($line =~ /^[ACGT]/ && $a){
		# eliminar hasta los nulceotidos TACTACCGATTGGATG [la ultima G tiene la posicion 33] empezar a contar desde la 34 como si fuera 1
	# hacer cd-hit al 100 y despues ver que parametros serian los adecuados para als secuencias que queden. GCTACTACCGATT
		$a='';

		if ($line =~ /^[ACGT]\w+TACCGAT(\w+)/){
			$lines=$1;
			$len = length $lines;
			if ($len < 115) {
				$line = '';
				$raro++;
				next;
			}
		}

		@seq = split('', $lines);
		$uno=$seq[21];	# la posicion 34 (-12) [22 tras alin] 60?	47
		$dos=$seq[38];	# la posicion 51 (-12) [39 tras alin] 76?	63
		$tre=$seq[47];	# la posicion 60 (-12) [48 tras alin] 86?	73
		$trip= "$uno$dos$tre";
		#print "$trip\n";
		$res1=$species{$trip};
		
		if (!$res1){
			push(@other,$trip);
		}

		if ($trip eq 'CGC' && $res1){
			push(@clupea,$taxa);
			#print CLUPE ">$taxa\n$lines\n";
		}

		if ($trip eq 'CAT' && $res1){
			push(@spratus,$taxa);
		}

		if ($trip eq 'TGC' && $res1){
			push(@sardina,$taxa);
		}

		if ($trip eq 'CGT' && $res1){
			push(@engraulis,$taxa);
		}
	}
}
############################################
my $head='';
my $a=0;
my $data='';
my $reser='';
my @clupea2=();
my @clupea3=();
my @clupea4=();
$clupea=scalar(@clupea);
print "Clupea_harengus OTU Nº: $clupea\n";
my @clupea2 =sort(@clupea);
for ($i=0; $i<=scalar@clupea2; $i++){
	$data=$clupea2[$i];
	if ($reser){
		if ($data eq $reser){
			$a++;
		}
		if ($data ne $reser){
			push(@clupea3, $reser);
			push(@clupea4, $a);
			$a=0;
			$reser=$data;
		}
	}
	else{
		$reser=$data;
	}
	
}

foreach $o (@clupea3){
	$head .="\t$o";
}
print SEQS "taxon$head\ttotal\n";
$head='';
foreach $o (@clupea4){

	$o++;

	$head .="\t$o";
}

print SEQS "Clupea_harengus(CGC)$head\t$clupea\n";
$head='';
#####################################################
$spratus=scalar(@spratus);
print "Sprattus_sprattus OTU Nº: $spratus\n";
$reser='';
my @spratus2=();
my @spratus3=();
my @spratus4=();
my @spratus2 =sort(@spratus);
for ($i=0; $i<=scalar@spratus2; $i++){
	$data=$spratus2[$i];
	if ($reser){
		if ($data eq $reser){
			$a++;
		}
		if ($data ne $reser){
			push(@spratus3, $reser);
			push(@spratus4, $a);
			$a=0;
			$reser=$data;
		}
	}
	else{
		$reser=$data;
	}
	
}

foreach $o (@spratus3){
	$head .="\t$o";
}
print SEQS "taxon$head\ttotal\n";
$head='';

foreach $o (@spratus4){
	$o++;

	$head .="\t$o";
}
print SEQS "Sprattus_sprattus(CAT)$head\t$spratus\n";
$head='';
####################################################
$sardina=scalar(@sardina);
print "Sardina_pilchardus OTU Nº: $sardina\n";
$reser='';
my @sardina2=();
my @sardina3=();
my @sardina4=();
my @sardina2 =sort(@sardina);
for ($i=0; $i<=scalar@sardina2; $i++){
	$data=$sardina2[$i];
	if ($reser){
		if ($data eq $reser){
			$a++;
		}
		if ($data ne $reser){
			push(@sardina3, $reser);
			push(@sardina4, $a);
			$a=0;
			$reser=$data;
		}
	}
	else{
		$reser=$data;
	}
	
}

foreach $o (@sardina3){
	$head .="\t$o";
}
print SEQS "taxon$head\ttotal\n";
$head='';

foreach $o (@sardina4){
	$o++;

	$head .="\t$o";
}
print SEQS "Sardina_pilchardus(TGC)$head\t$sardina\n";
$head='';
####################################################
$engraulis=scalar(@engraulis);
print "Engraulis_encrasicolus OTU Nº: $engraulis\n";
$reser='';
my @engraulis2=();
my @engraulis3=();
my @engraulis4=();
my @engraulis2 =sort(@engraulis);
for ($i=0; $i<=scalar@engraulis2; $i++){
	$data=$engraulis2[$i];
	if ($reser){
		if ($data eq $reser){
			$a++;
		}
		if ($data ne $reser){
			push(@engraulis3, $reser);
			push(@engraulis4, $a);
			$a=0;
			$reser=$data;
		}
	}
	else{
		$reser=$data;
	}
	
}

foreach $o (@engraulis3){
	$head .="\t$o";
}
print SEQS "taxon$head\ttotal\n";
$head='';

foreach $o (@engraulis4){
	$o++;

	$head .="\t$o";
}
print SEQS "Engraulis_encrasicolus(CGT)$head\t$engraulis\n";
$head='';
##########################################
$other=scalar(@other);
print "Other OTU Nº: $other\n";
$reser='';
my @other2=();
my @other3=();
my @other4=();
my @other2 =sort(@other);
for ($i=0; $i<=scalar@other2; $i++){
	$data=$other2[$i];
	if ($reser){
		if ($data eq $reser){
			$a++;
		}
		if ($data ne $reser){
			push(@other3, $reser);
			push(@other4, $a);
			$a=0;
			$reser=$data;
		}
	}
	else{
		$reser=$data;
	}
	
}

foreach $o (@other3){
	$head .="\t$o";
}
print SEQS "taxon$head\ttotal\n";
$head='';

foreach $o (@other4){
	$o++;
	$head .="\t$o";
}
print SEQS "Others$head\t$other\n";
$head='';
###############################################
print "SEQ < 150 nt: $raro\n";
print SEQS "SEQ < 150 nt:\t$raro\n";
my $total = $raro+$other+$engraulis+$sardina+$clupea+$spratus;
print "SEQ totales: $total\n";
print SEQS "SEQ totales:\t$total\n";
close(FASTA);
close(SEQS);

exit;
