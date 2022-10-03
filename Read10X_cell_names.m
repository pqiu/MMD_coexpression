function [raw_cell_names, cell_filename] = Read10X_cell_names(folder_name)

    if ~exist('folder_name','var') || isempty(folder_name)
        folder_name = cd;
    end
    
    % cell names
    fprintf('Loading cell names ... ');
    tic
    fid = fopen(fullfile(folder_name,'barcodes.tsv')); cell_filename = 'barcodes.tsv';
    if fid==-1
        filenames_tmp = getfilenames(folder_name);
        filenames_tmp = filenames_tmp(intersect(isInList(filenames_tmp,'barcode'), isInListEnd(filenames_tmp,'.tsv')));
        fid = fopen(fullfile(folder_name,filenames_tmp{1})); cell_filename = filenames_tmp{1};
    end
    d = fread(fid,[1,inf],'char'); d = char(d); fclose(fid);
    d(d==char(13))=[];
    cell_names = regexp(d,char(10),'split');
    cell_names(end)=[];
    raw_cell_names = cell_names;
    toc

end