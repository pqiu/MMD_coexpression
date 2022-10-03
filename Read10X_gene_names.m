function [raw_gene_names,raw_gene_names2] = Read10X_gene_names(folder_name)

    if ~exist('folder_name','var') || isempty(folder_name)
        folder_name = cd;
    end
    
    % gene names
    fprintf('Loading gene names ... ');
    tic
    fid = fopen(fullfile(folder_name,'genes.tsv'));
    if fid==-1
        filenames_tmp = getfilenames(folder_name);
        filenames_tmp = filenames_tmp(intersect([isInList(filenames_tmp,'gene'),isInList(filenames_tmp,'feature')], isInListEnd(filenames_tmp,'.tsv')));
        fid = fopen(fullfile(folder_name,filenames_tmp{1}));
    end
    d = fread(fid,[1,inf],'char'); d = char(d); fclose(fid);
    d(d==char(13))=[];
    % d(d==char(9)) = char(10);
    gene_names = regexp(d,char(10),'split');
    gene_names(end)=[];
    gene_names = gene_names';
    raw_gene_names2 = gene_names;
    for i=1:length(gene_names)
        if ismember(char(9),gene_names{i})
            tmp = regexp(gene_names{i},char(9),'split');
            tmp(isInList(tmp,'Gene Expr'))=[];
            gene_names{i} = tmp{end};
        end
    end
    raw_gene_names = gene_names;
    toc

end