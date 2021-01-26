#!/usr/bin/perl
use strict;
#################################################################
# 
# perl summary.pl $ARGV[0] 
# 
# perl summary.pl file.csv 
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
my (%$LowAK_0W_28,%LowAK_4W_28,%LowAK_8W_28);

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
    
    $Kingdom="K_$tmp[0]";
    $Phylum="P_$tmp[1]";
    $Class="C_$tmp[2]";
    $Order="O_$tmp[3]";
    $Family="F_$tmp[4]";
    $Genus="G_$tmp[5]";
    $Species="S_$tmp[6]";
    
    $name = "$Kingdom|$Phylum|$Class|$Order|$Family|$Genus|$Species";
    
    $HBP_0W{$name} = $tmp[7];
    $HBP_4W{$name} = $tmp[8];
    $HBP_8W{$name} = $tmp[9];
    $LBP_0W{$name} = $tmp[10];
    $LBP_4W{$name} = $tmp[11];
    $LBP_8W{$name} = $tmp[12];
    $NBP_0W{$name} = $tmp[13];
    $NBP_4W{$name} = $tmp[14];
    $NBP_8W{$name} = $tmp[15];
    $CKP_0W{$name} = $tmp[16];
    $CKP_4W{$name} = $tmp[17];
    $CKP_8W{$name} = $tmp[18];
    $CKAK_0W_37{$name} = $tmp[19];
    $CKAK_4W_37{$name} = $tmp[20];
    $CKAK_8W_37{$name} = $tmp[21];
    $LowAK_0W_37{$name} = $tmp[22];
    $LowAK_4W_37{$name} = $tmp[23];
    $LowAK_8W_37{$name} = $tmp[24];
    $CKAK_0W_28{$name} = $tmp[25];
    $CKAK_4W_28{$name} = $tmp[26];
    $CKAK_8W_28{$name} = $tmp[27];
    $LowAK_0W_28{$name} = $tmp[28];
    $LowAK_4W_28{$name} = $tmp[29];
    $LowAK_8W_28{$name} = $tmp[30];
    
    
    #
}

close IN;
# 比較在持續發酵八周期間: 
# (1). 7.5%與1.5% NaCl鹽濃度培養下，Akk菌株生長變化
# (2). 37℃與28℃培養溫度培養下， Akk菌株生長變化
# (3). 不同鹽濃度與溫度變化，對Akk菌株與其他菌相之變化(是否添加Akk菌株可抑制其他有害菌)
# (4). 有,無添加Akk菌株情況下，對於AKK菌株其他菌株之菌相變化
# (5). NBP 添加發芽,未發芽及同時添加的情況下，菌相變化

foreach $name(sort keys %HBP_0W)
{
    
    ### HBP 添加發芽花生芽粉
    ### LBP 添加未發芽花生芽粉
    ### NBP 添加發芽及未發芽花生芽粉
    ### CKP 皆未添加
    
    ### CKAK: 7.5% NaCl
    ### LowAK: 1.5% NaCl
    ### 發酵溫度
    
    
    
    
    #############################
    ###                       ###
    ###  HBP 添加發芽花生芽粉  ###
    ###                       ###
    #############################
    if($HBP_0W{$name} eq 0 && $HBP_4W{$name} eq 0 && $HBP_8W{$name} eq 0){}
    else
    {
        print "$name\t$HBP_0W{$name}\t$HBP_4W{$name}\t$HBP_8W{$name}\n";
    }
    
    
    #############################
    ###                       ###
    ### LBP 添加未發芽花生芽粉 ###
    ###                       ###
    #############################
    
    
    
    
    ###################################
    ###                             ###
    ### NBP 添加發芽及未發芽花生芽粉  ###
    ###                             ###
    ###################################
    
    
    #############################
    ###                       ###
    ###     CKP 皆未添加       ###
    ###                       ###
    #############################
    
    
    
    
    #
}







