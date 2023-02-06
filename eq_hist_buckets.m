function [eq_img,cdf_per] = eq_hist_buckets(buckets, myimg)
    cdf = zeros(1,256);
    divisor = size(myimg,1) * size(myimg,2);
    cdf_per = zeros(1,256);

    cdf(1, 1) = buckets(1, 1);
    cdf_per(1,1) = cdf(1, 1) / (divisor);

    for loc = 2:numel(cdf)
        cdf(1, loc) = buckets(1, loc) + cdf(1, loc-1);
        cdf_per(1, loc) = cdf(1, loc) / (divisor);
    end

    eq_img = zeros(size(myimg,1), size(myimg,2));
    for row = 1:size(myimg,1)
        for col = 1:size(myimg,2)
            eq_img(row, col) = fix(cdf_per(myimg(row, col)+1) * 255);
        end
    end

end