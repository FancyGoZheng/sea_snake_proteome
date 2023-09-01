install.packages("spiralize")


library(spiralize)
#help(package="spiralize")

#### 数据格式处理
lines = readLines("input/input.fa")
query = lines[seq(1, length(lines), by = 4)]
subject = lines[seq(3, length(lines), by = 4)]

query = gsub("^\\S+\\s+\\S+\\s+|\\s+\\S+$", "", query)
query = paste(query, collapse = "")
query = strsplit(query, "")[[1]]

subject = gsub("^\\S+\\s+\\S+\\s+|\\s+\\S+$", "", subject)
subject = paste(subject, collapse = "")
subject = strsplit(subject, "")[[1]]


# ###  我自己的数据格式处理
library(Biostrings)

fasta <- readAAStringSet("input/VF_uniport.fa")



seq_names <- names(fasta)


seqs <- as.character(fasta)

for (i in seq_along(seqs))
{
  assign(seq_names[i],seqs[i])
}
subject<- strsplit(Q91132, "")[[1]]


query <- strsplit(`HhUnT022443.2 `, "")[[1]]




length(query)
length(subject)







#The plot is mainly drawn with spiral_text() and spiral_segments().

n = length(query)
#col = c("A" = 2, "T" = 4, "C" = 3, "G" = 7, "-" = "black")

col = c(
  "A"=1,
  "F"=2,
  "C"=3,
  "U"=4,
  "D"=5,
  "N"=6,
  "E"=7,
  "Q"=8,
  "G"=9,
  "H"=10,
  "L"=11,
  "I"=12,
  "K"=13,
  "O"=14,
  "M"=15,
  "P"=16,
  "R"=17,
  "S"=18,
  "T"=19,
  "V"=20,
  "W"=21,
  "Y"=22,
  "-" = "black"
)

spiral_initialize(xlim = c(0, n), start = 180, end = 360*6, scale_by = "curve")  ### 360*6 六是圈数
spiral_track(height = 0.6)
spiral_text(1:n - 0.5, 0.3, query, facing = "inside", 
            gp = gpar(fontsize = 6, col = col[query]), just = "top",)
spiral_text(1:n - 0.5, 0.7, subject, facing = "inside", 
            gp = gpar(fontsize = 6, col = col[subject]), just = "bottom")
x = which(query == subject)
spiral_segments(x - 0.5, 0.35, x - 0.5, 0.65, gp = gpar(col = "#449444")) #此处是调节相同aa的连线

spiral_track(height = 0.1, background = FALSE)
spiral_lines(TRACK_META$xlim, 0.5, gp = gpar(col = "#925888")) ### 此处是调节外圈线条的颜色等属性
at = seq(10, n, by = 10)
spiral_points(at, 0.5, pch = 16, size = unit(3, "pt"))
l = at %% 100 == 0
spiral_text(at[l] - 0.5, 1, paste0(at[l], "bp"), just = "bottom",
            facing = "inside", nice_facing=T, gp = gpar(fontsize = 6, col = "#954122"))  ##  此处调节刻度尺 多少bp了








