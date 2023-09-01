import pymol
from pymol import cmd
import os 
import itertools
import pandas as pd
########## 读入当前目录下pdb文件
align_data = []



for root, dirs, files in os.walk('.'):
    for dir in dirs:
        os.chdir(dir)
            #### 进入到不同的pdb文件目录
            #dir = '3FTx'
        pdb_list =  [f for f in os.listdir() if f.endswith('.pdb')]
        for i in pdb_list:
            cmd.load(i)
        pdb_files = pymol.cmd.get_object_list()
        combinations = list(itertools.combinations(pdb_files, 2))
            #### 进入目录后将pdb文件加载入pymol中，然后生成两两配对列表
        for i in range(0,len(combinations)):
                #print(i)
            a = pymol.cmd.align(combinations[i][0],combinations[i][1])
            align_data.append([dir, combinations[i][0], combinations[i][1], a[0], a[1], a[2],a[3],a[4],a[5],a[6]])
                # print(dir,end='\t')
                # print(combinations[i][0],end="\t")
                # print(combinations[i][1],end="\t")
                # print(a[0],end="\t")
                # print(a[1],end="\t")
                # print(a[2],end="\n")
                
        os.chdir('..')
        cmd.delete("all") # 一个文件夹算完后情况当前pymol列表中的对象，以防止不同家族之间串数据
        pdb_files = pymol.cmd.get_object_list()
df = pd.DataFrame(align_data, columns=['dir', 'protein_1', 'protein_2', 'RMSD after refinement', 'Number of aligned atoms after refinement', 'Number of refinement cycles','RMSD before refinement','Number of aligned atoms before refinement','Raw alignment score','Number of residues aligned'])    


df.to_csv('Hh_toxin_gene_RMSD_output.csv', index=False)



#cmd.quit()





























