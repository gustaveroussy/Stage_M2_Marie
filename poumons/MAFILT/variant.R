
#entrer le maf sur R 
variants<-data.table::fread("final_uniq.csv")
colnames(variants)=c("Hugo_Symbol", "Entrez_Gene_Id","Chromosome", "Start_Position", "End_Position","Variant_Classification", "Variant_Type", "Reference_Allele", "Tumor_Seq_Allele2" , "Tumor_Sample_Barcode","HGVSp","Gene", "DP", "IMPACT")

#renommer les classes de variants pour maftools
variant_classi= read.csv("list_classification_variants.csv",header = TRUE,stringsAsFactors=FALSE) #liste qui regroupe totus nos classification en celles comprises par maftools
classes=names(variant_classi)

SILENT_LIST=variant_classi$Silent[!is.na(variant_classi$Silent)]
variants$Variant_Classification[variants$Variant_Classification %in% SILENT_LIST]="Silent"

MISSENSE_LIST=variant_classi$Missense_Mutation[!is.na(variant_classi$Missense_Mutation)]
variants$Variant_Classification[variants$Variant_Classification %in% MISSENSE_LIST]="Missense_Mutation"

NONSENSE_LIST=variant_classi$Nonsense_Mutation[!is.na(variant_classi$Nonsense_Mutation)]
variants$Variant_Classification[variants$Variant_Classification %in% NONSENSE_LIST]="Nonsense_Mutation"

FRAMESHIF_INS_LIST=variant_classi$Frame_Shift_Ins[!is.na(variant_classi$Frame_Shift_Ins)]
variants$Variant_Classification[variants$Variant_Classification %in% FRAMESHIF_INS_LIST]="Frame_Shift_Ins"

IN_FRAME_INS_LIST=variant_classi$In_Fram_Ins[!is.na(variant_classi$In_Fram_Ins)]
variants$Variant_Classification[variants$Variant_Classification %in% IN_FRAME_INS_LIST]="In_Frame_Ins"

IN_FRAME_DEL_LIST=variant_classi$In_Fram_Del[!is.na(variant_classi$In_Fram_Del)]
variants$Variant_Classification[variants$Variant_Classification %in% IN_FRAME_DEL_LIST]="In_Frame_Del"

TRANSLATION_LIST=variant_classi$Translation_Start_Site[!is.na(variant_classi$Translation_Start_Site)]
variants$Variant_Classification[variants$Variant_Classification %in% TRANSLATION_LIST]="Translation_Start_Site"

NONSTOP_LIST=variant_classi$Nonstop_Mutation[!is.na(variant_classi$Nonstop_Mutation)]
variants$Variant_Classification[variants$Variant_Classification %in% NONSTOP_LIST]="Nonstop_Mutation"

SPLICE_LIST=variant_classi$Splice_Site[!is.na(variant_classi$Splice_Site)]
variants$Variant_Classification[variants$Variant_Classification %in% SPLICE_LIST]="Splice_Site"

X5_LIST=variant_classi$X5.UTR[!is.na(variant_classi$X5.UTR)]
variants$Variant_Classification[variants$Variant_Classification %in% X5_LIST] <- "5'UTR"

X3_LIST=variant_classi$X3.UTR[!is.na(variant_classi$X3.UTR)]
variants$Variant_Classification[variants$Variant_Classification %in% X3_LIST] <- "3'UTR"

IGR_LIST=variant_classi$IGR[!is.na(variant_classi$IGR)]
variants$Variant_Classification[variants$Variant_Classification %in% IGR_LIST] <- "IGR"

INTRON_LIST=variant_classi$Intron[!is.na(variant_classi$Intron)]
variants$Variant_Classification[variants$Variant_Classification %in% INTRON_LIST] <- "Intron"

variants$Variant_Type[variants$Variant_Type=="ONP"]="TNP"


write.table(variants, file="final_rename.csv", quote=FALSE, sep="\t", row.names = FALSE)
save(variants,file="variants_rename.RData")
 
variants_filt <- variants[variants$Variant_Classification %in% c("Missense_Mutation", "Nonsense_Mutation","Frame_Shift_Ins","In_Fram_Ins","In_Fram_Del","Translation_Start_Site",
 "Nonstop_Mutation","Splice_Site"),]

write.table(variants_filt, file="final_filt.csv", quote=FALSE, sep="\t", row.names = FALSE)
save(variants_filt, file= "variants_filt.RData")

variants_hugo <- subset(variants_filt, Hugo_Symbol != ".")
write.table(variants_hugo, file="final_hugo.csv", quote=FALSE, sep="\t", row.names = FALSE)
save(variants_hugo, file= "variants_hugo.RData")

