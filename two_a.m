myimg = readraw("resources/data/images/Pepper_gray_noisy.raw", 240, 400, true);



padded = pad_img(myimg);

dn_img = linear_denoise(padded);
ln_fin_img = unpad_img(dn_img);
writtenmyimg = writeraw(ln_fin_img, "ln_dn_gray_pepper.png", true);


g_dn_img = gauss_denoise(padded);
g_fin_img = unpad_img(g_dn_img);
writtenmyimg = writeraw(g_fin_img, "gauss_dn_gray_pepper.png", true);






function dn_img = linear_denoise(myimg)
    k_size = 2;
    pad_size = 2;
    n_pix_in_k = ((1+(2*k_size))*(1+(2*k_size)));
    dn_img = zeros(size(myimg,1),size(myimg,2));

    for row = 1+pad_size:size(myimg,1)-pad_size
        for col = 1+pad_size:size(myimg,2)-pad_size
            numerator = 0;
            denominator = 0;
            cell_val = myimg(row, col);
            for k_row = row-k_size:row+k_size
                for k_col = col-k_size:col+k_size
                    weight = 1 / n_pix_in_k;
                    k_cell = myimg(k_row,k_col);
                    numerator = numerator + (k_cell * weight);
                    denominator = denominator + weight;
                end
            end
            dn_img(row, col) = numerator / denominator;
        end
    end     
end

