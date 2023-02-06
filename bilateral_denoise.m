function dn_img = bilateral_denoise(myimg)
    k_size = 1;
    pad_size = 1;
    n_pix_in_k = ((1+(2*k_size))*(1+(2*k_size)));
    dn_img = zeros(size(myimg,1),size(myimg,2));
    sig_c = 2;
    sig_s = 30;

    for row = 1+pad_size:size(myimg,1)-pad_size
        for col = 1+pad_size:size(myimg,2)-pad_size
            numerator = 0;
            denominator = 0;
            cell_val = myimg(row, col);
            

            for k_row = row-k_size:row+k_size
                for k_col = col-k_size:col+k_size
                    k_cell = myimg(k_row,k_col);
                    weight = exp(  -((k_row-row)^2 + (k_col-col)^2)/(2*(sig_c^2))   - sqrt((cell_val - k_cell)^2)/(2*(sig_s^2)));
                    numerator = numerator + (k_cell * weight);
                    denominator = denominator + weight;
                end
            end
            dn_img(row, col) = numerator / denominator;
        end
    end     
end