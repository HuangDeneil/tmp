#!/usr/bin/perl
use strict;
#################################################################
# 
# perl summary.pl $ARGV[0] $ARGV[1]
# 
# perl summary.pl species.csv s
# 

my @tmp;
my $header;
my ($Kingdom,$Phylum,$Class,$Order,$Family,$Genus,$Species);
my ($HBP_0W,$HBP_4W,$HBP_8W);
my ($LBP_0W,$LBP_4W,$LBP_8W);
my ($NBP_0W,$NBP_4W,$NBP_8W);
my ($CKP_0W,$CKP_4W,$CKP_8W);
my ($CKAK_0W_37, $CKAK_4W_37, $CKAK_8W_37);
my ($LowAK_0W_37,$LowAK_4W_37,$LowAK_8W_37);
my ($CKAK_0W_28, $CKAK_4W_28, $CKAK_8W_28);
my ($LowAK_0W_28,$LowAK_4W_28,$LowAK_8W_28);

my $name;


my (%HBP_0W,%HBP_4W,%HBP_8W);
my (%LBP_0W,%LBP_4W,%LBP_8W);
my (%NBP_0W,%NBP_4W,%NBP_8W);
my (%CKP_0W,%CKP_4W,%CKP_8W);
my (%CKAK_0W_37, %CKAK_4W_37, %CKAK_8W_37);
my (%LowAK_0W_37,%LowAK_4W_37,%LowAK_8W_37);
my (%CKAK_0W_28, %CKAK_4W_28, %CKAK_8W_28);
my (%LowAK_0W_28,%LowAK_4W_28,%LowAK_8W_28);

my $threshold = 0.01;
my $persentage;

$persentage=$threshold*100;
my $low = "under $persentage%";

my @condition=qw/HBP_0W HBP_4W HBP_8W LBP_0W LBP_4W LBP_8W NBP_0W NBP_4W NBP_8W CKP_0W CKP_4W CKP_8W CKAK_0W_37 CKAK_4W_37 CKAK_8W_37 LowAK_0W_37 LowAK_4W_37 LowAK_8W_37 CKAK_0W_28 CKAK_4W_28 CKAK_8W_28 LowAK_0W_28 LowAK_4W_28 LowAK_8W_28/;

# Kingdom,Phylum,Class,Order,Family,Genus,Species,HBP_0W,HBP_4W,HBP_8W,LBP_0W,LBP_4W,LBP_8W,NBP_0W,NBP_4W,NBP_8W,CKP_0W,CKP_4W,CKP_8W,CKAK_0W_37.C,CKAK_4W_37.C,CKAK_8W_37.C,LowAK_0W_37.C,LowAK_4W_37.C,LowAK_8W_37.C,CKAK_0W_28.C,CKAK_4W_28.C,CKAK_8W_28.C,LowAK_0W_28.C,LowAK_4W_28.C,LowAK_8W_28.C
# Archaea,Crenarchaeota,Thermoprotei,Thermoproteales,Thermoproteaceae,Pyrobaculum,Pyrobaculum_sp._M0H,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
# Archaea,Euryarchaeota,Halobacteria,Halobacteriales,Halobacteriaceae,Haloquadratum,uncultured_Haloquadratum_sp.,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
# Archaea,Euryarchaeota,Methanobacteria,Methanobacteriales,Methanobacteriaceae,Methanobrevibacter,Methanobrevibacter_sp._D5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
# Archaea,Euryarchaeota,Methanobacteria,Methanobacteriales,Methanobacteriaceae,Methanobrevibacter,uncultured_Methanobrevibacter_sp.,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
# Archaea,Euryarchaeota,Methanobacteria,Methanobacteriales,Methanobacteriaceae,Methanobrevibacter,uncultured_methanogenic_archaeon,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
# Archaea,Euryarchaeota,Thermoplasmata,Thermoplasmatales,Thermoplasmatales_Incertae_Sedis,uncultured,uncultured_archaeon,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0
# Bacteria,Acidobacteria,Acidobacteria,Acidobacteriales,Acidobacteriaceae_Subgroup_1,Granulicella,uncultured_bacterium,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
# Bacteria,Acidobacteria,Blastocatellia,Blastocatellales,Blastocatellaceae_Subgroup_4,RB41,uncultured_Acidobacteria_bacterium,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
# Bacteria,Acidobacteria,Blastocatellia,Blastocatellales,Blastocatellaceae_Subgroup_4,Stenotrophobacter,uncultured_bacterium,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
# Bacteria,Acidobacteria,Holophagae,Subgroup_10,ABS-19,Acidobacteria_bacterium_WX184,Acidobacteria_bacterium_WX184,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0


