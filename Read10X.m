function [raw_data,raw_gene_names, raw_cell_names] = Read10X(folder_name)
    
    if ~exist('folder_name','var') || isempty(folder_name)
        folder_name = cd;
    end
    
    % cell names
    [raw_cell_names] = Read10X_cell_names(folder_name);
    % gene names
    [raw_gene_names] = Read10X_gene_names(folder_name);
    % raw_data
    [raw_data] = Read10X_count_matrix(folder_name, raw_gene_names, raw_cell_names);
    
end        