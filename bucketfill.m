function [b_img, cdf] = bucketfill(myimg)
    cdf = 0;
    counts = zeros(1,256);

    divisor = size(myimg,1) * size(myimg,2);
    img_per_bucket = ceil(divisor / 256);
    b_img = zeros(size(myimg,1), size(myimg,2));
    
    for row = 1:size(myimg,1)
        for col = 1:size(myimg,2)
            pix_idx = myimg(row, col)+1;

            if counts(1, pix_idx) < img_per_bucket
                b_img(row, col) = myimg(row, col);
                counts(1, pix_idx) = counts(1, pix_idx) + 1;
            else
                for x = pix_idx+1:256
                    prev_x = pix_idx-(x-pix_idx);
                    if counts(1, x) < img_per_bucket
                        b_img(row, col) = x-1;
                        counts(1, x) = counts(1, x) + 1;
                        break
                    elseif counts(1, prev_x) < img_per_bucket
                        b_img(row, col) = prev_x-1;
                        counts(1, prev_x) = counts(1, prev_x) + 1;
                        break
                    end
                end
            end
        end
    end


end