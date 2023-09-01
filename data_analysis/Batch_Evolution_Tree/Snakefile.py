## 输出和输出要有强制的连贯性
## "VF","CREC","Ficolin","TCTP","svVEGF","Exendin","CAL"   只出现一个
SAMPLES = ["3FTx","CAL","CST","Ficolin","LIP","NPY","PLB","SVSP","Waprin","5_NT","CATH","DPP","GH56","MCO","PDE","PLI","TCTP","svVEGF","AChE_CES","CREC","EDN_SRTX","KSPI","NGF","PDGF","QPCT","VF","vKUN","AVIT","CRISP","Exendin","LAAO","NP","PLA2","SVMP","Veficolin","vLEC"]
rule all:
    input:
        expand('OUT_MEGA_Tree/{sample}',sample=SAMPLES)
rule MEGA_muscle:
    input:
        'muscle_align_protein.mao',
        'input_data/fasta/{sample}.fa'
    output:
        'OUTPUT_MUSCLE/{sample}.meg'
    shell:
        ' megacc -a {input[0]}  -d {input[1]}  -o {output[0]}  -f  MEGA  '
rule MEGA_tree:
    input:
        'infer_ML_amino_acid.mao',
        'OUTPUT_MUSCLE/{sample}.meg'   
    output:
        'OUT_MEGA_Tree/{sample}'
    shell:
        ' megacc -a {input[0]}  -d {input[1]}  -o {output[0]} '
