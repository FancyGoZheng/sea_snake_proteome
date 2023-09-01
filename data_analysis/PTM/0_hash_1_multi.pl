open IN, "$ARGV[0]" ;#"$ARGV[0]";#输入序列文件
open OUT,">1-1.result.txt";
while(<IN>){	
	chomp;
	# $_ =~ tr/\]//d; # 上来删除多余字符‘[’  和‘]’
	# $_ =~ tr/\[//d;
	my($mod,$id1,$pep) =  (split(/\t/,$_))[0,2,1];# 切片完分给各个变量
	@gid = split(/;/, $id1);
	for(@gid)
	{
		print OUT "$mod","\t","$pep","\t","$_","\n";
	}
	#@name=split(/\t/,$_);
	#print @name[0],"\t",@name[8],"\n";
	#if(/>(\S+)/){$id=$1;$n++;next}#排除标题行的长度
	#chomp;#出去行尾符对长度的影响
	#$kid = $name[0];
	#@gid111 = split(/\[/,$name[8]);
	## 赋值给哈希
	 
	#$gid11  = split(/,\s/,@gid111);
	#@gid = split(/,/,split(/\]/,split(/\[/,$name[8])));
	#print "$kid","\n";
	#print "@gid","\n";
	#$kegg{$id}.=$_;#某contig序列
	

	#for(@gid){$go{$_}=$kid};
}
# foreach(sort {$go{$a}<=>$go{$b}}keys %go)
# {print "$_->$go{$_}\n";};