#0 Kingdom,
#1 Phylum,
#2 Class,
#3 Order,
#4 Family,
#5 Genus,
#6 Species,
#7 HBP_0W,HBP_4W,HBP_8W, 
#10 LBP_0W,LBP_4W,LBP_8W,
#13 NBP_0W,NBP_4W,NBP_8W,
#16 CKP_0W,CKP_4W,CKP_8W,
#19 CKAK_0W_37.C,CKAK_4W_37.C,CKAK_8W_37.C,
#22 LowAK_0W_37.C,LowAK_4W_37.C,LowAK_8W_37.C,
#25 CKAK_0W_28.C,CKAK_4W_28.C,CKAK_8W_28.C,
#28 LowAK_0W_28.C,LowAK_4W_28.C,LowAK_8W_28.C



open (IN,"$ARGV[0]")||die "$!";
$header = <IN>;
while(<IN>)
{
    chomp;
    @tmp=split ",", $_;
    
    $HBP_0W{"total"} = ($HBP_0W{"total"}+$tmp[7]);
    $HBP_4W{"total"} = $HBP_4W{"total"}+$tmp[8];
    $HBP_8W{"total"} = $HBP_8W{"total"}+$tmp[9];
    $LBP_0W{"total"} = $LBP_0W{"total"}+$tmp[10];
    $LBP_4W{"total"} = $LBP_4W{"total"}+$tmp[11];
    $LBP_8W{"total"} = $LBP_8W{"total"}+$tmp[12];
    $NBP_0W{"total"} = $NBP_0W{"total"}+$tmp[13];
    $NBP_4W{"total"} = $NBP_4W{"total"}+$tmp[14];
    $NBP_8W{"total"} = $NBP_8W{"total"}+$tmp[15];
    $CKP_0W{"total"} = $CKP_0W{"total"}+$tmp[16];
    $CKP_4W{"total"} = $CKP_4W{"total"}+$tmp[17];
    $CKP_8W{"total"} = $CKP_8W{"total"}+$tmp[18];
    $CKAK_0W_37{"total"} = $CKAK_0W_37{"total"}+$tmp[19];
    $CKAK_4W_37{"total"} = $CKAK_4W_37{"total"}+$tmp[20];
    $CKAK_8W_37{"total"} = $CKAK_8W_37{"total"}+$tmp[21];
    $LowAK_0W_37{"total"} = $LowAK_0W_37{"total"}+$tmp[22];
    $LowAK_4W_37{"total"} = $LowAK_4W_37{"total"}+$tmp[23];
    $LowAK_8W_37{"total"} = $LowAK_8W_37{"total"}+$tmp[24];
    $CKAK_0W_28{"total"} = $CKAK_0W_28{"total"}+$tmp[25];
    $CKAK_4W_28{"total"} = $CKAK_4W_28{"total"}+$tmp[26];
    $CKAK_8W_28{"total"} = $CKAK_8W_28{"total"}+$tmp[27];
    $LowAK_0W_28{"total"} = $LowAK_0W_28{"total"}+$tmp[28];
    $LowAK_4W_28{"total"} = $LowAK_4W_28{"total"}+$tmp[29];
    $LowAK_8W_28{"total"} = $LowAK_8W_28{"total"}+$tmp[30];
    #
}

close IN;



