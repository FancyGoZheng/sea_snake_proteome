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

}

