function dn_img = gauss_denoise(myimg)
    k_size = 2;
    pad_size = 2;
    n_pix_in_k = ((1+(2*k_size))*(1+(2*k_size)));
    dn_img = zeros(size(myimg,1),size(myimg,2));

    for row = 1+pad_size:size(myimg,1)-pad_size
        for col = 1+pad_size:size(myimg,2)-pad_size
            numerator = 0;
            denominator = 0;
            cell_val = myimg(row, col);
            
            sigma = 0;
            temp = 0;
            x = myimg(row-k_size:row+k_size, col-k_size:col+k_size);
            k_mean = mean(x,'all');
            for k_row = row-k_size:row+k_size
                for k_col = col-k_size:col+k_size
                    temp = temp + (myimg(k_row, k_col) - k_mean)^2;
                end
            end

            sigma = sqrt((1/(n_pix_in_k-1)) * temp);

            for k_row = row-k_size:row+k_size
                for k_col = col-k_size:col+k_size

                    weight = 1 / ((sqrt(2* pi)) * sigma * exp(  -((k_row-row)^2 + (k_col-col)^2)  /  (2*(sigma^2))   ));
                    k_cell = myimg(k_row,k_col);
                    numerator = numerator + (k_cell * weight);
                    denominator = denominator + weight;
                end
            end
            dn_img(row, col) = numerator / denominator;
        end
    end     
end