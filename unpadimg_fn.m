function myimg = unpadimg_fn(padimg)
    pad_size = 1;
    myimg = padimg(1+pad_size:size(padimg, 1)-pad_size, 1+pad_size:size(padimg, 2)-pad_size);
end