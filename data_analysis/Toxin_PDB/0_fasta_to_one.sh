toxins.fa | awk '{
if($0~/^>/)a=$0; 
else{
system("echo \\"a"\"\n\""$0a".fasta")
}
}' 