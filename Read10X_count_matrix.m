function [raw_data] = Read10X_count_matrix(folder_name, raw_gene_names, raw_cell_names)

    if ~exist('folder_name','var') || isempty(folder_name)
        folder_name = cd;
    end
    
    % raw_data
    fprintf('Loading raw data ... ');
    tic
    fid = fopen(fullfile(folder_name,'matrix.mtx'));
    if fid==-1
        filenames_tmp = getfilenames(folder_name);
        filenames_tmp = filenames_tmp(intersect(isInList(filenames_tmp,'matrix'), isInListEnd(filenames_tmp,'.mtx')));
        fid = fopen(fullfile(folder_name,filenames_tmp{1}));
    end
    d = fread(fid,[1,inf],'char'); d = char(d); fclose(fid); d(d==char(13))=[];
    num_genes = length(raw_gene_names);
    num_cells = length(raw_cell_names);
    
    data_block_start_ind = strfind(d,[char(10), num2str(num_genes),' ', num2str(num_cells),' ']);
    if ~isempty(data_block_start_ind)
        d(1:data_block_start_ind)=[];
        d(d==char(10))=char(9);
        s = str2num(d);
        num_entries = s(3);
        raw = reshape(s(4:end),3,length(s)/3-1);
        toc
        % reformat
        fprintf('Converting data of %d genes * %d cells into matrix ... ',num_genes, num_cells);
        tic
        raw_data = sparse(raw(1,:),raw(2,:), raw(3,:));
        if size(raw_data,1)~=num_genes || size(raw_data,2)~=num_cells
            raw_data(num_genes,num_cells)=0;
        end
        toc
        return
    end        
        
    data_block_start_ind = strfind(d,[char(10), num2str(num_cells),' ', num2str(num_genes),' ']);
    if ~isempty(data_block_start_ind)
        d(1:data_block_start_ind)=[];
        d(d==char(10))=char(9);
        s = str2num(d);
        num_entries = s(3);
        raw = reshape(s(4:end),3,length(s)/3-1);
        toc
        % reformat
        fprintf('Converting data of %d genes * %d cells into matrix ... ',num_genes, num_cells);
        tic
        raw_data = sparse(raw(2,:),raw(1,:), raw(3,:));
        if size(raw_data,1)~=num_genes || size(raw_data,2)~=num_cells
            raw_data(num_genes,num_cells)=0;
        end
        toc
        return
    end        
    
    raw_data = [];
end