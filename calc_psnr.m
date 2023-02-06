function val = calc_psnr(noisefreeorig, filtered)
    val = 0;
    divisor = size(noisefreeorig,1) * size(noisefreeorig,2);
    for row = 1:size(noisefreeorig,1)
        for col = 1:size(noisefreeorig,2)
            val = val + (filtered(row,col) - noisefreeorig(row,col))^2;
        end
    end
    val = val * (1/divisor);
    val = (255^2) / val;
    val = 10 * log10(val);
end

