%% load an example scRNAseq dataset
[raw_data, raw_gene_names, raw_cell_names] = Read10X('MSC_data');
tmp = importdata('MSC_data/cell_cluster_id.tsv');
cell_labels = tmp.data;
tmp = importdata('MSC_data/cell_tsne_map.tsv');
tsne_map = tmp.data;

scatter(tsne_map(:,1),tsne_map(:,2),30,cell_labels,'fill')


%% pick one target gene of interest in this example
threshold = 0;
gene_ind = find(ismember(upper(raw_gene_names),upper('stat5b')));
cell_ind = raw_data(gene_ind,:)>threshold;
stat5b = [tsne_map(cell_ind,:)];


%% compute MMD
params.sig = -1;
params.shuff = 100; 
params.bootForce = 1;

testStat = [];
fprintf('Looking at gene %5d',0);
for i=1:length(raw_gene_names)
    fprintf('\b\b\b\b\b%5d',i);
    threshold = 0;
    gene_ind = i;
    cell_ind = raw_data(gene_ind,:)>threshold;
    tmp = [tsne_map(cell_ind,:)];
    [testStat(i,1)] = mmd_coexpression(stat5b,tmp,params);
end


%% visualize top co-expressed genes with the target of interest
[~,I] = sort(testStat(:,1),'ascend');
top_genes = raw_gene_names(I(1:8));
for i=1:length(top_genes)
    subplot(2,4,i)
    scatter(tsne_map(:,1),tsne_map(:,2),10,log(1+raw_data(find(ismember(raw_gene_names,top_genes(i))),:)),'fill')
    title(top_genes{i})
end

