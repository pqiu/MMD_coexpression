# MMD_coexpression

Open MATLAB and run the script demo_MMD.m

This demo first loads a small scRNA-seq dataset in the folder "MSC_data". This dataset contains expression profiles for 914 cells, which form 6 clusters. 

![image](https://user-images.githubusercontent.com/18299367/193498495-b752183e-bef6-40fc-ad63-74816c323782.png)


Then the script computes the MMD coexpression score for every gene agains a particular target gene of interest (Stat5b). Smaller MMD score means higher co-expression. 

Finally, the scores are sorted, and expression of the top 8 most co-expressed genes are visualized. By construction, #1 in the co-expressed gene list is the target gene Stat5b itself. Visualizations of the other 7 top genes show that the most highly co-expressed genes from MMD analysis exhibit similar expression pattern/distribution compared to the target gene. 

![image](https://user-images.githubusercontent.com/18299367/193498540-ec6dc91e-66dc-4271-a57d-e90f43c82b6e.png)