open (IN,"$ARGV[0]")||die "$!";
$header = <IN>;
while(<IN>)
{
    chomp;
    @tmp=split ",", $_;
    
    $Kingdom="K_$tmp[0]";
    $Phylum="P_$tmp[1]";
    $Class="C_$tmp[2]";
    $Order="O_$tmp[3]";
    $Family="F_$tmp[4]";
    $Genus="$tmp[5]";
    $Species="$tmp[6]";
    
    if($ARGV[1] eq "s")
    {$name = "G_$Genus|S_$Species";}
    elsif($ARGV[1] eq "g")
    {$name = "$Genus";}
    else 
    {$name = "G_$Genus|S_$Species";}
    
    if($tmp[7]/$HBP_0W{"total"} < $threshold ){$HBP_0W{$low}=$HBP_0W{$low}+$tmp[7]}
    else{$HBP_0W{$name} = $tmp[7];}
    if($tmp[8]/$HBP_4W{"total"} < $threshold ){$HBP_4W{$low}=$HBP_4W{$low}+$tmp[8]}
    else{$HBP_4W{$name} = $tmp[8];}
    if($tmp[9]/$HBP_8W{"total"} < $threshold ){$HBP_8W{$low}=$HBP_8W{$low}+$tmp[9]}
    else{$HBP_8W{$name} = $tmp[9];}
    if($tmp[10]/$LBP_0W{"total"} < $threshold ){$LBP_0W{$low}=$LBP_0W{$low}+$tmp[10]}
    else{$LBP_0W{$name} = $tmp[10];}
    if($tmp[11]/$LBP_4W{"total"} < $threshold ){$LBP_4W{$low}=$LBP_4W{$low}+$tmp[11]}
    else{$LBP_4W{$name} = $tmp[11];}
    if($tmp[12]/$LBP_8W{"total"} < $threshold ){$LBP_8W{$low}=$LBP_8W{$low}+$tmp[12]}
    else{$LBP_8W{$name} = $tmp[12];}
    if($tmp[13]/$NBP_0W{"total"} < $threshold ){$NBP_0W{$low}=$NBP_0W{$low}+$tmp[13]}
    else{$NBP_0W{$name} = $tmp[13];}
    if($tmp[14]/$NBP_4W{"total"} < $threshold ){$NBP_4W{$low}=$NBP_4W{$low}+$tmp[14]}
    else{$NBP_4W{$name} = $tmp[14];}
    if($tmp[15]/$NBP_8W{"total"} < $threshold ){$NBP_8W{$low}=$NBP_8W{$low}+$tmp[16]}
    else{$NBP_8W{$name} = $tmp[15];}
    if($tmp[16]/$CKP_0W{"total"} < $threshold ){$CKP_0W{$low}=$CKP_0W{$low}+$tmp[17]}
    else{$CKP_0W{$name} = $tmp[16];}
    if($tmp[17]/$CKP_4W{"total"} < $threshold ){$CKP_4W{$low}=$CKP_4W{$low}+$tmp[18]}
    else{$CKP_4W{$name} = $tmp[17];}
    if($tmp[18]/$CKP_8W{"total"} < $threshold ){$CKP_8W{$low}=$CKP_8W{$low}+$tmp[19]}
    else{$CKP_8W{$name} = $tmp[18];}
    if($tmp[19]/$CKAK_0W_37{"total"} < $threshold ){$CKAK_0W_37{$low}=$CKAK_0W_37{$low}+$tmp[20]}
    else{$CKAK_0W_37{$name} = $tmp[19];}
    if($tmp[20]/$CKAK_4W_37{"total"} < $threshold ){$CKAK_4W_37{$low}=$CKAK_4W_37{$low}+$tmp[21]}
    else{$CKAK_4W_37{$name} = $tmp[20];}
    if($tmp[21]/$CKAK_8W_37{"total"} < $threshold ){$CKAK_8W_37{$low}=$CKAK_8W_37{$low}+$tmp[22]}
    else{$CKAK_8W_37{$name} = $tmp[21];}
    if($tmp[22]/$LowAK_0W_37{"total"} < $threshold ){$LowAK_0W_37{$low}=$LowAK_0W_37{$low}+$tmp[23]}
    else{$LowAK_0W_37{$name} = $tmp[22];}
    if($tmp[23]/$LowAK_4W_37{"total"} < $threshold ){$LowAK_4W_37{$low}=$LowAK_4W_37{$low}+$tmp[24]}
    else{$LowAK_4W_37{$name} = $tmp[23];}
    if($tmp[24]/$LowAK_8W_37{"total"} < $threshold ){$LowAK_8W_37{$low}=$LowAK_8W_37{$low}+$tmp[15]}
    else{$LowAK_8W_37{$name} = $tmp[24];}
    if($tmp[25]/$CKAK_0W_28{"total"} < $threshold ){$CKAK_0W_28{$low}=$CKAK_0W_28{$low}+$tmp[25]}
    else{$CKAK_0W_28{$name} = $tmp[25];}
    if($tmp[26]/$CKAK_4W_28{"total"} < $threshold ){$CKAK_4W_28{$low}=$CKAK_4W_28{$low}+$tmp[26]}
    else{$CKAK_4W_28{$name} = $tmp[26];}
    if($tmp[27]/$CKAK_8W_28{"total"} < $threshold ){$CKAK_8W_28{$low}=$CKAK_8W_28{$low}+$tmp[27]}
    else{$CKAK_8W_28{$name} = $tmp[27];}
    if($tmp[28]/$LowAK_0W_28{"total"} < $threshold ){$LowAK_0W_28{$low}=$LowAK_0W_28{$low}+$tmp[28]}
    else{$LowAK_0W_28{$name} = $tmp[28];}
    if($tmp[29]/$LowAK_4W_28{"total"} < $threshold ){$LowAK_4W_28{$low}=$LowAK_4W_28{$low}+$tmp[29]}
    else{$LowAK_4W_28{$name} = $tmp[29];}
    if($tmp[30]/$LowAK_8W_28{"total"} < $threshold ){$LowAK_8W_28{$low}=$LowAK_8W_28{$low}+$tmp[30]}
    else{$LowAK_8W_28{$name} = $tmp[30];}

}
close IN;

