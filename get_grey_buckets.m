function bucket_arr = get_grey_buckets(img_matrix)
    bucket_arr = zeros(1,256);
    count = 0;
    for loc = 1:numel(img_matrix)
        bucket_arr(1, img_matrix(loc)+1) = bucket_arr(1, img_matrix(loc)+1) + 1;
        count = count + 1;
    end
end