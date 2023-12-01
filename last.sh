adv=$(whiptail --title "menu" --fb --menu "choose an operation" 15 60 4 \
"1" "pairwise alignment" \
"2" "Multiple sequence  alignment" \
"3" "FASTQ to FASTA" \
"4" "Kmers" 3>&1 1>&2 2>&3)

case $adv in
1)
p=$(whiptail --title "paiwise alignment" --fb --menu "Please choose alignment you want to use" 15 60 4 \
"1" "local" \
'2' "global" 3>&1 1>&2 2>&3)
;;

2)
m=$(whiptail --title "Muliple Sequence alignment" --fb --menu "Please choose an algorithm " 15 60 4 \
"1" "Muscle" \
'2' "Kalign" 3>&1 1>&2 2>&3)

;;

3)
input=$(whiptail --inputbox "Please enter the path of the FASTQ file" 10 70 --title "FASTQ" 3>&1 1>&2 2>&3) 
output=$(whiptail --inputbox "Please enter the output fasta file name" 10 70 --title "FASTA" 3>&1 1>&2 2>&3)
sed -n '1~4s/^@/>/p;2~4p' $input > $output.fasta
whiptail --title " Results" --msgbox "Done!, your results file  is saved" 8 78

;;

4)
python3 kmers.py

;;
esac

case $p in
1)
blast=$(whiptail --title "Blast" --fb --menu "Choose blast type" 15 60 4 \
"1" "blastn" \
'2' "blastp " \
"3" "tblastx" \
"4" "blastx" \
"5" "tblastn" 3>&1 1>&2 2>&3)
;;

2)
needle
;;
esac

case $blast in
1)
Qu=$(whiptail --inputbox "Please enter the file of DNA query" 10 70 --title "QUERY" 3>&1 1>&2 2>&3)
DB=$(whiptail --inputbox "Please enter the file of DNA database" 10 70 --title "Database" 3>&1 1>&2 2>&3)

{
    for ((i=0; i<=100; i+=1)); do
        sleep 1.5
        echo $i
    done
} |whiptail --backtitle "PROGRESS GAUGE" --title "Calculating Result" --gauge "Please wait for calculation" 8 50 0


makeblastdb -in $DB -dbtype nucl
blastn -query $Qu -db $DB -out $Qu.vs.$DB.blastn_results.txt
whiptail --title " Results" --msgbox "Done!, your results DNA file is saved" 8 78
;;

2)
Qu=$(whiptail --inputbox "Please enter the file of protein query" 10 70 --title "QUERY" 3>&1 1>&2 2>&3)

DB=$(whiptail --inputbox "Please enter the file of protein database" 10 70 --title "Database" 3>&1 1>&2 2>&3)

{
    for ((i=0; i<=100; i+=1)); do
        sleep 0.01
        echo $i
    done
} |whiptail --backtitle "PROGRESS GAUGE" --title "Calculating Result" --gauge "Please wait for calculation" 8 50 0


makeblastdb -in $DB -dbtype prot
head -n 6 $Qu > $Qu.small.fasta
blastp -query $Qu.small.fasta -db $DB -out $Qu.vs.$DB.blastp_results.txt
whiptail --title " Results" --msgbox "Done!, your results protein file is saved" 8 78
;;

3)
Qu=$(whiptail --inputbox "Please enter the file of DNA query" 10 70 --title "QUERY" 3>&1 1>&2 2>&3)

DB=$(whiptail --inputbox "Please enter the file of DNA database" 10 70 --title "Database" 3>&1 1>&2 2>&3)


{
    for ((i=0; i<=100; i+=1)); do
        sleep 1.5
        echo $i
    done
} |whiptail --backtitle "PROGRESS GAUGE" --title "Calculating Result" --gauge "Please wait for calculation" 8 50 0

makeblastdb -in $DB -dbtype nucl
head -n 6 $Qu > $Qu.small.fasta
tblastx -query $Qu.small.fasta -db $DB -out $Qu.vs.$DB.tblastx_results.txt
whiptail --title " Results" --msgbox "Done!, your results protein file is saved" 8 78

;;

4)
Qu=$(whiptail --inputbox "Please enter the file of DNA query" 10 70 --title "QUERY" 3>&1 1>&2 2>&3)

DB=$(whiptail --inputbox "Please enter the file of protein database" 10 70 --title "Database" 3>&1 1>&2 2>&3)