# 比較在持續發酵八周期間: 
# (1). 7.5%與1.5% NaCl鹽濃度培養下，Akk菌株生長變化
# (2). 37℃與28℃培養溫度培養下， Akk菌株生長變化
# (3). 不同鹽濃度與溫度變化，對Akk菌株與其他菌相之變化(是否添加Akk菌株可抑制其他有害菌)
# (4). 有,無添加Akk菌株情況下，對於AKK菌株其他菌株之菌相變化
# (5). NBP 添加發芽,未發芽及同時添加的情況下，菌相變化

#HBP_0W
open (OUT,">HBP_0W.txt")||die "$!";
foreach (sort keys %HBP_0W)
{
    $persentage = $HBP_0W{$_}/$HBP_0W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total" ){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#HBP_4W
open (OUT,">HBP_4W.txt")||die "$!";
foreach (sort keys %HBP_4W)
{
    $persentage = $HBP_4W{$_}/$HBP_4W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#HBP_8W
open (OUT,">HBP_8W.txt")||die "$!";
foreach (sort keys %HBP_8W)
{
    $persentage = $HBP_8W{$_}/$HBP_8W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#LBP_0W
open (OUT,">LBP_0W.txt")||die "$!";
foreach (sort keys %LBP_0W)
{
    $persentage = $LBP_0W{$_}/$LBP_0W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#LBP_4W
open (OUT,">LBP_4W.txt")||die "$!";
foreach (sort keys %LBP_4W)
{
    $persentage = $LBP_4W{$_}/$LBP_4W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;


#LBP_8W
open (OUT,">LBP_8W.txt")||die "$!";
foreach (sort keys %LBP_8W)
{
    $persentage = $LBP_8W{$_}/$LBP_8W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#NBP_0W
open (OUT,">NBP_0W.txt")||die "$!";
foreach (sort keys %NBP_0W)
{
    $persentage = $NBP_0W{$_}/$NBP_0W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#NBP_4W
open (OUT,">NBP_4W.txt")||die "$!";
foreach (sort keys %NBP_4W)
{
    $persentage = $NBP_4W{$_}/$NBP_4W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#NBP_8W
open (OUT,">NBP_8W.txt")||die "$!";
foreach (sort keys %NBP_8W)
{
    $persentage = $NBP_8W{$_}/$NBP_8W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#CKP_0W
open (OUT,">CKP_0W.txt")||die "$!";
foreach (sort keys %CKP_0W)
{
    $persentage = $CKP_0W{$_}/$CKP_0W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#CKP_4W
open (OUT,">CKP_4W.txt")||die "$!";
foreach (sort keys %CKP_4W)
{
    $persentage = $CKP_4W{$_}/$CKP_4W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#CKP_8W
open (OUT,">CKP_8W.txt")||die "$!";
foreach (sort keys %CKP_8W)
{
    $persentage = $CKP_8W{$_}/$CKP_8W{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#CKAK_0W_37
open (OUT,">CKAK_0W_37.txt")||die "$!";
foreach (sort keys %CKAK_0W_37)
{
    $persentage = $CKAK_0W_37{$_}/$CKAK_0W_37{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#CKAK_4W_37
open (OUT,">CKAK_4W_37.txt")||die "$!";
foreach (sort keys %CKAK_4W_37)
{
    $persentage = $CKAK_4W_37{$_}/$CKAK_4W_37{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#CKAK_8W_37
open (OUT,">CKAK_8W_37.txt")||die "$!";
foreach (sort keys %CKAK_8W_37)
{
    $persentage = $CKAK_8W_37{$_}/$CKAK_8W_37{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#LowAK_0W_37
open (OUT,">LowAK_0W_37.txt")||die "$!";
foreach (sort keys %LowAK_0W_37)
{
    $persentage = $LowAK_0W_37{$_}/$LowAK_0W_37{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#LowAK_4W_37
open (OUT,">LowAK_4W_37.txt")||die "$!";
foreach (sort keys %LowAK_4W_37)
{
    $persentage = $LowAK_4W_37{$_}/$LowAK_4W_37{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#LowAK_8W_37
open (OUT,">LowAK_8W_37.txt")||die "$!";
foreach (sort keys %LowAK_8W_37)
{
    $persentage = $LowAK_8W_37{$_}/$LowAK_8W_37{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#CKAK_0W_28
open (OUT,">CKAK_0W_28.txt")||die "$!";
foreach (sort keys %CKAK_0W_28)
{
    $persentage = $CKAK_0W_28{$_}/$CKAK_0W_28{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#CKAK_4W_28
open (OUT,">CKAK_4W_28.txt")||die "$!";
foreach (sort keys %CKAK_4W_28)
{
    $persentage = $CKAK_4W_28{$_}/$CKAK_4W_28{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#CKAK_8W_28
open (OUT,">CKAK_8W_28.txt")||die "$!";
foreach (sort keys %CKAK_8W_28)
{
    $persentage = $CKAK_8W_28{$_}/$CKAK_8W_28{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#LowAK_0W_28
open (OUT,">LowAK_0W_28.txt")||die "$!";
foreach (sort keys %LowAK_0W_28)
{
    $persentage = $LowAK_0W_28{$_}/$LowAK_0W_28{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#LowAK_4W_28
open (OUT,">LowAK_4W_28.txt")||die "$!";
foreach (sort keys %LowAK_4W_28)
{
    $persentage = $LowAK_4W_28{$_}/$LowAK_4W_28{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;

#LowAK_8W_28
open (OUT,">LowAK_8W_28.txt")||die "$!";
foreach (sort keys %LowAK_8W_28)
{
    $persentage = $LowAK_8W_28{$_}/$LowAK_8W_28{"total"}*100;
    $persentage = sprintf("%.3f", $persentage);
    if( $_ eq "total"){}
    else{print OUT "$_\t$persentage\n";}
}
close OUT;




