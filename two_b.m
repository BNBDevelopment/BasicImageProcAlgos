myimg = readraw("resources/data/images/Pepper_gray_noisy.raw", 240, 400, true);



padded = pad_img(myimg);

bi_img = bilateral_denoise(padded);
bi_fin_img = unpad_img(bi_img);
writtenmyimg = writeraw(bi_fin_img, "bi_dn_gray_pepper.png", true);
%imshow(bi_fin_img)


function padimg = pad_img(myimg)
    pad = 1;
    firstrow = myimg(1:pad,:);
    lastrow = myimg(size(myimg,1)-pad+1:size(myimg,1),:);
    padimg = cat(1,firstrow, myimg, lastrow);
    firstcol = padimg(:,1:pad);
    lastcol = padimg(:,size(padimg,2)-pad+1:size(padimg,2));
    padimg = cat(2,firstcol, padimg, lastcol);
end

function myimg = unpad_img(padimg)
    pad_size = 1;
    myimg = padimg(1+pad_size:size(padimg, 1)-pad_size, 1+pad_size:size(padimg, 2)-pad_size);
end