{
    for ((i=0; i<=100; i+=1)); do
        sleep 0.01
        echo $i
    done
} |whiptail --backtitle "PROGRESS GAUGE" --title "Calculating Result" --gauge "Please wait for calculation" 8 50 0

makeblastdb -in $DB -dbtype prot
head -n 6 $Qu > $Qu.small.fasta
blastx -query  $Qu.small.fasta -db $DB -out $Qu.vs.$DB.blastx_results.txt
whiptail --title " Results" --msgbox "Done!, your results protein file is saved" 8 78

;;
5)
Qu=$(whiptail --inputbox "Please enter the file of protein query" 10 70 --title "QUERY" 3>&1 1>&2 2>&3)

DB=$(whiptail --inputbox "Please enter the file of DNA database" 10 70 --title "Database" 3>&1 1>&2 2>&3)

{
    for ((i=0; i<=100; i+=1)); do
        sleep 1.5
        echo $i
    done
} |whiptail --backtitle "PROGRESS GAUGE" --title "Calculating Result" --gauge "Please wait for calculation" 8 50 0


makeblastdb -in $DB -dbtype nucl
head -n 6 $Qu > $Qu.small.fasta
tblastn -query $Qu.small.fasta -db $DB -out $Qu.vs.$DB.tblastn_results.txt
whiptail --title " Results" --msgbox "Done!, your results protein file is saved" 8 78


;;
esac

case $m in
1)
format=$(whiptail --title "format" --fb --menu "Choose format" 15 60 4 \
"1" "Clastalw" \
'2' "HTML" \
"3" "MSF" 3>&1 1>&2 2>&3)
;;

2)
input=$(whiptail --inputbox "Please enter name of Multiple sequence file" 10 70 --title "MSA" 3>&1 1>&2 2>&3)
output=$(whiptail --inputbox "Please enter name of output file" 10 70 --title "Output" 3>&1 1>&2 2>&3)
kalign -i $input -f clu -o $output.clu
whiptail --title " Results" --msgbox "Done!, your results file  is saved" 8 78
;;
esac

case $format in
1)
input=$(whiptail --inputbox "Please enter name of Multiple sequence file" 10 70 --title "MSA" 3>&1 1>&2 2>&3)
output=$(whiptail --inputbox "Please enter name of output file" 10 70 --title "Output" 3>&1 1>&2 2>&3)
muscle -in $input -out $output.clw -clw
if (whiptail --title "Results" --yesno "MSA is done!\ndo you want to visualize tree?" 8 78); then     
output_tree=$(whiptail --inputbox "Please enter name of output file" 10 70 --title "TREE" 3>&1 1>&2 2>&3)
muscle -in $input -out $output.clw -clw -tree1 $output_tree.phy
plottree $output_tree.phy
 else
          whiptail --title " Results" --msgbox "You have selected not to show the phylogenetic tree" 8 78


 fi


;;
2)
input=$(whiptail --inputbox "Please enter name of Multiple sequence file" 10 70 --title "MSA" 3>&1 1>&2 2>&3)

output=$(whiptail --inputbox "Please enter name of output file" 10 70 --title "Output" 3>&1 1>&2 2>&3)
muscle -in $input -out $output.html -html
if (whiptail --title "Results" --yesno "MSA is done!\ndo you want to visualize tree?" 8 78); then     
output_tree=$(whiptail --inputbox "Please enter name of output file" 10 70 --title "TREE" 3>&1 1>&2 2>&3)
muscle -in $input -out $output.html -html -tree1 $output_tree.phy
plottree $output_tree.phy
 else
          whiptail --title " Results" --msgbox "You have selected not to show the phylogenetic tree" 8 78


 fi
;;
3)
input=$(whiptail --inputbox "Please enter name of Multiple sequence file" 10 70 --title "MSA" 3>&1 1>&2 2>&3)

output=$(whiptail --inputbox "Please enter name of output file" 10 70 --title "Output" 3>&1 1>&2 2>&3)
muscle -in $input -out $output.msf -msf

if (whiptail --title "Results" --yesno "MSA is done!\ndo you want to visualize tree?" 8 78); then     
output_tree=$(whiptail --inputbox "Please enter name of output file" 10 70 --title "tree" 3>&1 1>&2 2>&3)
muscle -in $input -out $output.msf -msf -tree1 $output_tree.phy

whiptail --title " Results" --msgbox "Done!, your results file  is saved" 8 78
plottree $output_tree.phy
 else
     whiptail --title " Results" --msgbox "You have selected not to show the phylogenetic tree" 8 78

 fi

;;
esac

