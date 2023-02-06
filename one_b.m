myimg = readraw("resources/data/images/DimLight.raw", 340, 596, true);

buckets = get_grey_buckets(myimg);

%bar(buckets)

[test_img, transfer_fn] = eq_hist_buckets(buckets, myimg);

%plot(transfer_fn)

%bar(test_img)

writtenmyimg = writeraw(test_img, "undimmage.png", true);

disp("DONE")


[b_img, cdf] = bucketfill(myimg);

filled_buckets = get_grey_buckets(b_img);
b_cdf = zeros(1,256);
b_cdf(1, 1) = filled_buckets(1, 1);

for loc = 2:numel(b_cdf)
    b_cdf(1, loc) = filled_buckets(1, loc) + b_cdf(1, loc-1);
end
bar(b_cdf)

writtenmyimg = writeraw(b_img, "bucket_undimmage.png", true);
